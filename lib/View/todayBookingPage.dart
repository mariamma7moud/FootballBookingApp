
import 'package:flutter/material.dart';
import 'package:football_booking_app/DataBase/footballDB.dart';
import 'package:football_booking_app/Model/booking.dart';
import 'package:football_booking_app/Model/stadium.dart';
import 'package:football_booking_app/View/profilePage.dart';
import 'package:football_booking_app/View/startPage.dart';

class TodayBooking extends StatefulWidget {
  const TodayBooking({Key? key}) : super(key: key);

  @override
  _TodayBookingState createState() => _TodayBookingState();
}

class _TodayBookingState extends State<TodayBooking> {

  late List<Booking> bookings;
  bool isLoading = false;

  Future setBookings() async{
    setState(() => isLoading = true);
    bookings = await FootballDatabase.instance.readAllBookings();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    setBookings().whenComplete((){
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('All Bookings'),
          backgroundColor: Colors.redAccent,
          actions: [
            IconButton(
                onPressed:(){
                  runApp(Start());
                },
                icon: Icon(Icons.home),
                tooltip: 'back to home'
            ),
            IconButton(
                onPressed:(){
                  runApp(ProfilePage());
                },
                icon: Icon(Icons.person),
                tooltip: 'Profile'
            )
          ],

        ),
        body: Container(
            child: Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : bookings.isEmpty
                  ? Text(
                'No Bookings yet',
                style: TextStyle(color: Colors.white, fontSize: 34),
              )
                  : buildBookingsView(),
            )
        ),
      ),
    );
  }


  Widget buildBookingsView( ){
    print('build bookings is called');
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //3
                  SafeArea(
                    child: Container(child: buildBookings(),
                      height: 700,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBookings() => ListView(
    padding: EdgeInsets.all(8),
    children: returnList(),
  );

  List<Widget> returnList(){
    print('returnList method is called');
    List<Widget> bookingWidgets = [];
    bookings.forEach((element) async {
      //Stadium stadium = await FootballDatabase.instance.getStadiumNameForBooking('${element.stadiumSlot}');
      Widget w = createBookingWidget(element /*, '${stadium.stadiumName}'*/);
      bookingWidgets.add(w);
      //print('one widget added to list, ${stadium.stadiumName}');
    });
    return bookingWidgets;
  }

  Widget createBookingWidget( Booking booking /*String stadiumName*/){
    return Center(
      child: Container(
        //height: 100,
        color: Colors.grey[300],
        child: ListTile(
          leading: Icon(Icons.bookmark),
          title: Text(
            'Booking ${booking.bookingId}: '//stadium ${stadiumName}
          ),
          subtitle: Text(
            'by ${booking.userEmail}'
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:football_booking_app/View/profilePage.dart';
import 'package:football_booking_app/View/stadiumsPage.dart';
import 'package:football_booking_app/View/todayBookingPage.dart';

class Start extends StatefulWidget {
  //const StartScreen({Key key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stadium Saver'),
          backgroundColor: Colors.redAccent,
          actions: [
            IconButton(
                onPressed:(){
                  runApp(ProfilePage());
                },
                icon: Icon(Icons.person),
                tooltip: 'Profile'
            )
          ],

        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Image(image: AssetImage('images/football.png') ,),
          width: 300,
          height: 250,
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent[100]

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.place_outlined),
                        iconSize: 100,
                        onPressed: ()=> runApp(Stadiums()),
                      ),
                      Text('Book & Play ',  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.bookmark),
                        iconSize: 100,
                        onPressed: ()=> runApp(TodayBooking()),
                      ),
                      Text('All Booking',  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

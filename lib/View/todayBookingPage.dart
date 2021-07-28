
import 'package:flutter/material.dart';
import 'package:football_booking_app/View/profilePage.dart';
import 'package:football_booking_app/View/startPage.dart';

class TodayBooking extends StatefulWidget {
  const TodayBooking({Key? key}) : super(key: key);

  @override
  _TodayBookingState createState() => _TodayBookingState();
}

class _TodayBookingState extends State<TodayBooking> {
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
        body: Center(child: Text('Hi today booking')),
      ),
    );
  }
}

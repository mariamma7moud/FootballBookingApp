import 'package:flutter/material.dart';
import 'package:football_booking_app/View/startPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.redAccent,
          actions: [
            IconButton(
                onPressed:(){
                  runApp(Start());
                },
                icon: Icon(Icons.home),
                tooltip: 'back to home'
            )
          ],

        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                  ),
                  radius: 100.0,
                ),
                Container(
                  height: 200,
                  width: 300,
                  color: Colors.deepOrangeAccent[100],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Full name here'),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person_pin_circle_rounded),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('username here'),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.email),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('email here'),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.bookmark),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('bookings'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}

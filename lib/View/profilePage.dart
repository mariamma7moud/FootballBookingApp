import 'package:flutter/material.dart';
import 'package:football_booking_app/DataBase/footballDB.dart';
import 'package:football_booking_app/Model/person.dart';
import 'package:football_booking_app/Model/slot.dart';
import 'package:football_booking_app/Model/stadium.dart';
import 'package:football_booking_app/View/startPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> stadiumNames= ['stadium 1', 'stadium 2'];
  List<String> slotStart= ['9','10'];
  // int slotID = 2;
  // String stadName= 'Stadium Name';

  late Future person;
  late String email;
  late Person p;

  Future setPerson() async{
    final prefs = await SharedPreferences.getInstance();
    email = prefs.get('email') as String;
    person = FootballDatabase.instance.readPerson(email);
    return person;
  }

  @override
  void initState() {
    super.initState();
    setPerson().whenComplete((){
      setState(() {});
    });
  }

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
          child: FutureBuilder(
            future: person,
            builder: (context, snapshot) {

              switch(snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:return Center(child: CircularProgressIndicator());
                case ConnectionState.done: p = snapshot.data as Person;
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "${p.imageURL}",
                            ),
                            radius: 100.0,
                          ),
                          Container(
                            height: 300,
                            width: 300,
                            color: Colors.deepOrangeAccent[100],
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.person),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${p.fName} ${p.lName}'),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.person_pin_circle_rounded),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${p.username}'),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.email),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${p.email}'),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  );
              }

            },
          )
        ),
      ),
    );
  }
}




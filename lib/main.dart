import 'package:flutter/material.dart';
import 'package:football_booking_app/DataBase/createInstance.dart';
import 'package:football_booking_app/View/loginPage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //final database = openDatabase(join(await getDatabasesPath(), 'footballDB5.db'),);
  CreateInstances c = new CreateInstances();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Booking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
      ),
      home: LoginPage(),
    );
  }
}

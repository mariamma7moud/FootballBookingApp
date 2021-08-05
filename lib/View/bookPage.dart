
import 'package:flutter/material.dart';
import 'package:football_booking_app/DataBase/footballDB.dart';
import 'package:football_booking_app/Model/slot.dart';
import 'package:football_booking_app/Model/stadium.dart';
import 'package:football_booking_app/View/stadiumsPage.dart';
import 'package:football_booking_app/View/startPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookPage extends StatefulWidget {
  final String _stadiumName;
  final String _stadiumID;

  const BookPage( this._stadiumName, this._stadiumID):super();

  @override
  _BookPageState createState() => _BookPageState(_stadiumName, _stadiumID);
}

class _BookPageState extends State<BookPage> {
  Color _color = Colors.grey;
  String _stadiumName= '';
  int _stadiumID=0;

  late List<Slot> slots;
  late Stadium stadium;
  bool isLoading = false;

  Future setSlots() async{
    setState(() => isLoading = true);
    slots = await FootballDatabase.instance.getStadiumSlots(_stadiumID);
    stadium = await FootballDatabase.instance.readStadium(_stadiumName);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    setSlots().whenComplete((){
      setState(() {});
    });
  }

  _BookPageState(String sName, String sID){
    this._stadiumName = sName;
    this._stadiumID= int.parse(sID);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Book Stadium'),
          backgroundColor: Colors.redAccent,
          actions: [
            IconButton(
                onPressed: () {
                  runApp(Start());
                },
                icon: Icon(Icons.home),
                tooltip: 'back to home'
            ),
            IconButton(
                onPressed: () {
                  runApp(Stadiums());
                },
                icon: Icon(Icons.arrow_back),
                tooltip: 'Stadiums'
            )
          ],
        ),
        body: Container(
          child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : slots.isEmpty
                ? Text(
              'No Slots available',
              style: TextStyle(color: Colors.white, fontSize: 24),
            )
                : buildStadiumSlots(context),
          )
        ),
      ),
    );
  }
  Widget buildStadiumSlots( BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //1
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "${stadium.stadiumImage}",
                  ),
                  radius: 100,
                  backgroundColor: Colors.white38,
                ),

                //2
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    //height: 400,
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
                              Icon(Icons.star),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${stadium.stadiumName}'),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${stadium.stadiumLocation}'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //3
                Container(child: buildSlots(),
                height: 300,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildSlots() => ListView(
    padding: EdgeInsets.all(8),
    children: returnList(),
  );

  List<Widget> returnList(){
    List<Widget> slotWidgets = [];
    slots.forEach((element) {
      Widget w = createSlotWidget(element);
      slotWidgets.add(w);
    });
    return slotWidgets;
  }

  Widget createSlotWidget( Slot s){
    return Center(
      child: Container(
        //height: 100,
        color: Colors.grey[300],
        child: ListTile(
          leading: Icon(Icons.timer),
          title: Text(
              'Slot: ${s.slotStart}:00 - ${s.slotEnd}:00 '
          ),
          trailing: IconButton(
            icon: Icon(Icons.bookmark,
            color: _color,
            ),
            onPressed: () async {
              print('pressed');
              final prefs = await SharedPreferences.getInstance();
              bool done = await FootballDatabase.instance.bookSlot('${s.slotId}', _stadiumID, prefs.get('email') as String );
              if (done){
                setState(() {
                  print('done');
                  runApp(Stadiums());
                });
              }else{
                setState(() {
                  print('error ');
                });
              }
            },
          ),
        ),
      ),
    );
  }

}

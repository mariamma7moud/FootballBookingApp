
import 'package:flutter/material.dart';
import 'package:football_booking_app/DataBase/footballDB.dart';
import 'package:football_booking_app/Model/stadium.dart';
import 'package:football_booking_app/View/bookPage.dart';
import 'package:football_booking_app/View/profilePage.dart';
import 'package:football_booking_app/View/startPage.dart';
class Stadiums extends StatefulWidget {
  const Stadiums({Key? key}) : super(key: key);

  @override
  _StadiumsState createState() => _StadiumsState();
}

class _StadiumsState extends State<Stadiums> {
  late List<Stadium> stadiums;
  bool isLoading = false;

  Future setStadiums() async{
    setState(() => isLoading = true);
      this.stadiums = await FootballDatabase.instance.readAllStadiums();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    setStadiums().whenComplete((){
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('All Stadiums'),
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
                    runApp(ProfilePage());
                  },
                  icon: Icon(Icons.person),
                  tooltip: 'Profile'
              )
            ],
          ),
          body: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : stadiums.isEmpty
                ? Text(
              'No Stadiums available',
              style: TextStyle(color: Colors.white, fontSize: 24),
            )
                : buildStadiums(),
          ),
      ),
    );
  }

  Widget buildStadiums() => GridView.count(
    padding: EdgeInsets.all(8),
    crossAxisCount: 2,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: returnList(),
  );

  List<Widget> returnList(){
    List<Widget> stadiumWidgets = [];
    stadiums.forEach((element) {
      Widget w = createStadiumWidget(element);
      stadiumWidgets.add(w);
    });
    return stadiumWidgets;
  }

  Widget createStadiumWidget( Stadium s){
    return InkWell(
      child: Column(
        children: [
          Container(
            color: Colors.redAccent,
            height: 200,
            width: 200,
            child: Image.network(
            '${s.stadiumImage}',
              fit:  BoxFit.cover,
            ),
          ),
          Container(
                color: Colors.white38,
                child: Center(
                  child: Text(
                      '${s.stadiumName}'
                  ),
                ),
          ),

        ],
      ),
      onTap: (){
        print('on tap ${s.stadiumName}');
        runApp(BookPage('${s.stadiumName}','${s.stadiumId}'));
      }
    );

    // return GestureDetector(
    //   onTap: () async {
    //     await Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => NoteDetailPage(noteId: note.id!),
    //     ));
    //
    //     refreshNotes();
    //   },
    //   child: NoteCardWidget(note: note, index: index),
    // );
  }


}
import 'package:flutter/material.dart';
import 'package:football_booking_app/DataBase/footballDB.dart';
import 'package:football_booking_app/Model/person.dart';
import 'package:football_booking_app/View/startPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _imageURL = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //child 1
                Container(
                  child: Image(image: AssetImage('images/football.png') ,),
                  width: 300,
                  height: 250,
                ),

                //child 2
                Column(
                  children: [
                    CreateTextField("Please enter your first name", Icon(Icons.drive_file_rename_outline), _fName, false),
                    CreateTextField("Please enter your last name", Icon(Icons.drive_file_rename_outline), _lName, false),
                    CreateTextField("Please choose a username", Icon(Icons.supervised_user_circle), _userName, false),
                    CreateTextField("Please enter your email", Icon(Icons.email), _email, false),
                    CreateTextField("Please enter your password", Icon(Icons.vpn_key), _password, true),
                    CreateTextField("ass image URL", Icon(Icons.image), _imageURL, false),
                  ],
                ),

                //child 3
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        padding: EdgeInsets.symmetric( horizontal: 60),
                      ),
                      onPressed: () {
                          createPerson(_fName.text, _lName.text, _userName.text, _email.text, _password.text, _imageURL.text);
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => Start()),
                          );
                          saveData(_email.text);
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget CreateTextField(String hinttext, Widget icon, TextEditingController controller, bool isPass){

    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),),
        child: TextFormField(
          obscureText: isPass,
          decoration: InputDecoration(
              labelText: hinttext,
              icon: icon,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)))
          ),
          controller: controller,
          validator: (value) {
            if (value!.isEmpty ) {
              return 'Cannot leave textfield empty';
            }
            return null;
          },
        ),
      ),
    );
  }
  Future<void> saveData(String email) async {
    //SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    //print('${prefs.get('password')}');
  }

  Future<void>createPerson(String fname, String lName, String userName, String email, String password, String imageURL) async {
    final person;
    if(imageURL == null){
      person = Person(
          fName: fname,
          lName: lName,
          username: userName,
          email: email,
          password: password,
          imageURL: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg"
      );

    }else{
      person = Person(
          fName: fname,
          lName: lName,
          username: userName,
          email: email,
          password: password,
          imageURL: imageURL
      );
    }
    return await FootballDatabase.instance.createPerson(person);

  }
}

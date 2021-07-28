
import 'package:flutter/material.dart';
import 'package:football_booking_app/View/registerPage.dart';
import 'package:football_booking_app/View/startPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
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
                    //Email Formfield
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(10.0),),
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                              labelText: 'Enter your email',
                              icon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(32.0)))
                          ),
                          controller: _email,
                          validator: (value) {
                            if (value!.contains('*') || value.contains('#') || value.isEmpty || ! value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    //Password formfield
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(10.0),),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Enter your password',
                              icon: Icon(Icons.vpn_key),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(32.0)))
                          ),
                          controller: _password,
                          validator: (value) {
                            if (value!.length < 6 || value.isEmpty ) {
                              return 'Password has to be at least six characters';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                //child 3
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          padding: EdgeInsets.symmetric( horizontal: 60)
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(builder: (context) => Start()),
                        );

                        //here check creditentials and then redirect if correct
                        //otherwise empty the textfields and snackbar an error message
                      },
                      child: Text('Login'),

                    ),

                    Text("Don't have an account yet ?\n",
                      style: TextStyle(
                          color: Colors.black),
                    ),

                    InkWell(
                        child: Text( "Click here to Sign Up",
                          style: TextStyle(
                              color: Colors.amber,
                              decoration: TextDecoration.underline ),
                        ), onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    }
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
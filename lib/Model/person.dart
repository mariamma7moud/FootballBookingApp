//table name
import 'dart:core';

final String tablePerson = 'Persons';
//table fields
class PersonFields{
  static final String userId = 'userId';
  static final String fName = 'fName';
  static final String lName = 'lName';
  static final String username = 'username';
  static final String email = 'email';
  static final String password = 'password';
  static final String imageURL = 'imageURL';

  static final List<String> values = [
    userId, fName, lName, username, email, password, imageURL
  ];

}

class Person {
  final String? fName;
  final String? lName;
  final String? username;
  final String? email;
  final String? password;
  final String? imageURL;
  final int? userId;

  Person({required this.fName, required this.lName, required this.username, required this.email, required this.password, this.imageURL, this.userId} );

  Person copy({
    String? fName,
    String? lName,
    String? username,
    String? email,
    String? password,
    String? imageURL,
    int? userId,
  })=> Person(
      userId: userId?? this.userId,
      fName: fName?? this.fName,
      lName: lName?? this.lName,
      username: username?? this.username,
      email: email?? this.email,
      password: password?? this.password,
      imageURL: imageURL?? this.imageURL
  );

  //create message object from jscon
  static Person fromJson(Map<String, Object?> json)=> Person(
      userId: json[PersonFields.userId] as int?,
      fName: json[PersonFields.fName] as String?,
      lName: json[PersonFields.lName] as String?,
      username: json[PersonFields.username] as String?,
      email: json[PersonFields.email] as String?,
      password: json[PersonFields.password] as String?,
      imageURL: json[PersonFields.imageURL] as String?,
  );

  //creates from fields a map
  Map<String, Object?> toJson() => {
    PersonFields.userId: userId,
    PersonFields.fName: fName,
    PersonFields.lName: lName,
    PersonFields.username: username,
    PersonFields.email: email,
    PersonFields.password: password,
    PersonFields.imageURL: imageURL,
  };
}
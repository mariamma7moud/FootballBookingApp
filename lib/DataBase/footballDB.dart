import 'dart:convert';

import 'package:football_booking_app/Model/booking.dart';
import 'package:football_booking_app/Model/person.dart';
import 'package:football_booking_app/Model/slot.dart';
import 'package:football_booking_app/Model/stadium.dart';
import 'package:football_booking_app/Model/stadiumSlot.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FootballDatabase {
  int counter = 1;
  static final FootballDatabase instance = FootballDatabase._init();
  static Database? _database;
  FootballDatabase._init();


  //starting up
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('footballdb.db');
    //printing
    print('database returned');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    //printing
    print('database opened');
    return await openDatabase(
        path,
        version: 1,
        onCreate: _createDB
    );
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    //create person
    await db.execute('''
  CREATE TABLE $tablePerson ( 
    ${PersonFields.userId} $idType, 
    ${PersonFields.fName} $textType,
    ${PersonFields.lName} $textType,
    ${PersonFields.username} $textType,
    ${PersonFields.email} $textType,
    ${PersonFields.password} $textType,
    ${PersonFields.imageURL} TEXT
    )
''');
    print('person table created');
    //create stadium
    await db.execute('''
  CREATE TABLE $tableStadium (
    ${StadiumFields.stadiumId} $idType,
    ${StadiumFields.stadiumName} TEXT NOT NULL,
    ${StadiumFields.stadiumLocation} TEXT NOT NULL,
    ${StadiumFields.stadiumImage} TEXT
    )
''');
    print('table Stadium created');
    //create slot
    await db.execute('''
  CREATE TABLE $tableSlot (
    ${SlotFields.slotId} $idType,
    ${SlotFields.slotStart} $integerType,
    ${SlotFields.slotEnd} $integerType
    )
''');
    print('table slot created');
    //create stadium/slot
    await db.execute('''
  CREATE TABLE $tableStadiumSlot (
    ${StadiumSlotFields.stadiumSlotId} $idType,
    ${StadiumSlotFields.slotId} $integerType,
    ${StadiumSlotFields.stadiumId} $integerType,
    ${StadiumSlotFields.isBooked} BOOLEAN NOT NULL,
    FOREIGN KEY (${StadiumSlotFields.slotId}) REFERENCES $tableSlot (${SlotFields.slotId}),
    FOREIGN KEY (${StadiumSlotFields.stadiumId}) REFERENCES $tableStadium (${StadiumFields.stadiumId})
    )
''');
    print('table stadiumSlot created');
    //create booking
    await db.execute('''
  CREATE TABLE $tableBooking (
    ${BookingFields.userEmail} TEXT NOT NULL,
    ${BookingFields.stadiumSlot} $integerType,
    ${BookingFields.bookingId} $idType,
    FOREIGN KEY (${BookingFields.userEmail}) REFERENCES $tablePerson (${PersonFields.email}),
    FOREIGN KEY (${BookingFields.stadiumSlot}) REFERENCES $tableStadiumSlot (${StadiumSlotFields.stadiumSlotId})
    )
''');
    print('table booking created');
  }

  //create objects and instances
  Future<void> createPerson( Person person) async {
    //to get a reference of the db
    final db = await instance.database;
    await db.insert(tablePerson, person.toJson());
  }

  Future<void> createStadium (Stadium stadium) async {
    //to get a reference of the db
    print('stadium created and inserted');
    final db = await instance.database;
    await db.insert(tableStadium, stadium.toJson());
  }

  Future<void> createSlot (Slot slot) async {
    //to get a reference of the db
    print('slot created and inserted');
    final db = await instance.database;
    await db.insert(tableSlot, slot.toJson());
  }

  Future<void> createStadiumSlot (StadiumSlot slot) async {
    //to get a reference of the db
    print('stadiumslot created and inserted');
    final db = await instance.database;
    await db.insert(tableStadiumSlot, slot.toJson());
  }
  Future<void> createBooking (Booking b) async {
    //to get a reference of the db
    print('booking created and inserted');
    final db = await instance.database;
    await db.insert(tableBooking, b.toJson());
  }
  



  Future<Person> readPerson(String email) async {
    final db = await instance.database;
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.email} = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return Person.fromJson(maps.first);
    } else {
      throw Exception('ID $email not found');
    }
  }

  Future<bool> validatePerson(String email, String pass) async {
    print('validator method is called');
    final db = await instance.database;
    final result = await db.rawQuery(
      'SELECT * FROM $tablePerson WHERE ${PersonFields.email} = ? AND ${PersonFields.password} = ?',
        [email, pass]
    );

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
  Future<List<Slot>> getUserSlots(String email) async {
    print('user slot method is called');
    final db = await instance.database;
    // final use = await db.rawQuery(
    //     'SELECT ${PersonFields.userId} FROM $tablePerson WHERE ${PersonFields.email} = ? ',
    //     [email]
    // );
    final stadiumSlotID = await db.rawQuery(
        'SELECT ${BookingFields.stadiumSlot} FROM $tableBooking WHERE ${BookingFields.userEmail} = ? ',
        [email]
    );
    final slotsStartTime = await db.rawQuery(
        'SELECT * FROM $tableBooking WHERE ${SlotFields.slotId} = ? ',
        [stadiumSlotID]
    );
    return slotsStartTime.map((json) => Slot.fromJson(json)).toList();
  }

  // Future<int> update(Note note) async {
  //   final db = await instance.database;
  //
  //   return db.update(
  //     tableNotes,
  //     note.toJson(),
  //     where: '${NoteFields.id} = ?',
  //     whereArgs: [note.id],
  //   );
  // }

  Future<bool> bookSlot(String slotID, int stadiumID, String userEmail) async {
    final db = await instance.database;
    final ssID = await db.query(
        tableStadiumSlot,
        distinct: false,
        columns:[StadiumSlotFields.stadiumSlotId],
        where:'${StadiumSlotFields.slotId} = ? AND ${StadiumSlotFields.stadiumId} = ?',
        whereArgs: [slotID,stadiumID]);
    print(ssID);
    int id = int.parse(ssID[0]['stadiumSlotId'].toString());
    StadiumSlot s = StadiumSlot(
        slotId: int.parse(slotID),
        stadiumId: stadiumID,
        stadiumSlotId: id, //id
        isBooked: true,
    );
    Future<bool> done = this.updateStadiumSlot(s);
    Booking b = Booking(
      userEmail: userEmail,
      stadiumSlot: id,
      bookingId: counter
    );
    this.createBooking(b);
    ++counter;
    return done;
  }

  Future<bool> updateStadiumSlot(StadiumSlot s) async {
    final db = await instance.database;
    bool done =false;
    try{
      done = true;
      db.update(
          tableStadiumSlot,
          s.toJson(),
          where: '${StadiumSlotFields.stadiumSlotId} = ?',
          whereArgs: [s.stadiumSlotId]
      );
    }catch(e){
      print(e);
      done = false;
    }
    return done;
  }

  Future<List<Slot>> getStadiumSlots(int stadiumID) async {
    //print('stadium slot method is called');
    final db = await instance.database;
    final slotIDs = await db.rawQuery(
        'SELECT ${StadiumSlotFields.slotId} FROM $tableStadiumSlot WHERE ${StadiumSlotFields.stadiumId} = ? AND ${StadiumSlotFields.isBooked} = ?',
        [stadiumID, 0]
    );
    List<Slot> result=[];
    slotIDs.forEach((s) async {
      //s is {slotId: 1}
      //print('s is now: $s');
      int id= s['slotId'] as int;
      //print('id is now $id');
      final temp = await db.rawQuery(
          'SELECT * FROM $tableSlot WHERE ${SlotFields.slotId} = ? ',
          [id]);
      print(temp);
      result.add(Slot.fromJson(temp.first));
    });
    print('here printing results all: ${result}');
    return result;
  }

  Future<Stadium> getStadiumName(int slotID) async {
    print('user slot methos method is called');
    final db = await instance.database;
    final stadiumSlotID = await db.rawQuery(
        'SELECT ${StadiumSlotFields.stadiumId} FROM $tableStadiumSlot WHERE ${StadiumSlotFields.slotId} = ? ',
        [slotID]
    );
    final stadium = await db.rawQuery(
        'SELECT * FROM $tableStadium WHERE ${StadiumFields.stadiumId} = ? ',
        [stadiumSlotID]
    );
    if (stadium.isNotEmpty) {
      return Stadium.fromJson(stadium.first);
    } else {
      throw Exception('not found');
    }
  }

  Future<Stadium> getStadiumNameForBooking(String ss) async {
    int stadiumSlotID = int.parse(ss);
    print(' getStadiumName method is called');
    final db = await instance.database;
    final sID = await db.rawQuery(
        'SELECT ${StadiumSlotFields.stadiumId} FROM $tableStadiumSlot WHERE ${StadiumSlotFields.stadiumSlotId} = ? ',
        [stadiumSlotID]
    );
    int stadiumID = sID[0]['stadiumId'] as int;
    final stadium = await db.rawQuery(
        'SELECT * FROM $tableStadium WHERE ${StadiumFields.stadiumId} = ? ',
        [stadiumID]
    );
    //print('here we will print ${stadium}');
    if (stadium.isNotEmpty) {
      return Stadium.fromJson(stadium.first);
    } else {
      throw Exception('not found');
    }
  }

  Future<Stadium> readStadium(String name) async {
    final db = await instance.database;
    final maps = await db.query(
      tableStadium,
      columns: StadiumFields.values,
      where: '${StadiumFields.stadiumName} = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return Stadium.fromJson(maps.first);
    } else {
      throw Exception('ID $name not found');
    }
  }
  //
  Future<Booking> readBooking(int userID, int stadiumSlotID) async {
    final db = await instance.database;
    final maps = await db.rawQuery(
        ' SELECT * FROM $tableBooking WHERE ${BookingFields.userEmail} = ? AND ${BookingFields.stadiumSlot} = ?',
    [userID, stadiumSlotID]);
    if (maps.isNotEmpty) {
      return Booking.fromJson(maps.first);
    } else {
      throw Exception('Not found');
    }
  }

  Future<List<Stadium>> readAllStadiums() async {
    final db = await instance.database;

    final orderBy = '${StadiumFields.stadiumName} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    final result = await db.query(tableStadium, orderBy: orderBy);
    return result.map((json) => Stadium.fromJson(json)).toList();
  }
  Future<List<Booking>> readAllBookings() async {
    final db = await instance.database;
    final result = await db.query(tableBooking);
    return result.map((json) => Booking.fromJson(json)).toList();
  }
  Future<List<Slot>> readAllStadiumSlots(int stadiumID) async {
    final db = await instance.database;
    final slotIDs =
    await db.rawQuery('SELECT ${StadiumSlotFields.slotId} FROM $tableStadiumSlot WHERE ${StadiumSlotFields.stadiumId} = ?', [stadiumID]);
    final result = await db.rawQuery('SELECT * FROM $tableSlot WHERE ${SlotFields.slotId} = ?', [slotIDs]);
    return result.map((json) => Slot.fromJson(json)).toList();
  }

  Future<int> deleteAllBookings() async {
    final db = await instance.database;
    return await db.delete(
      tableBooking,
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
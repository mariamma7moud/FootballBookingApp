import 'package:football_booking_app/DataBase/footballDB.dart';
import 'package:football_booking_app/Model/slot.dart';
import 'package:football_booking_app/Model/stadium.dart';
import 'package:football_booking_app/Model/stadiumSlot.dart';

class CreateInstances {

  CreateInstances(){
    print('im here');
    //createStadiums();
    //createSlots();
    //createStadiumSlots();


  }
  void createStadiumSlots(){
    StadiumSlot s1 = StadiumSlot(
      stadiumId: 1,
      slotId: 1,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s1);
    StadiumSlot s2 = StadiumSlot(
      stadiumId: 1,
      slotId: 2,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s2);
    StadiumSlot s3 = StadiumSlot(
      stadiumId: 1,
      slotId: 3,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s3);
    StadiumSlot s4 = StadiumSlot(
      stadiumId: 1,
      slotId: 4,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s4);



    StadiumSlot s11 = StadiumSlot(
      stadiumId: 2,
      slotId: 3,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s11);
    StadiumSlot s21 = StadiumSlot(
      stadiumId: 2,
      slotId: 4,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s21);
    StadiumSlot s31 = StadiumSlot(
      stadiumId: 2,
      slotId: 5,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s31);
    StadiumSlot s41 = StadiumSlot(
      stadiumId: 2,
      slotId: 6,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s41);



    StadiumSlot s = StadiumSlot(
      stadiumId: 3,
      slotId: 5,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s);
    StadiumSlot s22 = StadiumSlot(
      stadiumId: 3,
      slotId: 6,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s22);
    StadiumSlot s32 = StadiumSlot(
      stadiumId: 3,
      slotId: 7,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s32);
    StadiumSlot s42 = StadiumSlot(
      stadiumId: 3,
      slotId: 8,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s42);



    StadiumSlot s13 = StadiumSlot(
      stadiumId: 4,
      slotId: 1,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s13);
    StadiumSlot s23 = StadiumSlot(
      stadiumId: 4,
      slotId: 2,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s23);
    StadiumSlot s33 = StadiumSlot(
      stadiumId: 4,
      slotId: 8,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s33);
    StadiumSlot s43 = StadiumSlot(
      stadiumId: 4,
      slotId: 9,
      isBooked: false,
    );
    FootballDatabase.instance.createStadiumSlot(s43);


  }

  void createStadiums(){
    Stadium s1 = Stadium(
        stadiumName: 'Gezira Sporting Club',
        stadiumLocation: 'Zamalek',
        stadiumImage: 'https://pbs.twimg.com/profile_images/1316892406776844288/_T-GhQID_400x400.jpg'
    );
    addStadiums(s1);
    Stadium s2 = Stadium(
        stadiumName: 'Shooting Sporting Club',
        stadiumLocation: 'Dokki',
        stadiumImage: 'https://amayei.nyc3.digitaloceanspaces.com/2018/09/shooting_club_-_to_send18.jpg'
    );
    addStadiums(s2);
    Stadium s3 = Stadium(
        stadiumName: 'Zamalek Sporting Club',
        stadiumLocation: 'Agouza',
        stadiumImage: 'https://upload.wikimedia.org/wikipedia/en/thumb/0/04/ZamalekSC.png/180px-ZamalekSC.png'
    );
    addStadiums(s3);
    Stadium s4 = Stadium(
        stadiumName: 'AL Ahly Sporting Club',
        stadiumLocation: 'Zamalek',
        stadiumImage: 'https://media-exp1.licdn.com/dms/image/C561BAQEV_3rstYg9Gg/company-background_10000/0/1576403271401?e=2159024400&v=beta&t=h0Oa_paKDHPMh3wmFMVewBwFqI1EtsDKkvFHRM0cBk8'
    );
    addStadiums(s4);
  }

  void addStadiums(Stadium s){
    FootballDatabase.instance.createStadium(s);
  }

  void createSlots(){
    Slot s1 = Slot(
      slotStart: 9,
      slotEnd: 10
    ); addSlots(s1);
    Slot s2 = Slot(
        slotStart: 10,
        slotEnd: 11
    );addSlots(s2);
    Slot s3 = Slot(
        slotStart: 11,
        slotEnd: 12
    );addSlots(s3);
    Slot s4 = Slot(
        slotStart: 12,
        slotEnd: 13
    );addSlots(s4);
    Slot s5 = Slot(
        slotStart: 13,
        slotEnd: 14
    );addSlots(s5);
    Slot s6 = Slot(
        slotStart: 14,
        slotEnd: 15
    );addSlots(s6);
    Slot s7 = Slot(
        slotStart: 15,
        slotEnd: 16
    );addSlots(s7);
    Slot s8 = Slot(
        slotStart: 16,
        slotEnd: 17
    );addSlots(s8);
    Slot s9 = Slot(
        slotStart: 17,
        slotEnd: 18
    );addSlots(s9);
    Slot s10 = Slot(
        slotStart: 18,
        slotEnd: 19
    );addSlots(s10);

  }

  void addSlots(Slot s){
    FootballDatabase.instance.createSlot(s);
  }





}

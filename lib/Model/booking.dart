final String tableBooking = 'Bookings';
//table fields
class BookingFields{
  static final String userId = 'userId';
  static final String stadiumSlot = 'stadiumSlot';

  static final List<String> values = [
    userId, stadiumSlot
  ];

}

class Booking {
  final int? stadiumSlot;
  final int? userId;

  Booking({this.stadiumSlot,  this.userId} );

  Booking copy({
    int? stadiumSlot,
    int? userId,
  })=> Booking(
      userId: userId?? this.userId,
      stadiumSlot: stadiumSlot?? this.stadiumSlot,
  );

  //create message object from jscon
  static Booking fromJson(Map<String, Object?> json)=> Booking(
    userId: json[BookingFields.userId] as int?,
    stadiumSlot: json[BookingFields.stadiumSlot] as int?,
  );

  //creates from fields a map
  Map<String, Object?> toJson() => {
    BookingFields.userId: userId,
    BookingFields.stadiumSlot: stadiumSlot,
  };
}
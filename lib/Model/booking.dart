final String tableBooking = 'Bookings';
//table fields
class BookingFields{
  static final String userEmail = 'userEmail';
  static final String stadiumSlot = 'stadiumSlot';
  static final String bookingId = 'bookingId';

  static final List<String> values = [
    userEmail, stadiumSlot, bookingId
  ];

}

class Booking {
  final int? stadiumSlot;
  final String? userEmail;
  final int? bookingId;

  Booking( {this.stadiumSlot,  this.userEmail, this.bookingId,} );

  Booking copy({
    int? stadiumSlot,
    String? userEmail,
    int? bookingId,
  })=> Booking(
      userEmail: userEmail?? this.userEmail,
      stadiumSlot: stadiumSlot?? this.stadiumSlot,
      bookingId: bookingId?? this.bookingId
  );

  //create message object from jscon
  static Booking fromJson(Map<String, Object?> json)=> Booking(
      userEmail: json[BookingFields.userEmail] as String?,
    stadiumSlot: json[BookingFields.stadiumSlot] as int?,
    bookingId: json[BookingFields.bookingId] as int?
  );

  //creates from fields a map
  Map<String, Object?> toJson() => {
    BookingFields.userEmail: userEmail,
    BookingFields.stadiumSlot: stadiumSlot,
    BookingFields.bookingId: bookingId
  };
}
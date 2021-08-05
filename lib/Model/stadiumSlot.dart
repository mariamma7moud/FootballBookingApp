final String tableStadiumSlot = 'StadiumSlots';
//table fields stadiumSlotId
class StadiumSlotFields{
  static final String stadiumSlotId = 'stadiumSlotId';
  static final String slotId = 'slotId';
  static final String stadiumId = 'stadiumId';
  static final String isBooked = 'isBooked';

  static final List<String> values = [
    slotId, stadiumId, stadiumSlotId, isBooked
  ];
}

class StadiumSlot {
  final int? stadiumId;
  final int? slotId;
  final bool isBooked;
  final int? stadiumSlotId;

  StadiumSlot({this.stadiumId,  this.slotId, required this.isBooked, this.stadiumSlotId} );

  StadiumSlot copy({
    int? stadiumId,
    int? slotId,
    bool? isBooked,
    int? stadiumSlotId
  })=> StadiumSlot(
    slotId: slotId?? this.slotId,
    stadiumSlotId: stadiumSlotId?? this.stadiumSlotId,
    isBooked: isBooked?? this.isBooked,
    stadiumId: stadiumId?? this.stadiumId,
  );

  //create message object from jscon
  static StadiumSlot fromJson(Map<String, Object?> json)=> StadiumSlot(
    slotId: json[StadiumSlotFields.slotId] as int?,
    stadiumId: json[StadiumSlotFields.stadiumId] as int?,
    isBooked: json[StadiumSlotFields.isBooked]  == 1,
    stadiumSlotId: json[StadiumSlotFields.stadiumSlotId] as int?,
  );

  //creates from fields a map
  Map<String, Object?> toJson() => {
    StadiumSlotFields.slotId: slotId,
    StadiumSlotFields.stadiumId: stadiumId,
    StadiumSlotFields.isBooked: isBooked ? 1:0,
    StadiumSlotFields.stadiumSlotId: stadiumSlotId,
  };
}
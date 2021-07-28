final String tableStadiumSlot = 'StadiumSlots';
//table fields
class StadiumSlotFields{
  static final String slotId = 'slotId';
  static final String stadiumId = 'stadiumId';

  static final List<String> values = [
    slotId, stadiumId
  ];
}

class StadiumSlot {
  final int? stadiumId;
  final int? slotId;

  StadiumSlot({this.stadiumId,  this.slotId} );

  StadiumSlot copy({
    int? stadiumId,
    int? slotId,
  })=> StadiumSlot(
    slotId: slotId?? this.slotId,
    stadiumId: stadiumId?? this.stadiumId,
  );

  //create message object from jscon
  static StadiumSlot fromJson(Map<String, Object?> json)=> StadiumSlot(
    slotId: json[StadiumSlotFields.slotId] as int?,
    stadiumId: json[StadiumSlotFields.stadiumId] as int?,
  );

  //creates from fields a map
  Map<String, Object?> toJson() => {
    StadiumSlotFields.slotId: slotId,
    StadiumSlotFields.stadiumId: stadiumId,
  };
}
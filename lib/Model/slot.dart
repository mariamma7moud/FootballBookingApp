

final String tableSlot = 'Slots';


//table fields
class SlotFields{
  static final String slotId = 'slotId';
  static final String slotStart = 'slotStart';
  static final String slotEnd = 'slotEnd';

  static final List<String> values = [
    slotId, slotStart, slotEnd
  ];
}

class Slot {
  final int? slotId;
  final int? slotStart;
  final int? slotEnd;

  Slot({this.slotId, this.slotStart, this.slotEnd} );

  Slot copy({
    int? slotId,
    int? slotStart,
    int? slotEnd,
  })=> Slot(
    slotId: slotId?? this.slotId,
    slotStart: slotStart?? this.slotStart,
    slotEnd: slotEnd?? this.slotEnd,
  );

  //create message object from jscon
  static Slot fromJson(Map<String, Object?> json)=> Slot(
    slotId: json[SlotFields.slotId] as int?,
    slotStart: json[SlotFields.slotStart] as int?,
    slotEnd: json[SlotFields.slotEnd] as int?,
  );

  //creates from fields a map
  Map<String, Object?> toJson() => {
    SlotFields.slotId: slotId,
    SlotFields.slotStart: slotStart,
    SlotFields.slotEnd: slotEnd,
  };
}
final String tableStadium = 'Stadiums';
//table fields
class StadiumFields{
  static final String stadiumId = 'stadiumId';
  static final String stadiumName = 'stadiumName';
  static final String stadiumLocation = 'stadiumLocation';

  static final List<String> values = [
    stadiumId, stadiumName, stadiumLocation
  ];

}

class Stadium {
  final int? stadiumId;
  final String? stadiumName;
  final String? stadiumLocation;

  Stadium({this.stadiumId, this.stadiumName, this.stadiumLocation} );

  Stadium copy({
    int? stadiumId,
    String? stadiumName,
    String? stadiumLocation,
  })=> Stadium(
      stadiumId: stadiumId?? this.stadiumId,
      stadiumName: stadiumName?? this.stadiumName,
      stadiumLocation: stadiumLocation?? this.stadiumLocation,
  );

  //create message object from jscon
  static Stadium fromJson(Map<String, Object?> json)=> Stadium(
    stadiumId: json[StadiumFields.stadiumId] as int?,
    stadiumName: json[StadiumFields.stadiumName] as String?,
    stadiumLocation: json[StadiumFields.stadiumLocation] as String?,
  );

  //creates from fields a map
  Map<String, Object?> toJson() => {
    StadiumFields.stadiumId: stadiumId,
    StadiumFields.stadiumName: stadiumName,
    StadiumFields.stadiumLocation: stadiumLocation,
  };
}
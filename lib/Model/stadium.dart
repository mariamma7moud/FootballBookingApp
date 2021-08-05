final String tableStadium = 'Stadiums';
//table fields
class StadiumFields{
  static final String stadiumId = 'stadiumId';
  static final String stadiumName = 'stadiumName';
  static final String stadiumLocation = 'stadiumLocation';
  static final String stadiumImage = 'stadiumImage';

  static final List<String> values = [
    stadiumId, stadiumName, stadiumLocation, stadiumImage
  ];

}

class Stadium {
  final int? stadiumId;
  final String? stadiumName;
  final String? stadiumLocation;
  final String? stadiumImage;

  Stadium({this.stadiumId, this.stadiumName, this.stadiumLocation, this.stadiumImage} );

  Stadium copy({
    int? stadiumId,
    String? stadiumName,
    String? stadiumLocation,
    String? stadiumImage
  })=> Stadium(
      stadiumId: stadiumId?? this.stadiumId,
      stadiumName: stadiumName?? this.stadiumName,
      stadiumLocation: stadiumLocation?? this.stadiumLocation,
      stadiumImage: stadiumImage?? this.stadiumImage
  );

  //create message object from jscon
  static Stadium fromJson(Map<String, Object?> json)=> Stadium(
    stadiumId: json[StadiumFields.stadiumId] as int?,
    stadiumName: json[StadiumFields.stadiumName] as String?,
    stadiumLocation: json[StadiumFields.stadiumLocation] as String?,
    stadiumImage: json[StadiumFields.stadiumImage] as String?
  );

  //creates from fields a map
  Map<String, Object?> toJson() => {
    StadiumFields.stadiumId: stadiumId,
    StadiumFields.stadiumName: stadiumName,
    StadiumFields.stadiumLocation: stadiumLocation,
    StadiumFields.stadiumImage: stadiumImage
  };
}
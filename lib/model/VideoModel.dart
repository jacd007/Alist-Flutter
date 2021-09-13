class VideoModel {
  int? id;
  String? name;
  String? image;
  String? date;
  String? day;
  int? state;
  int? capitule;

  VideoModel(
      {this.id,
      this.name,
      this.capitule,
      this.image,
      this.date,
      this.day,
      this.state});

  //---- set
  set setId(int value) => state = value;
  set setName(String value) => this.name = value;
  set setCap(int value) => capitule = value;
  set setImage(String value) => this.image = value;
  set setDate(String value) => this.date = value;
  set setDay(String value) => this.day = value;
  set setState(int value) => state = value;

  //
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'capitule': capitule,
      'date': date,
      'day': day,
      'state': state,
    };
  }
}

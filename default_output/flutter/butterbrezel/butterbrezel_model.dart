class ButterBrezelModel
{
  static const String TABLE_NAME = 'ButterBrezel';

  String? butter_brezel_uuid;
  int? age;
  int? weight;
  String? name;

  ButterBrezelModel.fromMap(Map<dynamic, dynamic> map)
  {
    this.butter_brezel_uuid = map['butter_brezel_uuid'];
    this.age = map['age'];
    this.weight = map['weight'];
    this.name = map['name'];
  }

  Map<String, Object?> toMap() {
    return {
      "butter_brezel_uuid": butter_brezel_uuid,
      "age": age,
      "weight": weight,
      "name": name
    };
  }


}

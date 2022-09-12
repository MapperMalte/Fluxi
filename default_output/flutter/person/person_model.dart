class PersonModel
{
  static const String TABLE_NAME = 'Person';

  String? person_uuid;
  String? name;
  int? age;

  PersonModel.fromMap(Map<dynamic, dynamic> map)
  {
    this.person_uuid = map['person_uuid'];
    this.name = map['name'];
    this.age = map['age'];
  }

  Map<String, Object?> toMap() {
    return {
      "person_uuid": person_uuid,
      "name": name,
      "age": age
    };
  }


}

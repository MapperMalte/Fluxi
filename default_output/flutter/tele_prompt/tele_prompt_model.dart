class TelePromptModel
{
  static const String TABLE_NAME = 'TelePrompt';

  static const String COLUMN_tele_prompt_uuid = "tele_prompt_uuid";
  static const String COLUMN_name = "name";
  static const String COLUMN_age = "age";

  String? tele_prompt_uuid;
  String? name;
  int? age;

  TelePromptModel.fromMap(Map<dynamic, dynamic> map)
  {
    this.tele_prompt_uuid = map['tele_prompt_uuid'];
    this.name = map['name'];
    this.age = map['age'];
  }

  Map<String, Object?> toMap() {
    return {
      "tele_prompt_uuid": tele_prompt_uuid,
      "name": name,
      "age": age
    };
  }


}

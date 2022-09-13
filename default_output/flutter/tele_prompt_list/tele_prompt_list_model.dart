class TelePromptListModel
{
  static const String TABLE_NAME = 'TelePromptList';

  String? tele_prompt_list_uuid;
  String? name;
  String? owner;

  TelePromptListModel.fromMap(Map<dynamic, dynamic> map)
  {
    this.tele_prompt_list_uuid = map['tele_prompt_list_uuid'];
    this.name = map['name'];
    this.owner = map['owner'];
  }

  Map<String, Object?> toMap() {
    return {
      "tele_prompt_list_uuid": tele_prompt_list_uuid,
      "name": name,
      "owner": owner
    };
  }


}

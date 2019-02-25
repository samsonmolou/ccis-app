import 'dart:convert';

//TODO: Refactoring to use metadata instead of plain String
class BroadcastListEntity {
  final String id;
  final String name;
  final List<String> membersId;

  BroadcastListEntity(this.id, this.name, this.membersId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroadcastListEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          membersId == other.membersId;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ membersId.hashCode;

  @override
  String toString() {
    return 'BroadcastListEntity{id: $id, name: $name, membersId: $membersId}';
  }

  static BroadcastListEntity fromJson(Map<String, Object> json) {
    Iterable membersIdMap = jsonDecode(json["membersId"]);
    List<String> membersId = List<String>.from(membersIdMap);
    return BroadcastListEntity(
      json["id"] as String,
      json["name"] as String,
      membersId
    );
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "name": name,
      "membersId": jsonEncode(membersId)
    };
  }
}

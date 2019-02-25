//TODO: Refactoring to use metadata instead of plain String
class CommunityEntity {
  final String id;
  final String name;

  CommunityEntity(this.id, this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CommunityEntity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Community{id: $id, name: $name }';
  }

  static CommunityEntity fromJson(Map<String, Object> json) {
    return CommunityEntity(
      json["id"] as String,
      json["name"] as String
    );
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "name": name
    };
  }
}
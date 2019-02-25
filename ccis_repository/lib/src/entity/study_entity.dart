//TODO: Refactoring to use metadata instead of plain String
class StudyEntity {
  final String id;
  final String name;

  StudyEntity(this.id, this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is StudyEntity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Study{id: $id, name: $name }';
  }

  static StudyEntity fromJson(Map<String, Object> json) {
    return StudyEntity(
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
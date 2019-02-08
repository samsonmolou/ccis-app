class BroadcastListEntity {
  final String id;
  final String name;

  BroadcastListEntity(this.id, this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BroadcastListEntity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'BroadcastListEntity{id: $id, name: $name }';
  }

  static BroadcastListEntity fromJson(Map<String, Object> json) {
    return BroadcastListEntity(
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


class BroadcastEntity {
  final String id;
  final String message;
  final String broadcastListId;
  final int rank;
  final String dateTime;
  final String name;

  BroadcastEntity(
      this.id, this.rank, this.broadcastListId, this.message, this.dateTime, this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroadcastEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          rank == other.rank &&
          broadcastListId == other.broadcastListId &&
          dateTime == other.dateTime &&
          name == other.name;

  @override
  int get hashCode =>
      id.hashCode ^
      rank.hashCode ^
      broadcastListId.hashCode ^
      message.hashCode ^
      dateTime.hashCode ^
      name.hashCode;

  @override
  String toString() {
    return 'BroadcastEntity{'
        'id: $id, '
        'rank: $rank, '
        'broadcastListId: $broadcastListId, '
        'dateTime: $dateTime'
        'name: $name}';
  }

  static BroadcastEntity fromJson(Map<String, Object> json) {
    return BroadcastEntity(
        json["id"] as String,
        json["rank"] as int,
        json["broadcastListId"] as String,
        json["message"] as String,
        json["dateHeure"] as String,
        json["name"] as String);
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "rank": rank,
      "broadcastListId": broadcastListId,
      "message": message,
      "dateTime": dateTime,
      "name": name
    };
  }
}

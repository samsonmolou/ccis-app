

class BroadcastEntity {
  final String id;
  final String message;
  final String broadcastListId;
  final int rank;
  final String dateHeure;

  BroadcastEntity(
      this.id, this.rank, this.broadcastListId, this.message, this.dateHeure);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroadcastEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          rank == other.rank &&
          broadcastListId == other.broadcastListId &&
          dateHeure == other.dateHeure;

  @override
  int get hashCode =>
      id.hashCode ^
      rank.hashCode ^
      broadcastListId.hashCode ^
      message.hashCode ^
      dateHeure.hashCode;

  @override
  String toString() {
    return 'BroadcastEntity{'
        'id: $id, '
        'rank: $rank, '
        'broadcastListId: $broadcastListId, '
        'dateHeure: $dateHeure}';
  }

  static BroadcastEntity fromJson(Map<String, Object> json) {
    return BroadcastEntity(
        json["id"] as String,
        json["rank"] as int,
        json["broadcastListId"] as String,
        json["message"] as String,
        json["dateHeure"] as String);
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "rank": rank,
      "broadcastListId": broadcastListId,
      "message": message,
      "dateHeure": dateHeure
    };
  }
}

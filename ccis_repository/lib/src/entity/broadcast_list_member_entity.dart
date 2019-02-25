
//TODO: Refactoring to use metadata instead of plain String
class BroadcastListMemberEntity {
  final String id;
  final String memberId;
  final String broadcastListId;

  BroadcastListMemberEntity(this.id, this.memberId, this.broadcastListId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BroadcastListMemberEntity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              memberId == other.memberId &&
              broadcastListId == other.broadcastListId;

  @override
  int get hashCode => id.hashCode ^ memberId.hashCode ^ broadcastListId.hashCode;

  @override
  String toString() {
    return 'BroadcastListEntity{id: $id, memberId: $memberId, broadcastListId: $broadcastListId }';
  }

  static BroadcastListMemberEntity fromJson(Map<String, Object> json) {
    return BroadcastListMemberEntity(
        json["id"] as String,
        json["memberId"] as String,
        json["broadcastListId"] as String
    );
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "memberId": memberId,
      "broadcastListId": broadcastListId
    };
  }
}
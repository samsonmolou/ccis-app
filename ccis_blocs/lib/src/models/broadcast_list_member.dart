import 'package:ccis_blocs/src/helpers/uuid.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';

@immutable
class BroadcastListMember {
  final String id;
  final String memberId;
  final String broadcastListId;

  //TODO: make name required
  BroadcastListMember(
      {String id, String memberId = '', String broadcastListId = ''})
      : this.memberId = memberId ?? '',
        this.broadcastListId = broadcastListId ?? '',
        this.id = id ?? Uuid().generateV4();

  BroadcastListMember copyWith(
      {String id, String memberId = '', String broadcastListId = ''}) {
    return BroadcastListMember(
        id: id ?? this.id,
        memberId: memberId ?? this.memberId,
        broadcastListId: broadcastListId ?? this.broadcastListId);
  }

  @override
  int get hashCode {
    return id.hashCode ^ memberId.hashCode ^ broadcastListId.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BroadcastListMember &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            memberId == other.memberId &&
            broadcastListId == broadcastListId;
  }

  @override
  String toString() {
    return 'BroadcastListMember{id: $id, '
        'memberId: $memberId'
        'broadcastListId: $broadcastListId}';
  }

  BroadcastListMemberEntity toEntity() {
    return BroadcastListMemberEntity(id, memberId, broadcastListId);
  }

  static BroadcastListMember fromEntity(BroadcastListMemberEntity entity) {
    return BroadcastListMember(
      id: entity.id ?? Uuid().generateV4(),
      memberId: entity.memberId,
      broadcastListId: entity.broadcastListId
    );
  }
}

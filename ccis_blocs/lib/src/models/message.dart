import 'package:ccis_blocs/src/helpers/uuid.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';

@immutable
class Message {
  final String id;
  final String broadcastId;
  final String memberId;
  final int isWaiting;
  final int isSent;
  final int isReceived;
  final String content;
  final String receivedAt;
  final String sentAt; // Date d'envoi du message

  Message(
      {String id,
      String broadcastId,
      String memberId,
      int isWaiting = 1,
      int isSent = 0,
      int isReceived = 0,
      String content,
      String sentAt,
      String receivedAt})
      : this.broadcastId = broadcastId ?? '',
        this.memberId = memberId ?? '',
        this.isWaiting = isWaiting ?? 1,
        this.isSent = isSent ?? 0,
        this.isReceived = isReceived ?? 0,
        this.content = content ?? '',
        this.sentAt = sentAt ?? '',
        this.receivedAt = receivedAt ?? '',
        this.id = id ?? Uuid().generateV4();

  Message copyWith(
      {String id,
      String broadcastId,
      String memberId,
      int isWaiting,
      int isSent,
      int isReceived,
      String content,
      String sentAt,
      String receivedAt}) {
    return Message(
        id: id ?? this.id,
        broadcastId: broadcastId ?? this.broadcastId,
        memberId: memberId ?? this.memberId,
        isWaiting: isWaiting ?? this.isWaiting,
        isSent: isSent ?? this.isSent,
        isReceived: isReceived ?? this.isReceived,
        content: content ?? this.content,
        sentAt: sentAt ?? this.sentAt);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        broadcastId.hashCode ^
        memberId.hashCode ^
        isWaiting.hashCode ^
        isSent.hashCode ^
        isReceived.hashCode ^
        sentAt.hashCode ^
        content.hashCode ^
        receivedAt.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Message &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            broadcastId == other.broadcastId &&
            memberId == other.memberId &&
            isWaiting == other.isWaiting &&
            isSent == other.isSent &&
            isReceived == other.isReceived &&
            content == other.content &&
            sentAt == other.sentAt &&
            receivedAt == other.receivedAt;
  }

  @override
  String toString() {
    return '${MessagesMetadata.tableName}{${MessagesMetadata.id}: $id, '
        '${MessagesMetadata.broadcastId}: $broadcastId, '
        '${MessagesMetadata.memberId}: $memberId,'
        '${MessagesMetadata.isWaiting}: $isWaiting,'
        '${MessagesMetadata.isSent}: $isSent,'
        '${MessagesMetadata.isReceived}: $isReceived,'
        '${MessagesMetadata.content}: $content,'
        '${MessagesMetadata.sentAt}: $sentAt,'
        '${MessagesMetadata.receivedAt}: $receivedAt}';
  }

  MessageEntity toEntity() {
    return MessageEntity(id, broadcastId, memberId, isWaiting, isSent,
        isReceived, content, sentAt, receivedAt);
  }

  static Message fromEntity(MessageEntity entity) {
    return Message(
      id: entity.id ?? Uuid().generateV4(),
      broadcastId: entity.broadcastId,
      memberId: entity.memberId,
      isWaiting: entity.isWaiting,
      isSent: entity.isSent,
      isReceived: entity.isReceived,
      content: entity.content,
      sentAt: entity.sentAt,
      receivedAt: entity.receivedAt
    );
  }
}

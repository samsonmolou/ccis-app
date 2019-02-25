
import 'package:ccis_repository/src/metadata/messages_metadata.dart';

class MessageEntity {
  final String id;
  final String broadcastId;
  final String memberId;
  final bool isWaiting;
  final bool isSent;
  final bool isReceived;
  final String content;
  final String sentAt;
  final String receivedAt;

  MessageEntity(this.id, this.broadcastId, this.memberId, this.isWaiting,
      this.isSent, this.isReceived, this.content, this.sentAt, this.receivedAt);

  @override
  int get hashCode {
    return id.hashCode ^
        broadcastId.hashCode ^
        memberId.hashCode ^
        isWaiting.hashCode ^
        isSent.hashCode ^
        isReceived.hashCode ^
        content.hashCode ^
        sentAt.hashCode ^
        receivedAt.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MessageEntity &&
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

  Map<String, Object> toJson() {
    return {
      MessagesMetadata.id: id,
      MessagesMetadata.broadcastId: broadcastId,
      MessagesMetadata.memberId: memberId,
      MessagesMetadata.isWaiting: isWaiting,
      MessagesMetadata.isSent: isSent,
      MessagesMetadata.isReceived: isReceived,
      MessagesMetadata.content: content,
      MessagesMetadata.sentAt: sentAt,
      MessagesMetadata.receivedAt: receivedAt
    };
  }

  @override
  String toString() {
    return '${MessagesMetadata.tableName}{${MessagesMetadata.id}: $id, '
        '${MessagesMetadata.broadcastId}: $broadcastId, '
        '${MessagesMetadata.memberId}: $memberId,'
        '${MessagesMetadata.isWaiting}: $isWaiting'
        '${MessagesMetadata.isSent}: $isSent'
        '${MessagesMetadata.isReceived}: $isReceived'
        '${MessagesMetadata.content}: $content'
        '${MessagesMetadata.sentAt}: $sentAt'
        '${MessagesMetadata.receivedAt}: $receivedAt}';
  }

  static MessageEntity fromJson(Map<String, Object> json) {

    return MessageEntity(
        json[MessagesMetadata.id] as String,
        json[MessagesMetadata.broadcastId] as String,
        json[MessagesMetadata.memberId] as String,
        json[MessagesMetadata.isWaiting] as bool,
        json[MessagesMetadata.isSent] as bool,
        json[MessagesMetadata.isReceived] as bool,
        json[MessagesMetadata.content] as String,
        json[MessagesMetadata.sentAt] as String,
        json[MessagesMetadata.receivedAt] as String
    );
  }
}

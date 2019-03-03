import 'package:sms/sms.dart';

import 'message.dart';

class MessagePayload {
  final List<Message> messages;
  final SimCard simCard;

  MessagePayload({List<Message> messages, SimCard simCard})
      : this.messages = messages,
        this.simCard = simCard;

  MessagePayload copyWith({List<Message> messages, SimCard simCard}) {
    return MessagePayload(
      messages: messages ?? this.messages,
      simCard: simCard ?? this.simCard
    );
  }

  @override
  int get hashCode {
    return messages.hashCode ^ simCard.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MessagePayload &&
            runtimeType == other.runtimeType &&
            messages == other.messages &&
            simCard == other.simCard;
  }

  @override
  String toString() {
    return 'MessagePayload{messages: $messages, simCard: $simCard}';
  }
}

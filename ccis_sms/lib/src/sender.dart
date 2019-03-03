import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:sms/sms.dart';
import 'package:meta/meta.dart';

/// Interface
abstract class Sender {
  Future<void> sendMessages(List<Message> messages, SimCard simCard);
}

class CcisSender extends Sender {
  final MessagesInteractor messagesInteractor;

  CcisSender({@required messageInteractor})
      : this.messagesInteractor = messageInteractor;

  @override
  Future<void> sendMessages(List<Message> messages, SimCard simCard) async {
    // TODO: implement sendMessages
    messages.forEach((message) => print(message));
  }
}

import 'dart:async';

import 'package:ccis_blocs/src/interactors/messages_interactor.dart';
import 'package:ccis_blocs/src/models/models.dart';

class MessageBloc {
  // Inputs
  final Sink<String> deleteMessage;
  final Sink<Message> updateMessage;

  final MessagesInteractor _interactor;
  final List<StreamSubscription<dynamic>> _subscriptions;

  MessageBloc._(
      this.deleteMessage,
      this.updateMessage,
      this._interactor,
      this._subscriptions
      );

  factory MessageBloc(MessagesInteractor interactor) {
    final removeMessageController = StreamController<String>(sync: true);
    final updateMessageController = StreamController<Message>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user updates an item, update the repository
      updateMessageController.stream.listen(interactor.updateMessage),

      // When a user removes an item, remove it from the repository
      removeMessageController.stream.listen(interactor.deleteMessage),
    ];

    return MessageBloc._(
      removeMessageController,
      updateMessageController,
      interactor,
      subscriptions,
    );
  }

  Stream<Message> message(String id) {
    return _interactor.message(id);
  }

  void close() {
    deleteMessage.close();
    updateMessage.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}
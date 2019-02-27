import 'dart:async';

import 'package:ccis_blocs/src/interactors/messages_interactor.dart';
import 'package:ccis_blocs/src/interactors/members_interactor.dart';
import 'package:ccis_blocs/src/helpers/parser.dart';
import 'package:ccis_blocs/src/models/models.dart';
import 'package:rxdart/rxdart.dart';

class MessagesBroadcastingBloc {
  // Data

  // Inputs
  final Sink<List<Message>> addMessages;
  final Sink<String> deleteMessage;
  final Sink<Message> updateMessage;
  final Sink<String> searchMessage;

  // Outputs
  final Stream<List<Message>> messages;
  final Stream<List<Message>> searchMessageResult;

  // Cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory MessagesBroadcastingBloc(MessagesInteractor interactor) {
    // We'll use a series of StreamControllers to glue together our inputs and
    // outputs.
    //
    // StreamControllers have both a Sink and a Stream. We'll expose the Sinks
    // publicly so users can send information to the Bloc. We'll use the Streams
    // internally to react to that user input.
    final addMessagesController = StreamController<List<Message>>(sync: true);
    final deleteMessageController = StreamController<String>(sync: true);
    final updateMessageController = StreamController<Message>(sync: true);
    final searchMessageController = BehaviorSubject<String>(sync: true);

    // In some cases, we need to simply route user interactions to our data
    // layer. In this case, we'll listen to the streams. In order to clean
    // these subscriptions up, we'll pop them in a list and ensure we cancel
    // all of them in the `close` method when they are no longer needed.
    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user adds an item, add it to the repository
      addMessagesController.stream.listen(interactor.addMessages),
      deleteMessageController.stream.listen(interactor.deleteMessage),
      updateMessageController.stream.listen(interactor.updateMessage),
    ];

    // To calculate the result of search, we combine the members with the current
    // search key and return the result of the search.
    //
    // Every time the members or the search query changes the visible items will emit
    // once again. We also convert the normal Stream into a BehaviorSubject
    // so the Stream can be listened to multiple times
    final searchMessageResultController = BehaviorSubject<List<Message>>();

    Observable.combineLatest2<List<Message>, String, List<Message>>(
      interactor.messages,
      searchMessageController.stream,
      _searchBroadcastList,
    ).pipe(searchMessageResultController);

    return MessagesBroadcastingBloc._(
      addMessagesController,
      deleteMessageController,
      updateMessageController,
      searchMessageController,
      searchMessageResultController,
      interactor.messages,
      subscriptions,
    );
  }

  MessagesBroadcastingBloc._(
      this.addMessages,
      this.deleteMessage,
      this.updateMessage,
      this.searchMessage,
      this.searchMessageResult,
      this.messages,
      this._subscriptions);

  static List<Message> _searchBroadcastList(
      List<Message> messages, String query) {
    final Iterable<Message> suggestions =
    messages.where((message) => message.content.contains(query));

    return suggestions.toList();
  }

  Stream<List<Message>> waitingMessages(Broadcast broadcast,
      List<Member> members) {
    /// Je mets membersId comme paramètre pour gagner en performance
    /// Au lieu de venir chercher les membres à qui il faut diffuser, je passe en paramètre membersId contenu dans la variable broadcastList
    BehaviorSubject<List<Message>> subject = BehaviorSubject<List<Message>>();

    subject.add(members.map((member) {
      return Message(
          broadcastId: broadcast.id,
          memberId: member.id,
          content: Parser.parse(member, broadcast.message),
          receivedAt: DateTime.now().toString(),
          isWaiting: 1,
          isReceived: 0,
          isSent: 0,
          sentAt: DateTime.now().toString());
    }).toList());

    return subject.stream;
  }

  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    addMessages.close();
    deleteMessage.close();
    updateMessage.close();
    searchMessage.close();
    _subscriptions.forEach((subscriptions) => subscriptions.cancel());
  }
}

import 'dart:async';

import 'package:ccis_blocs/src/interactors/messages_interactor.dart';
import 'package:ccis_blocs/src/interactors/members_interactor.dart';
import 'package:ccis_blocs/src/helpers/search.dart';
import 'package:ccis_blocs/src/models/models.dart';
import 'package:rxdart/rxdart.dart';

class MessagesSearchBloc {
  // Inputs
  Sink<String> query;
  Sink<String> memberId;

  // Outputs
  final Stream<List<Message>> queryResult;

  //Cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory MessagesSearchBloc(MessagesInteractor messagesInteractor,
      MembersInteractor memberInteractor) {
    // We'll use a series of StreamControllers to glue together our inputs and
    // outputs.
    //
    // StreamControllers have both a Sink and a Stream. We'll expose the Sinks
    // publicly so users can send information to the Bloc. We'll use the Streams
    // internally to react to that user input.
    final queryController = BehaviorSubject<String>(sync: true);
    final memberIdController = BehaviorSubject<String>(sync: true);

    // In some cases, we need to simply route user interactions to our data
    // layer. In this case, we'll listen to the streams. In order to clean
    // these subscriptions up, we'll pop them in a list and ensure we cancel
    // all of them in the `close` method when they are no longer needed.
    final subscriptions = <StreamSubscription<dynamic>>[];

    // To calculate the result of search, we combine the members with the current
    // search key and return the result of the search.
    //
    // Every time the members or the search query changes the visible items will emit
    // once again. We also convert the normal Stream into a BehaviorSubject
    // so the Stream can be listened to multiple times
    final searchQueryResultController = BehaviorSubject<List<Message>>();

    Observable.combineLatest3<List<Message>, List<Member>, String,
        List<Message>>(
      messagesInteractor.messages,
      memberInteractor.members,
      queryController.stream,
      _searchMessage,
    ).pipe(searchQueryResultController);

    return MessagesSearchBloc._(
        queryController, searchQueryResultController, subscriptions);
  }

  MessagesSearchBloc._(this.query, this.queryResult, this._subscriptions);

  static List<Message> _searchMessage(
      List<Message> messages, List<Member> members, String query) {
    //TODO: Use Search helpers instead
    final Iterable<Message> results = query.isEmpty ? messages : messages.where((message) {
      // On selectionne l'utilisateur associé au message
      final member =
          members.firstWhere((member) => member.id == message.memberId);
      return message.content
              .toLowerCase()
              .trim()
              .contains(query.trim().toLowerCase()) ||
          message.receivedAt.contains(query) ||
          message.sentAt.contains(query) ||
          member.fullName.toLowerCase().contains(query) ||
          member.study.name.toLowerCase().contains(query) ||
          member.community.name.toLowerCase().contains(query) ||
          member.residenceBedroom.toLowerCase().contains(query) ||
          member.phoneNumber.toLowerCase().contains(query);
    });

    return results.toList();
  }

  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    query.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}

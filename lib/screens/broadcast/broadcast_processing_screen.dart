import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/screens/broadcast/broadcast_add_forward_screen.dart';
import 'package:ccis_app/widgets/broadcasts/broadcast_item.dart';
import 'package:ccis_app/widgets/messages/messages_list.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';
import 'package:ccis_app/widgets/shared/spinner_loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/providers/sim_cards_bloc_provider.dart';
import 'package:sms/sms.dart';

class BroadcastProcessingScreen extends StatefulWidget {
  final Broadcast broadcast;
  final List<Message> messages;
  final BroadcastBloc Function() initBloc;
  final Function(List<Message>) addMessages;
  final BroadcastInteractor broadcastInteractor;
  final RankInteractor rankInteractor;
  final BroadcastListInteractor broadcastListInteractor;
  final MessagesInteractor messagesInteractor;
  final MembersInteractor membersInteractor;
  final SimCard simCard;

  BroadcastProcessingScreen(
      {@required this.broadcast,
      @required this.messages,
      @required this.initBloc,
      @required this.broadcastInteractor,
      @required this.rankInteractor,
      @required this.broadcastListInteractor,
      @required this.messagesInteractor,
      @required this.membersInteractor,
      @required this.addMessages,
      @required this.simCard})
      : super(key: ArchSampleKeys.broadcastProcessingScreen);

  @override
  BroadcastProcessingScreenState createState() {
    return BroadcastProcessingScreenState();
  }
}

class BroadcastProcessingScreenState extends State<BroadcastProcessingScreen> {
  BroadcastBloc broadcastBloc;
  MemberBloc memberBloc;
  MessageBloc messageBloc;
  SmsSender _sender;
  bool _isSending;

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _isSending = true;
    broadcastBloc = widget.initBloc();
    memberBloc = MemberBloc(widget.membersInteractor);
    messageBloc = MessageBloc(widget.messagesInteractor);
    _sender = new SmsSender();
    widget.addMessages(widget.messages);
    _sendMessages(widget.messages, widget.simCard);
  }

  @override
  void dispose() {
    broadcastBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(ArchSampleLocalizations.of(context).broadcast),
        actions: [],
        bottom: _isSending
            ? PreferredSize(
                child: Container(height: 2, child: LinearLoading()),
                preferredSize: Size(double.maxFinite, 2))
            : PreferredSize(
                child: Container(), preferredSize: Size(double.maxFinite, 2)),
      ),
      body: MessagesList(
        broadcast: widget.broadcast,
        messagesInteractor: widget.messagesInteractor,
        membersInteractor: widget.membersInteractor,
      ),
    );
  }

  void _sendMessages(List<Message> messages, SimCard simCard) async {
    await Future.forEach(messages, (message) {
      memberBloc.member(message.memberId).first.then((member) async {
        final SmsMessage smsMessage =
        new SmsMessage(member.phoneNumber, message.content);

        await _sender.sendSms(smsMessage, simCard: simCard);

        smsMessage.onStateChanged.listen((SmsMessageState state) {
          if (state == SmsMessageState.Delivered) {
            messageBloc.updateMessage.add(message.copyWith(
                isWaiting: 0,
                isReceived: 1,
                receivedAt: DateTime.now().toString()));
          }
          if (state == SmsMessageState.Sent) {
            messageBloc.updateMessage.add(message.copyWith(
                isWaiting: 0, isSent: 1, sentAt: DateTime.now().toString()));
          }
          if (state == SmsMessageState.Fail) {
            messageBloc.updateMessage.add(message.copyWith(
                isWaiting: 0,
                isSent: 0,
                isReceived: 0,
                sentAt: DateTime.now().toString()));
          }
        });
      });
    }).then((x) {
      setState(() {
        _isSending = false;
      });
    });
  }
}

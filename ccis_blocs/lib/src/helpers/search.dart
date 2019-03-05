import 'package:ccis_blocs/src/models/models.dart';

class Search {
  static searchMember(List<Member> members, String query) {
    query = query.toLowerCase().trim();
    final Iterable<Member> results = members.where((member) =>
        member.fullName.toLowerCase().contains(query) ||
        member.study.name.toLowerCase().contains(query) ||
        member.community.name.toLowerCase().contains(query) ||
        member.residenceBedroom.toLowerCase().contains(query) ||
        member.phoneNumber.toLowerCase().contains(query));

    return results.toList();
  }

  static searchMessage(List<Message> messages, String query) {
    query = query.toLowerCase().trim();
    final Iterable<Message> results = messages.where((message) =>
        message.content.toLowerCase().contains(query) ||
        message.sentAt.toLowerCase().contains(query) ||
        message.receivedAt.toLowerCase().contains(query));

    return results.toList();
  }
}

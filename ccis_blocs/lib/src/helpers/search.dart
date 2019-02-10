import 'package:ccis_blocs/src/models/models.dart';

class Search {
  static searchMember(List<Member> members, String query) {
    query = query.toLowerCase();
    final Iterable<Member> results = members.where((member) =>
    member.fullName.toLowerCase().contains(query) ||
        member.study.name.toLowerCase().contains(query) ||
        member.community.name.toLowerCase().contains(query) ||
        member.residenceBedroom.toLowerCase().contains(query) ||
        member.phoneNumber.toLowerCase().contains(query));

    return results.toList();
  }
}
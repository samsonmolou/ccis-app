import 'package:ccis_blocs/ccis_blocs.dart';

import 'custom_pattern.dart';

class Parser {
  static String parse(Member member, String content) {
    content = content.replaceAll(new RegExp(CustomPattern.firstName), member.firstName);
    content = content.replaceAll(new RegExp(CustomPattern.secondName), member.secondName);
    content = content.replaceAll(new RegExp(CustomPattern.phoneNumber), member.phoneNumber);
    content = content.replaceAll(new RegExp(CustomPattern.community), member.community.name);
    content = content.replaceAll(new RegExp(CustomPattern.study), member.study.name);
    content = content.replaceAll(new RegExp(CustomPattern.bedroomNumber), member.bedroomNumber);
    content = content.replaceAll(new RegExp(CustomPattern.residence), member.residence);
    return content;
  }
}
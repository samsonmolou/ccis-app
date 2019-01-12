import 'package:ccis_blocs/src/helpers/uuid.dart';
import 'package:meta/meta.dart';
import 'package:ccis_repository/ccis_repository.dart';

@immutable
class Member {
  final String id;
  final String firstName;
  final String secondName;
  final String residence;
  final String bedroomNumber;
  final String phoneNumber;
  final String community;
  final String study;

  Member({
    String id,
    String firstName = '',
    String secondName = '',
    String residence = '',
    String bedroomNumber = '',
    String phoneNumber = '',
    String community = '',
    String study = ''})
      : this.firstName = firstName ?? '',
        this.secondName = secondName ?? '',
        this.residence = residence ?? '',
        this.bedroomNumber = bedroomNumber ?? '',
        this.phoneNumber = phoneNumber ?? '',
        this.community = community ?? '',
        this.study = study ?? '',
        this.id = id ?? Uuid().generateV4();

  Member copyWith({
    String id,
    String firstName = '',
    String secondName = '',
    String residence = '',
    String bedroomNumber = '',
    String phoneNumber = '',
    String community = '',
    String study = ''}) {
    return Member(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      residence: residence ?? this.residence,
      bedroomNumber: bedroomNumber ?? this.bedroomNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      community: community ?? this.community,
      study: study ?? this.community
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^ firstName.hashCode ^ secondName.hashCode ^ residence.hashCode
      ^ bedroomNumber.hashCode ^ phoneNumber.hashCode ^ community.hashCode ^ study.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Member &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        firstName == other.firstName &&
        secondName == other.secondName &&
        residence == other.residence &&
        bedroomNumber == other.bedroomNumber &&
        phoneNumber == other.phoneNumber &&
        community == other.community &&
        study == other.study
    ;
  }

  @override
  String toString() {
    return 'Member{id: $id, '
        'firstName: $firstName, '
        'secondName: $secondName,'
        'residence: $residence'
        'bedroomNumber: $bedroomNumber'
        'phoneNumber: $phoneNumber'
        'community: $community'
        'study: $study}';
  }

  MemberEntity toEntity() {
    return MemberEntity(id, firstName, secondName, residence, bedroomNumber,
      phoneNumber, community, study);
  }

  static Member fromEntity(MemberEntity entity) {
    return Member(
      id: entity.id ?? Uuid().generateV4(),
      firstName: entity.firstName,
      secondName: entity.secondName,
      residence: entity.residence,
      bedroomNumber: entity.bedroomNumber,
      phoneNumber: entity.phoneNumber,
      community: entity.community,
      study: entity.study
    );
  }
}
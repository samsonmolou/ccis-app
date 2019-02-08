import 'package:ccis_blocs/src/helpers/uuid.dart';
import 'package:ccis_blocs/src/models/community.dart';
import 'package:ccis_blocs/src/models/study.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';

@immutable
class Member {
  final String id;
  final String firstName;
  final String secondName;
  final String residence;
  final String bedroomNumber;
  final String phoneNumber;
  final Community community;
  final Study study;

  Member({
    String id,
    String firstName = '',
    String secondName = '',
    String residence = '',
    String bedroomNumber = '',
    String phoneNumber = '',
    Community community2,
    Study study2})
      : this.firstName = firstName ?? '',
        this.secondName = secondName ?? '',
        this.residence = residence ?? '',
        this.bedroomNumber = bedroomNumber ?? '',
        this.phoneNumber = phoneNumber ?? '',
        this.community = community2 ?? null,
        this.study = study2 ?? null,
        this.id = id ?? Uuid().generateV4();

  Member copyWith({
    String id,
    String firstName = '',
    String secondName = '',
    String residence = '',
    String bedroomNumber = '',
    String phoneNumber = '',
    Community community2,
    Study study2}) {
    return Member(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      residence: residence ?? this.residence,
      bedroomNumber: bedroomNumber ?? this.bedroomNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      community2: community2 ?? this.community,
      study2: study2 ?? this.study
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^ firstName.hashCode ^ secondName.hashCode ^ residence.hashCode
      ^ bedroomNumber.hashCode ^ phoneNumber.hashCode ^ study.hashCode ^ community.hashCode;
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
      phoneNumber, community.toEntity(), study.toEntity());
  }

  static Member fromEntity(MemberEntity entity) {
    return Member(
      id: entity.id ?? Uuid().generateV4(),
      firstName: entity.firstName,
      secondName: entity.secondName,
      residence: entity.residence,
      bedroomNumber: entity.bedroomNumber,
      phoneNumber: entity.phoneNumber,
      community2: Community.fromEntity(entity.community),
      study2: Study.fromEntity(entity.study),
    );
  }

  String get fullName => firstName + ' ' + secondName;

  String get residenceBedroom => residence + '-' + bedroomNumber;
}
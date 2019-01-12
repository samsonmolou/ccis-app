class MemberEntity {
  final String id;
  final String firstName;
  final String secondName;
  final String residence;
  final String bedroomNumber;
  final String phoneNumber;
  final String community;
  final String study;

  MemberEntity(this.id, this.firstName, this.secondName, this.residence,
      this.bedroomNumber, this.phoneNumber, this.community, this.study);

  @override
  int get hashCode {
    return id.hashCode ^ firstName.hashCode ^ secondName.hashCode ^ residence.hashCode
    ^ bedroomNumber.hashCode ^ phoneNumber.hashCode ^ community.hashCode ^ study.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MemberEntity &&
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

  Map<String, Object> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "secondName": secondName,
      "residence": residence,
      "bedroomNumber": bedroomNumber,
      "phoneNumber": phoneNumber,
      "community": community,
      "study": study
    };
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

  static MemberEntity fromJson(Map<String, Object> json) {
    return MemberEntity(
      json["id"] as String,
      json["firstName"] as String,
      json["secondName"] as String,
      json["residence"] as String,
      json["bedroomNumber"] as String,
      json["phoneNumber"] as String,
      json["community"] as String,
      json["study"] as String,
    );
  }
}
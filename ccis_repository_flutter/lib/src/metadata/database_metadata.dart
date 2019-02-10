
class DatabaseMetadata {
  // Table member
  static final String tableMember = "Member";

  // Table member columns
  static final String columnMemberId = "id";
  static final String columnMemberFirstName = "firstName";
  static final String columnMemberSecondName = "secondName";
  static final String columnMemberCommunity = "community";
  static final String columnMemberResidence = "residence";
  static final String columnMemberBedroomNumber = "bedroomNumber";
  static final String columnMemberStudy = "study";
  static final String columnMemberPhoneNumber = "phoneNumber";

  // Table broadcast list
  static final String tableBroadcastList = "BroadcastList";

  // Table broadcast list columns
  static final String columnBroadcastListId = "id";
  static final String columnBroadcastListName = "name";
  static final String columnBroadcastMembersId = "membersId";

  // Table broadcast list members
  static final String tableBroadcastListsMembers = "BroadcastListsMembers";

  // Table broadcast list columns
  static final String columnBroadcastListsMembersId = "id";
  static final String columnBroadcastListsMembersMemberId = "memberId";
  static final String columnBroadcastListsMembersBroadcastListId = "BroadcastListId";

}

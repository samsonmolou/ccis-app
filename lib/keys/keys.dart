import 'package:flutter/widgets.dart';

class ArchSampleKeys {

  // Home Screens
  static final homeScreen = const Key('__homeScreen__');
  static final addTodoFab = const Key('__addTodoFab__');
  static final snackbar = const Key('__snackbar__');
  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Todos
  static final todoList = const Key('__todoList__');
  static final todosLoading = const Key('__todosLoading__');
  static final todoItem = (String id) => Key('TodoItem__${id}');
  static final todoItemCheckbox =
      (String id) => Key('TodoItem__${id}__Checkbox');
  static final todoItemTask = (String id) => Key('TodoItem__${id}__Task');
  static final todoItemNote = (String id) => Key('TodoItem__${id}__Note');

  // Members
  static final memberList = const Key('__memberList__');
  static final memberScreen = const Key('__memberScreen__');
  static final addMemberFab = const Key('__addMemberFab__');
  static final membersLoading = const Key('__membersLoading__');
  static final memberItem = (String id) => Key('MemberItem__${id}');
  static final memberItemHead = (String id) => Key('MemberItem__${id}__Head');
  static final memberItemSubhead = (String id) => Key('MemberItem__${id}__Subhead');


  // Tabs
  static final tabs = const Key('__tabs__');
  static final todoTab = const Key('__todoTab__');
  static final statsTab = const Key('__statsTab__');

  // Extra Actions
  static final extraActionsButton = const Key('__extraActionsButton__');
  static final toggleAll = const Key('__markAllDone__');
  static final clearCompleted = const Key('__clearCompleted__');

  // Filters
  static final filterButton = const Key('__filterButton__');
  static final allFilter = const Key('__allFilter__');
  static final activeFilter = const Key('__activeFilter__');
  static final completedFilter = const Key('__completedFilter__');

  // Stats
  static final statsCounter = const Key('__statsCounter__');
  static final statsLoading = const Key('__statsLoading__');
  static final statsNumActive = const Key('__statsActiveItems__');
  static final statsNumCompleted = const Key('__statsCompletedItems__');

  // MemberDetails Screen
  static final editMemberFab = const Key('__editMemberFab__');
  static final deleteMemberButton = const Key('__deleteMemberFab__');
  static final memberDetailsScreen = const Key('__memberDetailsScreen__');
  static final detailsMemberItemFirstName = Key('DetailsMember__FirstName');
  static final detailsMemberItemSecondName = Key('DetailsMember__SecondName');
  static final detailsMemberItemPhoneNumber = Key('DetailsMember__PhoneNumber');

  // Add Member Screen
  static final addMemberScreen = const Key('__addMemberScreen__');
  static final saveNewMember = const Key('__saveNewMember__');
  static final firstNameField = const Key('__firstNameField__');
  static final secondNameField = const Key('__secondNameField__');
  static final phoneNumberField = const Key('__phoneNumberField__');
  static final residenceField = const Key('__residenceField__');
  static final bedroomNumberField = const Key('__bedroomNumberField__');
  static final communityField = const Key('__communityField__');
  static final studyField = const Key('__studyField__');


  // Edit Member Screen
  static final editMemberScreen = const Key('__editMemberScreen__');
  static final saveMemberFab = const Key('__saveMemberFab__');
}

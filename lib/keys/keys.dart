import 'package:flutter/widgets.dart';

class ArchSampleKeys {

  //Drawer
  static final navigationDrawer = const Key('__navigationDrawer__');

  // Broadcast Screen
  static final broadcastScreen = const Key('__broadcastScreen__');
  static final broadcastsLoading = const Key('__broadcastsLoading__');
  static final addBroadcastFab = const Key('__addBroadcastFab__');

  // Add Broadcast Screen
  static final addBroadcastScreen = const Key('__addBroadcastScreen__');
  static final broadcastNameField = const Key('__broadcastNameField__');
  static final broadcastMessageField = const Key('__broadcastMessageField__');
  static final broadcastItem = (String id) => Key('BroadcastItem__${id}');

  // Broadcast List Screen
  static final broadcastListScreen = const Key('__broadcastListScreen__');
  static final broadcastLists = const Key('__broadcastListList__');
  static final broadcastListsLoading = const Key('__broadcastListsLoading__');
  static final addBroadcastListFab = const Key('__addBroadcastListFab__');



  static final broadcastListItemSubhead = (String id) => Key('BroadcastListItem__${id}__Subhead');
  static final broadcastListNameField = const Key('__broadcastListNameField__');
  static final addEditSearchField = const Key('__addEditSearchField__');

  // Add Edit BroadcastList Screen
  static final addEditBroadcastListScreen = const Key('__addEditBroadcastListScreen__');

  // Add Edit Broadcast Screen
  static final addEditBroadcastScreen = const Key('__addEditBroadcastScreen__');

  // Message Screen
  static final messagesListsLoading = const Key('__messagesListsLoading__');


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

  // Broadcast

  static final broadcastItemHead = (String id) => Key('BroadcastItem__${id}__Head');

  // Tabs
  static final tabs = const Key('__tabs__');
  static final membersTab = const Key('__membersTap__');
  static final broadcastListTab = const Key('__broadcastListTab__');
  static final broadcastTab = const Key('__broadcastTab__');

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
  static final deleteMemberButton = const Key('__deleteMemberButton__');
  static final memberDetailsScreen = const Key('__memberDetailsScreen__');
  static final detailsMemberItemFirstName = Key('DetailsMember__FirstName');
  static final detailsMemberItemSecondName = Key('DetailsMember__SecondName');
  static final detailsMemberItemPhoneNumber = Key('DetailsMember__PhoneNumber');

  // Broadcast Detail Screen
  static final broadcastDetailsScreen = const Key('__broadcastDetailsScreen__');
  static final deleteBroadcastButton = const Key('__deleteBroadcastButton__');
  static final editBroadcastButton = const Key('__editBroadcastButton__');
  static final forwardBroadcastButton = const Key('__forwardBroadcastButton__');
  static final broadcastDetailDetailsTab = const Key('__broadcastDetailDetailsTab__');
  static final broadcastDetailMessagesTab = const Key('__broadcastDetailMessage sTab__');


  // Broadcast Processing Screen
  static final broadcastProcessingScreen = const Key('__broadcastProcessingScreen__');


  // Broadcast List Detail Screen
  static final editBroadcastListButton = const Key('__editBroadcastListButton__');
  static final deleteBroadcastListButton = const Key('__deleteBroadcastListButton__');
  static final broadcastListDetailsScreen = const Key('__broadcastListDetailsScreen__');
  static final detailsBroadcastListItemName = Key('DetailsBroadcastList__Name');

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

  // Add BroadcastList Screen
  static final addBroadcastListScreen = const Key('__addBroadcastListScreen__');
  static final saveNewBroadcastList = const Key('__saveNewMember__');

  // Edit BroadcastList Screen
  static final editBroadcastListScreen = const Key('__editBroadcastListScreen__');
  static final saveBroadcastIconButton = const Key('__saveBroadcastIconButton__');

  // Edit Broadcast Screen
  static final editBroadcastScreen = const Key('__editBroadcastScreen__');
  static final forwardBroadcastScreen = const Key('__forwardBroadcastScreen__');

  // Member Export Screen
  static final membersExportScreen = const Key('__membersExportScreen__');

  // Member Import Screen
  static final membersImportScreen = const Key('__membersImportScreen__');
  static final importedMembersList = const Key('__importedMembersList__');
}

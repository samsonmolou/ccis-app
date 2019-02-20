import 'dart:async';

import 'package:ccis_app/localizations/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ArchSampleLocalizations {
  ArchSampleLocalizations(this.locale);

  final Locale locale;

  static Future<ArchSampleLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return ArchSampleLocalizations(locale);
    });
  }

  static ArchSampleLocalizations of(BuildContext context) {
    return Localizations.of<ArchSampleLocalizations>(
        context, ArchSampleLocalizations);
  }


  String get searchTextMinimum => Intl.message(
    'Doit comporter au minimum 3 caractères',
    name: 'searchTextMinimum',
    args: [],
    locale: locale.toString(),
  );

  String get home => Intl.message(
    'Accueil',
    name: 'home',
    args: [],
    locale: locale.toString(),
  );

  String get broadcasts => Intl.message(
    'Diffusions',
    name: 'diffusion',
    args: [],
    locale: locale.toString(),
  );

  String get broadcast => Intl.message(
    'Diffusion',
    name: 'diffusion',
    args: [],
    locale: locale.toString(),
  );

  String get notFound => Intl.message(
    'Aucune correspondance',
    name: 'notFound',
    args: [],
    locale: locale.toString(),
  );

  String get noMembers => Intl.message(
    'Aucun membre',
    name: 'notMembers',
    args: [],
    locale: locale.toString(),
  );

  String get exit => Intl.message(
    'Quitter',
    name: 'exit',
    args: [],
    locale: locale.toString(),
  );

  String get exportMembers => Intl.message(
    'Exporter les membres',
    name: 'exportMembers',
    args: [],
    locale: locale.toString(),
  );

  String get importMembers => Intl.message(
    'Importer des membres',
    name: 'importMembers',
    args: [],
    locale: locale.toString(),
  );

  String get chooseFileToImport => Intl.message(
    'Sélectionner le fichier à importer',
    name: 'chooseFileToImport',
    args: [],
    locale: locale.toString(),
  );

  String get chooseFile => Intl.message(
    'Sélectionner le fichier',
    name: 'chooseFileToImport',
    args: [],
    locale: locale.toString(),
  );

  String get fileName => Intl.message(
    'NOM DU FICHIER SÉLECTIONNÉ',
    name: 'fileName',
    args: [],
    locale: locale.toString(),
  );

  String get stepOne => Intl.message(
    'Étape 1',
    name: 'stepOne',
    args: [],
    locale: locale.toString(),
  );

  String get stepTwo => Intl.message(
    'Étape 2',
    name: 'stepTwo',
    args: [],
    locale: locale.toString(),
  );

  String get processingImport => Intl.message(
    'Traitement',
    name: 'processingImport',
    args: [],
    locale: locale.toString(),
  );

  String get members => Intl.message(
    'Membres',
    name: 'members',
    args: [],
    locale: locale.toString(),
  );

  String get membersWithOrWithoutS => Intl.message(
    'Membre(s)',
    name: 'membersWithOrWithoutS',
    args: [],
    locale: locale.toString(),
  );

  String get broadcastList => Intl.message(
    'Liste de diffusion',
    name: 'broadcastList',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberFirstNameHint => Intl.message(
    'Quel est votre nom ?',
    name: 'newMemberFirstNameHint',
    args: [],
    locale: locale.toString(),
  );

  String get newBroadcastListNameHint => Intl.message(
    'Quel est le nom de la liste de diffusion ?',
    name: 'newBroadcastListNameHint',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberSecondNameHint => Intl.message(
    'Quel est votre prénom ?',
    name: 'newMemberSecondNameHint',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberPhoneNumberHint => Intl.message(
    'Quel est votre numéro de téléphone ?',
    name: 'newMemberPhoneNumberHint',
    args: [],
    locale: locale.toString(),
  );

  String get startMemberImport => Intl.message(
    "Démarrer l'importation",
    name: 'startMemberImport',
    args: [],
    locale: locale.toString(),
  );

  String get notImplemented => Intl.message(
    "Cette action n'est pas encore implémenté",
    name: 'notImplemented',
    args: [],
    locale: locale.toString(),
  );

  String get addToDatabase => Intl.message(
    "Ajouter à la base de données",
    name: 'addToDatabase',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberResidenceHint => Intl.message(
    'Quelle est votre résidence ?',
    name: 'newMemberResidenceHint',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberBedroomNumberHint => Intl.message(
    'Quel est votre numéro de chambre ?',
    name: 'newMemberBedroomNumberHint',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberCommunityHint => Intl.message(
    'Vous appartenez à quelle communauté ?',
    name: 'newMemberCommunityHint',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberStudyHint => Intl.message(
    'Quel est votre filière ?',
    name: 'newMemberStudyHint',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberFirstNameLabel => Intl.message(
    'Nom',
    name: 'newMemberFirstNameLabel',
    args: [],
    locale: locale.toString(),
  );

  String get newBroadcastListNameLabel => Intl.message(
    'Nom de la liste',
    name: 'newBroadcastListNameLabel',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberSecondNameLabel => Intl.message(
    'Prénoms',
    name: 'newMemberSecondNameLabel',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberPhoneNumberLabel => Intl.message(
    'Numéro de téléphone',
    name: 'newMemberPhoneNumberLabel',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberResidenceLabel => Intl.message(
    'Résidence',
    name: 'newMemberResidenceLabel',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberBedroomNumberLabel => Intl.message(
    'Numéro de chambre',
    name: 'newMemberBedroomNumberLabel',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberCommunityLabel => Intl.message(
    'Communauté',
    name: 'newMemberCommunityLabel',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberStudyLabel => Intl.message(
    'Filière',
    name: 'newMemberStudyLabel',
    args: [],
    locale: locale.toString(),
  );

  String get addMember => Intl.message(
    'Ajouter membre',
    name: 'addMember',
    args: [],
    locale: locale.toString(),
  );

  String get addBroadcastList => Intl.message(
    'Ajouter une liste',
    name: 'addMember',
    args: [],
    locale: locale.toString(),
  );

  String get newBroadcastList => Intl.message(
    'Nouvelle liste',
    name: 'addBroadcastList',
    args: [],
    locale: locale.toString(),
  );

  String get editMember => Intl.message(
    'Editer membre',
    name: 'editMember',
    args: [],
    locale: locale.toString(),
  );

  String get editBroadcast => Intl.message(
    'Editer diffusion',
    name: 'editBroadcast',
    args: [],
    locale: locale.toString(),
  );

  String get editBroadcastList => Intl.message(
    'Editer la liste',
    name: 'editBroadcastList',
    args: [],
    locale: locale.toString(),
  );

  String get saveChanges => Intl.message(
    'Enregistrer les changements',
    name: 'saveChanges',
    args: [],
    locale: locale.toString(),
  );


  String get deleteMember => Intl.message(
    'Supprimer un membre',
    name: 'deleteMember',
    args: [],
    locale: locale.toString(),
  );

  String get deleteBroadcastList => Intl.message(
    'Supprimer cette liste',
    name: 'deleteBroadcastList',
    args: [],
    locale: locale.toString(),
  );

  String get deleteBroadcast => Intl.message(
    'Supprimer cette diffusion',
    name: 'deleteBroadcast',
    args: [],
    locale: locale.toString(),
  );



  String get memberDetails => Intl.message(
    'Détails du membre',
    name: 'memberDetails',
    args: [],
    locale: locale.toString(),
  );


  String memberDeleted(String member) => Intl.message(
    '"$member" supprimé',
    name: 'memberDeleted',
    args: [member],
    locale: locale.toString(),
  );

  String broadcastDeleted(String broadcast) => Intl.message(
    '"$broadcast" supprimé',
    name: 'broadcastDeleted',
    args: [broadcast],
    locale: locale.toString(),
  );

  String get undo => Intl.message(
    'Annuler',
    name: 'undo',
    args: [],
    locale: locale.toString(),
  );

  String get back => Intl.message(
    'Retour',
    name: 'back',
    args: [],
    locale: locale.toString(),
  );

  String get searchMember => Intl.message(
    'Rechercher un membre',
    name: 'searchMember',
    args: [],
    locale: locale.toString(),
  );

  String get searchBroadcastList => Intl.message(
    'Rechercher une liste de diffusion',
    name: 'searchBroadcastList',
    args: [],
    locale: locale.toString(),
  );

  String get clear => Intl.message(
    'Effacer',
    name: 'clear',
    args: [],
    locale: locale.toString(),
  );

  String get deleteMemberConfirmation => Intl.message(
    'Supprimer ce membre?',
    name: 'deleteMemberConfirmation',
    args: [],
    locale: locale.toString(),
  );

  String get delete => Intl.message(
    'Supprimer',
    name: 'delete',
    args: [],
    locale: locale.toString(),
  );


  String get emptyMemberError => Intl.message(
    'Veuillez entrer un texte',
    name: 'emptyMemberError',
    args: [],
    locale: locale.toString(),
  );

  String get emptyBroadcastListNameError => Intl.message(
    'Veuillez entrer un texte',
    name: 'emptyBroadcastListNameError',
    args: [],
    locale: locale.toString(),
  );

  String get cancel => Intl.message(
    'Annuler',
    name: 'cancel',
    args: [],
    locale: locale.toString(),
  );


}

class ArchSampleLocalizationsDelegate
    extends LocalizationsDelegate<ArchSampleLocalizations> {
  @override
  Future<ArchSampleLocalizations> load(Locale locale) =>
      ArchSampleLocalizations.load(locale);

  @override
  bool shouldReload(ArchSampleLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains("en");
}

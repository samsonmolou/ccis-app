import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:ccis_app/localizations/messages_all.dart';
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

  String get members => Intl.message(
    'Membres',
    name: 'members',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberFirstNameHint => Intl.message(
    'Nom',
    name: 'newMemberFirstNameHint',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberSecondNameHint => Intl.message(
    'Prénoms',
    name: 'newMemberSecondNameHint',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberPhoneNumberHint => Intl.message(
    'Numéro de téléphone',
    name: 'newMemberPhoneNumberHint',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberResidenceHint => Intl.message(
    'Résidence',
    name: 'newMemberResidenceHint',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberBedroomNumberHint => Intl.message(
    'Numéro de chambre',
    name: 'newMemberBedroomNumberHint',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberCommunityHint => Intl.message(
    'Communauté',
    name: 'newMemberCommunityHint',
    args: [],
    locale: locale.toString(),
  );

  String get newMemberStudyHint => Intl.message(
    'Filière',
    name: 'newMemberStudyHint',
    args: [],
    locale: locale.toString(),
  );

  String get addMember => Intl.message(
    'Ajouter membre',
    name: 'addMember',
    args: [],
    locale: locale.toString(),
  );

  String get editMember => Intl.message(
    'Editer membre',
    name: 'editMember',
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

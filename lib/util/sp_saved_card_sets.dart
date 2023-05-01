import 'package:psau_rant_flutter/models/card_set_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedCardSetsPreferences {
  static late SharedPreferences _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future addCardSet(CardSet cardSet) async {
    String stringCardSet = cardSet.toString();
    final List<String> cardSets = _preferences.getStringList('cardSets') ?? [];
    cardSets.add(stringCardSet);
    await _preferences.setStringList('cardSets', cardSets);
  }

  static Future removeCardSet(CardSet cardSet) async {
    String stringCardSet = cardSet.toString();
    final List<String> cardSets = _preferences.getStringList('cardSets') ?? [];
    cardSets.remove(stringCardSet);
    await _preferences.setStringList('cardSets', cardSets);
  }

  static Future<List<CardSet>> getAllCardSets() async {
    final List<String> cardSets = _preferences.getStringList('cardSets') ?? [];
    List<CardSet> cardSetList = [];
    for (String cardSet in cardSets) {
      cardSetList.add(CardSet.fromString(cardSet));
    }
    return cardSetList;
  }
}

class Card {
  String cardId;
  String cardTerm;
  String cardDefinition;

  Card(
      {required this.cardId,
      required this.cardTerm,
      required this.cardDefinition});
}

class CardSet {
  String cardSetId;
  String cardSetName;
  String cardSetAuthorId;
  bool cardSetIsPublic;
  List<Card> cardSetCards;

  CardSet({
    required this.cardSetId,
    required this.cardSetName,
    required this.cardSetAuthorId,
    required this.cardSetIsPublic,
    required this.cardSetCards,
  });
}

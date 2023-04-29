class CardPiece {
  String cardId;
  String cardTerm;
  String cardDefinition;

  CardPiece(
      {required this.cardId,
      required this.cardTerm,
      required this.cardDefinition});
}

class CardSet {
  String cardSetId;
  String cardSetName;
  String cardSetAuthorId;
  bool cardSetIsPublic;
  List<CardPiece> cardSetCards;

  CardSet({
    required this.cardSetId,
    required this.cardSetName,
    required this.cardSetAuthorId,
    required this.cardSetIsPublic,
    required this.cardSetCards,
  });
}

class CardPiece {
  String cardId;
  String cardTerm;
  String cardDefinition;

  CardPiece({
    required this.cardId,
    required this.cardTerm,
    required this.cardDefinition,
  });
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

  @override
  String toString() {
    String cardPieces = cardSetCards
        .map((card) => "${card.cardId}|${card.cardTerm}|${card.cardDefinition}")
        .join('|');
    return "$cardSetId|$cardSetName|$cardSetAuthorId|$cardSetIsPublic|$cardPieces";
  }

  static CardSet fromString(String input) {
    List<String> parts = input.split('|');
    String id = parts[0];
    String name = parts[1];
    String authorId = parts[2];
    bool isPublic = parts[3] == 'true';
    List<CardPiece> cards = [];
    for (int i = 4; i < parts.length; i += 3) {
      cards.add(CardPiece(
        cardId: parts[i],
        cardTerm: parts[i + 1],
        cardDefinition: parts[i + 2],
      ));
    }
    return CardSet(
      cardSetId: id,
      cardSetName: name,
      cardSetAuthorId: authorId,
      cardSetIsPublic: isPublic,
      cardSetCards: cards,
    );
  }
}

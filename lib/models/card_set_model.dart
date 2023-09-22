class CardPiece {
  String cardId;
  String cardQuestion;
  String cardAnswer;

  CardPiece({
    required this.cardId,
    required this.cardQuestion,
    required this.cardAnswer,
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
        .map((card) => "${card.cardId}|${card.cardQuestion}|${card.cardAnswer}")
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
        cardQuestion: parts[i + 1],
        cardAnswer: parts[i + 2],
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

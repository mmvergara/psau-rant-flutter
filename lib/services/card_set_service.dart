import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psau_rant_flutter/models/card_set_model.dart';

class CardSetService {
  final String? uid;
  CardSetService({required this.uid});
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // collection reference
  final CollectionReference cardSetCollection =
      FirebaseFirestore.instance.collection('card_sets');

  Future<CardSet?> fetchCardSetById(String cardSetId) async {
    try {
      DocumentSnapshot cardSetDoc =
          await cardSetCollection.doc(cardSetId).get();
      CardSet cardSet = CardSet(
        cardSetId: cardSetDoc.id,
        cardSetName: cardSetDoc['card_set_name'],
        cardSetAuthorId: cardSetDoc['card_set_author_id'],
        cardSetIsPublic: cardSetDoc['card_set_isPublic'],
        cardSetCards: cardSetDoc['card_set_cards'].map<CardPiece>(
          (card) {
            return CardPiece(
              cardId: card['card_id'],
              cardTerm: card['card_term'],
              cardDefinition: card['card_definition'],
            );
          },
        ).toList(),
      );
      return cardSet;
    } catch (e) {
      return null;
    }
  }

  Future<List<CardSet>?> fetchUserCardSetsByUserId() async {
    try {
      QuerySnapshot cardSetDocs = await cardSetCollection
          .where('card_set_author_id', isEqualTo: uid)
          .get();
      List<CardSet> cardSets = cardSetDocs.docs.map<CardSet>(
        (cardSet) {
          return CardSet(
            cardSetId: cardSet.id,
            cardSetName: cardSet['card_set_name'],
            cardSetAuthorId: cardSet['card_set_author_id'],
            cardSetIsPublic: cardSet['card_set_isPublic'],
            cardSetCards: cardSet['card_set_cards'].map<CardPiece>(
              (card) {
                return CardPiece(
                  cardId: card['card_id'],
                  cardTerm: card['card_term'],
                  cardDefinition: card['card_definition'],
                );
              },
            ).toList(),
          );
        },
      ).toList();
      return cardSets;
    } catch (e) {
      return null;
    }
  }
}

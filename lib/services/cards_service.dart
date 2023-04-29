import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psau_rant_flutter/models/cardset_model.dart';

class CardSService {
  final String? uid;
  CardSService({required this.uid});
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
        cardSetCards: cardSetDoc['card_set_cards'].map<Card>(
          (card) {
            return Card(
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
}

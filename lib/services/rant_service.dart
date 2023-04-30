import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psau_rant_flutter/models/rant_model.dart';
import 'package:psau_rant_flutter/util/helpers.dart';

class RantService {
  final String? uid;
  RantService({required this.uid});
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // collection reference
  static final CollectionReference cardSetCollection =
      FirebaseFirestore.instance.collection('rants');

  static Future<List<Rant>> getMostRecentRants(int limit) async {
    try {
      QuerySnapshot rantsSnapshot = await cardSetCollection
          .orderBy('rant_date', descending: true)
          .limit(limit)
          .get();
      List<Rant> rants = rantsSnapshot.docs.map<Rant>(
        (rant) {
          return Rant(
            rantAuthorName: rant['rant_author_username'],
            rantAuthorId: rant['rant_author_id'],
            rantId: rant.id,
            rantTitle: rant['rant_title'],
            rantContent: rant['rant_content'],
            rantLikes: rant['rant_likes'].cast<String, String>(),
            rantDate: Helpers.getTimeElapsedString(rant['rant_date']),
          );
        },
      ).toList();
      return rants;
    } catch (e) {
      return [];
    }
  }

  static Future<bool?> likeRant(String rantId, String userId) async {
    try {
      DocumentReference rantRef = cardSetCollection.doc(rantId);
      DocumentSnapshot rantSnapshot = await rantRef.get();
      Map<String, String> rantLikes =
          rantSnapshot['rant_likes'].cast<String, String>();
      if (rantLikes.containsKey(userId)) {
        rantLikes.remove(userId);
      } else {
        rantLikes[userId] = userId;
      }
      await rantRef.update({'rant_likes': rantLikes});
      return true;
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> addRant(
      String rantTitle, String rantContent, String userId) async {
    try {
      DocumentReference rantRef = cardSetCollection.doc();
      await rantRef.set({
        'rant_title': rantTitle,
        'rant_content': rantContent,
        'rant_author_id': userId,
        'rant_author_username': 'username',
        'rant_likes': {},
        'rant_date': Timestamp.now(),
      });
      return true;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> handleLikeRant(
      String rantId, bool isLiked, String userId) async {
    try {
      final rantRef =
          FirebaseFirestore.instance.collection('rants').doc(rantId);
      final String rantLikeRef = 'rant_likes.$userId';
      if (!isLiked) {
        // Add Like
        await rantRef.update({rantLikeRef: userId});
      } else {
        // Delete Like
        await rantRef.update({rantLikeRef: FieldValue.delete()});
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}

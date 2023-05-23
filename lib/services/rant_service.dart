import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psau_rant_flutter/models/rant_model.dart';
import 'package:psau_rant_flutter/util/helpers.dart';

class RantService {
  final String? uid;
  RantService({required this.uid});
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // collection reference
  static final CollectionReference rantCollection =
      FirebaseFirestore.instance.collection('rants');

  static Future<List<Rant>> getMostRecentRants(int limit) async {
    try {
      QuerySnapshot rantsSnapshot = await rantCollection
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

  static Future<bool> deleteRant(String rantId) async {
    try {
      await rantCollection.doc(rantId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> createRant(
      String rantTitle, String rantContent, String uid, String username) async {
    try {
      DocumentReference rantRef = rantCollection.doc();
      await rantRef.set({
        'rant_title': rantTitle,
        'rant_content': rantContent,
        'rant_author_id': uid,
        'rant_author_username': username,
        'rant_likes': {uid: uid},
        'rant_date': Timestamp.now(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}

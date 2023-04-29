import 'package:cloud_firestore/cloud_firestore.dart';

class Helpers {
  static String getTimeElapsedString(Timestamp timestamp) {
    DateTime now = DateTime.now();
    Duration timeDiff = now.difference(timestamp.toDate());

    int seconds = timeDiff.inSeconds;
    int minutes = timeDiff.inMinutes;
    int hours = timeDiff.inHours;
    int days = timeDiff.inDays;

    if (days > 0) {
      return '${days}d ago';
    } else if (hours > 0) {
      return '${hours}h ago';
    } else if (minutes > 0) {
      return '${minutes}m ago';
    } else {
      return '${seconds}s ago';
    }
  }
}

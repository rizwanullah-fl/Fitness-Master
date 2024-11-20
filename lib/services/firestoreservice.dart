import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> fetchVideoUrls() async {
    List<String> videoUrls = [];
    QuerySnapshot snapshot = await _firestore.collection('exercise').get();

    for (var doc in snapshot.docs) {
      videoUrls.add(doc['video_url']);
    }
    return videoUrls;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class WaterLevelController extends GetxController {
  RxInt waterLevelPercentage = 0.obs;
  RxInt selectedGlassIndex = (-1).obs;

  WaterLevelController() {
    fetchWaterLevel();
    _scheduleMidnightReset(); // Set up the midnight reset schedule
  }

  Future<void> fetchWaterLevel() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (snapshot.exists) {
      waterLevelPercentage.value = snapshot['waterLevelPercentage'] ?? 0;
      selectedGlassIndex.value = snapshot['selectedGlassIndex'];
    }
  }

  Future<void> saveWaterLevel() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.doc(userId).set({
      'waterLevelPercentage': waterLevelPercentage.value,
      'selectedGlassIndex': selectedGlassIndex.value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    }, SetOptions(merge: true));
  }

  void _scheduleMidnightReset() {
    DateTime now = DateTime.now();
    DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1);
    Duration durationUntilMidnight = nextMidnight.difference(now);
    Future.delayed(durationUntilMidnight, _resetWaterLevel);
  }
  void _resetWaterLevel() {
    waterLevelPercentage.value = 0;
    selectedGlassIndex.value = -1;
    saveWaterLevel(); // Save the reset values to Firebase
    _scheduleMidnightReset(); // Schedule the next reset for the following midnight
  }

  void updateWaterLevel(int index) {
    if (index > selectedGlassIndex.value) {
      selectedGlassIndex.value = index;
      waterLevelPercentage.value = (index + 1) * 12;
      saveWaterLevel();
    }
  }
}

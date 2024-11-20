// story_controller.dart
import 'package:fitness/models/storymodel.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class StoryController extends GetxController {
  var stories = <Story>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStories();
  }

  void fetchStories() {
    isLoading.value = true;
    FirebaseFirestore.instance.collection('story').snapshots().listen((snapshot) {
      stories.value = snapshot.docs.map((doc) {
        print("Fetched document data: ${doc.data()}"); // Debug print
        return Story.fromJson(doc.data(), doc.id);
      }).toList();
      isLoading.value = false;
    }, onError: (e) {
      print("Error fetching stories: $e");
      isLoading.value = false;
    });
  }
}

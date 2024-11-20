import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoController extends GetxController {
  var videoURL = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVideoURL();
  }

  // Fetch the latest video URL from Firestore
  Future<void> fetchVideoURL() async {
    try {
      isLoading.value = true;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('intro')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        videoURL.value = querySnapshot.docs.first.get('video_url');
      }
    } catch (e) {
      print("Error fetching video URL: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

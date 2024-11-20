import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

class VideoService {
  static final VideoService _instance = VideoService._internal();
  factory VideoService() => _instance;
  VideoService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> videoUrls = [];
  VideoPlayerController? videoController;

  Future<void> initialize() async {
    if (videoUrls.isEmpty) {
      // Fetch videos only once and cache them
      videoUrls = await fetchVideoUrls();
    }
  }

  Future<List<String>> fetchVideoUrls() async {
    List<String> urls = [];
    QuerySnapshot snapshot = await _firestore.collection('exercise').get();
    for (var doc in snapshot.docs) {
      urls.add(doc['video_url']);
    }
    return urls;
  }

  Future<VideoPlayerController> getDailyVideoController() async {
    await initialize();

    // Start from the second video by shifting index by 1
    int dayIndex = (DateTime.now().weekday % videoUrls.length + 1) % videoUrls.length;
    String dailyUrl = videoUrls[dayIndex];

    videoController?.dispose(); // Dispose the previous controller if any
    videoController = VideoPlayerController.networkUrl(Uri.parse(dailyUrl));
    await videoController!.initialize();
    videoController!.setLooping(true);

    return videoController!;
  }
}

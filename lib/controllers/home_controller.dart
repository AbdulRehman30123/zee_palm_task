// home_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zee_palm_task/models/video_model.dart';
import 'package:zee_palm_task/packages/packages.dart';
import 'package:zee_palm_task/presentation/upload_video.dart';

class HomeController extends GetxController {
  RxList<VideoModel> videos = <VideoModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;

  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    fetchVideos();
  }

  /// Fetch videos from zee_palm_videos collection
  Future<void> fetchVideos() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('zee_palm_videos')
          .orderBy('uploadedAt', descending: true)
          .get();

      List<VideoModel> fetchedVideos = querySnapshot.docs
          .map((doc) => VideoModel.fromFirestore(doc))
          .toList();

      videos.value = fetchedVideos;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = e.toString();
      print('Error fetching videos: $e');
    }
  }

  /// Refresh videos
  Future<void> refreshVideos() async {
    await fetchVideos();
  }

  /// Navigate to upload page
  void navigateToUpload() {
    Get.to(() => UploadVideoPage());
  }

  /// Navigate to account page
  void navigateToAccount() {
    Get.toNamed('/account');
  }
}

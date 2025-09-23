import 'dart:io';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayingController extends GetxController {
  RxBool isInitialized = false.obs;
  RxBool isPlaying = false.obs;
  VideoPlayerController? videoController;
  RxBool isMuted = false.obs;



  void initializeVideo(File file) async {
    videoController = VideoPlayerController.file(file);
    await videoController!.initialize();
    videoController!.addListener(() {
      if (videoController!.value.position >= videoController!.value.duration) {
        isPlaying.value = false;
      }
    });
    isInitialized.value = true;
    videoController!.play();
    isPlaying.value = true;
  }

  void togglePlayPause() {
    if (videoController == null) return;
    if (videoController!.value.isPlaying) {
      videoController!.pause();
      isPlaying.value = false;
    } else {
      videoController!.play();
      isPlaying.value = true;
    }
  }
  void toggleVolume() {
    if (videoController == null) return;
    if (isMuted.value) {
      videoController!.setVolume(1.0);
      isMuted.value = false;
    } else {
      videoController!.setVolume(0.0);
      isMuted.value = true;
    }
  }


  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    final File videoFile = args['videoFile'];
    initializeVideo(videoFile);


  }


  @override
  void onClose() {
    videoController?.dispose();
    super.onClose();
  }
}

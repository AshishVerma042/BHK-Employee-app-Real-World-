import 'dart:io';
import 'package:bhk_employee/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../controller/videoPlayingController.dart';

class VideoPlayerScreen extends ParentWidget {
  VideoPlayerScreen({super.key});

  final controller = Get.put(VideoPlayingController());

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final args = Get.arguments as Map<String, dynamic>;
    final File videoFile = args['videoFile'];
    if (!controller.isInitialized.value) {
      controller.initializeVideo(videoFile);
    }


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Intro Video"),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Obx(() {
          if (!controller.isInitialized.value) {
            return CircularProgressIndicator();
          }
          return AspectRatio(
            aspectRatio:0.75,
            child: VideoPlayer(controller.videoController!),
          );
        }),
      ),
      bottomNavigationBar:  Obx(() =>
       BottomAppBar(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => controller.toggleVolume(),
                icon:  Icon(controller.isMuted.value ? Icons.volume_off : Icons.volume_up,color: Colors.white,),

              ),

              IconButton(
                onPressed: () => controller.togglePlayPause(),
                icon: Icon(
                  controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,),
              )
            ],
          ),
        ),
      ),

      // floatingActionButton: Obx(() => FloatingActionButton(backgroundColor: Colors.transparent,
      //   onPressed: () => controller.togglePlayPause(),
      //   child: Icon(
      //     controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
      //   color: Colors.white,),
      // )),
    );
  }
}

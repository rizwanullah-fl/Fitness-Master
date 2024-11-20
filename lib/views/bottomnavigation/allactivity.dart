import 'package:fitness/controllers/storycontroller.dart';
import 'package:fitness/models/storymodel.dart';
import 'package:fitness/views/bottomnavigation/avtivityscreen/detailscreen.dart';
import 'package:fitness/views/bottomnavigation/avtivityscreen/storycard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class ActivityScreen extends StatelessWidget {
  final StoryController storyController = Get.put(StoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (storyController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: storyController.stories.length,
          itemBuilder: (context, index) {
            Story story = storyController.stories[index];
            print('imagee urlll ${story.imageUrl}');
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      name: story.name,
                      imageUrl: story.imageUrl,
                      descriptions: story.description, // Pass an empty list if no descriptions are available
                    ),
                  ),
                );
              },
              child: StoryCard(
                name: story.name,
                imageUrl: story.imageUrl,
              ),
            );
          },
        );
      }),
    );
  }
}

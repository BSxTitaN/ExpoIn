import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryPattern extends StatelessWidget {
  final StoryController storyController;
  const StoryPattern({super.key, required this.storyController});

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = [
      StoryItem.pageVideo(
        'https://firebasestorage.googleapis.com/v0/b/expoin-4f28f.appspot.com/o/storyvideos%2Fexpo-1.mp4?alt=media&token=9fc3156f-4db8-435e-98ff-91ea9fdfbce7',
        controller: storyController,
      ),
      StoryItem.pageVideo(
        'https://firebasestorage.googleapis.com/v0/b/expoin-4f28f.appspot.com/o/storyvideos%2Fexpo-3.mp4?alt=media&token=6b20d7c9-5a15-4eb9-96d9-f71a38919e1d',
        controller: storyController,
      ),
      StoryItem.pageVideo(
        'https://firebasestorage.googleapis.com/v0/b/expoin-4f28f.appspot.com/o/storyvideos%2Fexpo-2.mp4?alt=media&token=b198fd3d-e86c-4bff-8e9e-d22fd8def7d5',
        controller: storyController,
      ),
    ];

    return StoryView(
      storyItems: storyItems,
      controller: storyController,
      repeat: true,
    );
  }
}

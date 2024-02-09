import 'package:expoin/Components/standard_format.dart';
import 'package:expoin/Pages/onboarding/widgets/story.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../widgets/onboarding_below.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const StdFormat(widget: Stack(
      children: [
        Positioned(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: OnboardBelow(),
          ),
        ),
      ],
    ), stackWidget: StoryOnboarding());
  }
}

class StoryOnboarding extends StatefulWidget {
  const StoryOnboarding({
    super.key,
  });

  @override
  State<StoryOnboarding> createState() => _StoryOnboardingState();
}

class _StoryOnboardingState extends State<StoryOnboarding> {
  final StoryController _controller = StoryController();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(child: Opacity(opacity: 0.8,
    child: StoryPattern(storyController: _controller,)),);
  }
}

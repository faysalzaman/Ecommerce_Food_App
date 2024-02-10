// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce_app/Bloc/Story/story_bloc.dart';
import 'package:food_ecommerce_app/Screens/TabsScreen/TabsScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:story_view/story_view.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({
    super.key,
    required this.caption,
    required this.imageUrl,
    required this.storyId,
  });

  final String caption;
  final String imageUrl;
  final String storyId;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final controller = StoryController();
  List<StoryItem> storyItems = [];

  StoryBloc storyBloc = StoryBloc();

  @override
  void initState() {
    super.initState();
    storyItems = [
      StoryItem.pageImage(
        url: widget.imageUrl.toString(),
        controller: controller,
        caption: widget.caption.toString(),
      ),
    ];

    storyBloc.add(SawStoryEvent(storyId: widget.storyId.toString()));
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: StoryView(
        controller: controller,
        repeat: true,
        onStoryShow: (s) {
          if (s == storyItems.length) {
            context.read<StoryBloc>().add(FetchStoryEvent());

            Navigator.of(context).pushReplacement(
              PageTransition(
                child: const TabsScreen(),
                type: PageTransitionType.rightToLeftWithFade,
              ),
            );
          }
        },
        onComplete: () {
          context.read<StoryBloc>().add(FetchStoryEvent());

          Navigator.of(context).pushReplacement(
            PageTransition(
              child: const TabsScreen(),
              type: PageTransitionType.rightToLeftWithFade,
            ),
          );
        },
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            context.read<StoryBloc>().add(FetchStoryEvent());

            Navigator.of(context).pushReplacement(
              PageTransition(
                child: const TabsScreen(),
                type: PageTransitionType.rightToLeftWithFade,
              ),
            );
          }
        },
        storyItems: storyItems,
      ),
    );
  }
}

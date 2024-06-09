import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../../../views/profile.screen.dart';

class AnimationSwipe extends StatefulWidget {
  const AnimationSwipe({super.key});

  @override
  State<AnimationSwipe> createState() => _AnimationSwipeState();
}

class _AnimationSwipeState extends State<AnimationSwipe> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SwipeableButtonView(
        buttonText: 'SLIDE TO PAYMENT',
        buttonWidget: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey,
        ),
        activeColor: Colors.greenAccent,
        isFinished: isFinished,
        onWaitingProcess: () {
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              isFinished = true;
            });
          });
        },
        onFinish: () async {
          await Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const ProfileScreen(),
            ),
          );
          setState(() {
            isFinished = false;
          });
        },
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimationControllerNotifier extends StateNotifier<bool> {
  AnimationControllerNotifier() : super(false);

  void setAnimation() {
    state = true;
  }
}

final animationStateProvider =
    StateNotifierProvider<AnimationControllerNotifier, bool>(
  (ref) => AnimationControllerNotifier(),
);

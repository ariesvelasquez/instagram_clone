import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/animations/models/lottie_animation.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationView extends StatelessWidget {
  final LottieAnimationEnum animation;
  final bool repeat;
  final bool reverse;

  const LottieAnimationView({
    super.key,
    required this.animation,
    this.repeat = true,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      animation.fullPath,
      reverse: reverse,
      repeat: repeat,
    );
  }
}

extension GetFullPath on LottieAnimationEnum {
  String get fullPath => 'assets/animations/$name.json';
}

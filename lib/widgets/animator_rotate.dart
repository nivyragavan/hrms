import 'dart:async';

import 'package:flutter/material.dart';

class Animator extends StatefulWidget {
  final Widget child;
  final Duration time;
  const Animator(this.child, this.time, {super.key});
  @override
  State<Animator> createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator>
    with SingleTickerProviderStateMixin {
  Timer? timer;
  AnimationController? animationController;
  Animation<double>? animation;
  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    timer = Timer(widget.time, animationController!.forward);
    animation = CurvedAnimation(
      parent: animationController!,
      curve: Curves.elasticInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
    animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: animation!,
      child: widget.child,
    );
  }
}

Timer? timer;
Duration duration = const Duration();
wait() {
  if (timer == null || !timer!.isActive) {
    timer = Timer(const Duration(microseconds: 50), () {
      duration = const Duration();
    });
  }
  duration += const Duration(milliseconds: 0);
  return duration;
}

class RotateANimator extends StatelessWidget {
  final Widget child;
  const RotateANimator(this.child, {super.key});
  @override
  Widget build(BuildContext context) {
    return Animator(child, wait());
  }
}

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
  Animation? animation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    timer = Timer(widget.time, animationController!.forward);
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
    animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(CurvedAnimation(
        parent: animationController!,
        curve: Curves.easeInCubic,
      )),
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
  duration += const Duration(milliseconds: 200);
  return duration;
}

class SlideANimator extends StatelessWidget {
  final Widget child;
  const SlideANimator(this.child, {super.key});
  @override
  Widget build(BuildContext context) {
    return Animator(child, wait());
  }
}


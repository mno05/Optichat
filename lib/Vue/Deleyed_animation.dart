import 'dart:async';

import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  final int delay;
  final Widget child;
  const DelayedAnimation({required this.delay, required this.child, super.key});

  @override
  State<DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animationController);

    _animOffset = Tween<Offset>(begin: Offset(0.0, -0.35), end: Offset.zero)
        .animate(curve);
    Timer(Duration(milliseconds: widget.delay), () {
      _animationController.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}

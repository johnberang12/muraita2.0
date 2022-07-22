// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeAnimation extends StatefulWidget {
  const LikeAnimation({
    Key? key,
    required this.child,
    required this.isAnimating,
    required this.duration,
    this.onEnd,
    required this.smallLike,
  }) : super(key: key);
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;

  @override
  State<StatefulWidget> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2));
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(const Duration(
        milliseconds: 200,
      ));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}

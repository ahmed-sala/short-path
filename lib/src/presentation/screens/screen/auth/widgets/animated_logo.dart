import 'package:flutter/material.dart';
import 'package:short_path/core/styles/images/app_images.dart';

class AnimatedLogo extends StatefulWidget {
  final double width;
  final double height;

  const AnimatedLogo({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _rotationAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: Image.asset(
          AppImages.logo,
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}

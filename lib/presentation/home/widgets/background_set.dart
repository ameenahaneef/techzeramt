import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.2, end: 1),
      duration: const Duration(milliseconds: 800),
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: Image.asset(
        'assets/images/COver Shoe.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

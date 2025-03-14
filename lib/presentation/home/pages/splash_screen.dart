import 'package:flutter/material.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/presentation/home/pages/home_splash.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return const HomeSplash();
        },
      ), (route) => false);
    });

    return Scaffold(
      backgroundColor: kBlack,
      body: Center(
        child: TweenAnimationBuilder<double>(
          duration: const Duration(seconds: 2),
          tween: Tween(begin: 0.5, end: 1.0),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: value,
                child: child,
              ),
            );
          },
          child: Image.asset(
            'assets/images/close-up-futuristic-sneakers-showcase.jpg',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/presentation/home/widgets/background_set.dart';
import 'package:techzeramt/presentation/home/widgets/bottom_button.dart';
import 'package:techzeramt/presentation/home/widgets/text_widget.dart';

class HomeSplash extends StatelessWidget {
  const HomeSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBlack,
      body: Stack(
        fit: StackFit.expand,
        children: [
          BackgroundImage(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Textwidget(), Bottombutton()],
            ),
          ),
        ],
      ),
    );
  }
}













// // Background Image with Smooth Fade-In
  // Widget _buildBackgroundImage() {
  //   return TweenAnimationBuilder<double>(
  //     tween: Tween<double>(begin: 0.2, end: 1),
  //     duration: Duration(milliseconds: 800),
  //     // Adjust duration for smoothness
  //     builder: (context, opacity, child) {
  //       return Opacity(
  //         opacity: opacity,
  //         child: child,
  //       );
  //     },
  //     child: Image.asset(
  //       'assets/images/COver Shoe.png',
  //       fit: BoxFit.cover,
  //     ),
  //   );
  // }
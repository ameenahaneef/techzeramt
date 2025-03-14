import 'package:flutter/material.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/core/constants/app_styles.dart';
import 'package:techzeramt/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techzeramt/presentation/login/pages/login_screen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBlack.withOpacity(0.7),
      title: Text(
        "Logout",
        style: style1,
      ),
      content: Text(
        "Are you sure you want to log out?",
        style: style1,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: kDeepOrange),
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<LoginBloc>().add(LogoutButtonPressed());
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: const Text(
            "Logout",
            style: TextStyle(color: kGreen),
          ),
        ),
      ],
    );
  }
}

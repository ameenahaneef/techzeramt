import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/presentation/login/bloc/login_bloc.dart';
import 'package:techzeramt/presentation/login/widgets/form_field.dart';

class ColumnWidget extends StatelessWidget {
  const ColumnWidget({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.formKey,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Login',
            style: TextStyle(
                color: kWhite,
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
        ),
        height10,
        const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Please Sign in to continue',
              style: TextStyle(color: kWhite, fontSize: 20),
            )),
        height10,
        Formfield(
            labelText: 'Username', controller: usernameController),
        const SizedBox(height: 10),
        Formfield(
            labelText: 'Password', controller: passwordController),
        const SizedBox(height: 20),
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return const CircularProgressIndicator();
            }
            return ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  context.read<LoginBloc>().add(LoginButtonPressed(
                        username: usernameController.text,
                        password: passwordController.text,
                      ));
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.7)),
              child: const Text(
                'Login',
                style: TextStyle(color: kBlack),
              ),
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/presentation/login/bloc/login_bloc.dart';
import 'package:techzeramt/presentation/login/widgets/column_widget.dart';
import 'package:techzeramt/presentation/products/pages/product_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: kBlack,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }

          if (state is LoginSuccess) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const ProductScreen();
            }));
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/close-up-futuristic-sneakers-showcase.jpg'),
              opacity: 0.3,
            ),
          ),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ColumnWidget(
                  usernameController: usernameController,
                  passwordController: passwordController,
                  formKey: formKey),
            ),
          ),
        ),
      ),
    );
  }
}

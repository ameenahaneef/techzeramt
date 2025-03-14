import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:techzeramt/data/models/product_model.dart';
import 'package:techzeramt/data/models/user_model.dart';
import 'package:techzeramt/data/sources/shared_preference.dart';
import 'package:techzeramt/presentation/home/pages/splash_screen.dart';
import 'package:techzeramt/presentation/login/bloc/login_bloc.dart';
import 'package:techzeramt/presentation/products/bloc/product_bloc.dart';
import 'package:techzeramt/presentation/products/pages/product_screen.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('products');
  final isLoggedIn = await AuthService().getLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => ProductBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isLoggedIn ? const ProductScreen() : const SplashScreen(),
      ),
    );
  }
}

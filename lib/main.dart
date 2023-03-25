import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mob_auth_fire_base/buisiness_logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:mob_auth_fire_base/buisiness_logic/blocs/login_bloc/login_bloc.dart';
import 'package:mob_auth_fire_base/firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mob_auth_fire_base/presentation/screens/home.dart';
import 'package:mob_auth_fire_base/presentation/screens/login.dart';
import 'package:mob_auth_fire_base/presentation/screens/splash_screen.dart';
import 'package:mob_auth_fire_base/presentation/screens/verifying_otp.dart';
import 'package:mob_auth_fire_base/repositeries/user_repository.dart';

void main() async {
  // loading env
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(
    userRepository: UserRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(userRepository: userRepository)
            ..add(AppStarted()),
        ),
        BlocProvider(create: (_) => LoginBloc(userRepository)),
      ],
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Unauthenticated) {
              return const Login();
            } else if (state is Authenticated) {
              return const HomeScreen();
            } else if (state is Uninitialized) {
              return const SplashScreen();
            }
            // todo: 404 page
            return const Placeholder();
          },
        ),
      ),
    );
  }
}

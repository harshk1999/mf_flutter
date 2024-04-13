import 'package:flutter/material.dart';
import 'package:mf_app/src/app/bloc/user_bloc.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final SplashViewModel svm;
  @override
  void initState() {
    super.initState();
    svm = context.read<SplashViewModel>();

    svm.splashNotifier.addListener(() {
      final state = svm.splashNotifier.value;
      if (state is LoggedIn) {
        final user = state.user;
        context.read<UserBloc>().setUser = user;
        Navigator.of(context).pushReplacementNamed(AppRoutes.bottomNavBarHome);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SplashScreen',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Icon(
          Icons.waving_hand,
          size: 200,
        ),
      ),
    );
  }
}

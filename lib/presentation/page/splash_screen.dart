import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialpreneur/data/static/app_data.dart';
import 'package:socialpreneur/presentation/bloc/profile_module/profile_event.dart';
import 'package:socialpreneur/presentation/bloc/venture_module/fetch_venture_event.dart';
import 'package:socialpreneur/presentation/injector.dart';
import 'package:socialpreneur/presentation/page/home_page.dart';
import 'package:socialpreneur/presentation/page/onboarding_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 300), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Injector.profileBloc.add(
            FetchProfileEvent(uid: FirebaseAuth.instance.currentUser!.uid));
        Injector.fetchVentureBloc.add(const FetchVentureEvent());
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OnboardingPage()));
      }
    });
    return Scaffold(
      body: Center(
        child: Text(appName),
      ),
    );
  }
}

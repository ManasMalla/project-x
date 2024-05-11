import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socialpreneur/data/models/venture_model.dart';
import 'package:socialpreneur/domain/entity/venture.dart';
import 'package:socialpreneur/firebase_options.dart';
import 'package:socialpreneur/presentation/injector.dart';
import 'package:socialpreneur/presentation/page/onboarding_page.dart';
import 'package:socialpreneur/presentation/page/splash_screen.dart';
import 'package:socialpreneur/presentation/page/venture_page.dart';
import 'package:socialpreneur/presentation/providers/NavigationStateProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => Injector.profileBloc),
        BlocProvider(create: (_) => Injector.fetchVentureBloc),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NavigationStateProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0d6efd)),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Socialpreneur'),
      home: const SplashScreen(),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onNavigated;
  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    required this.onNavigated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Row(
                children: List.generate(
                    items.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24)
                              .copyWith(bottom: 8),
                          child: Container(
                            height: 4,
                            width: (constraints.maxWidth / items.length) - 48,
                            color: index == currentIndex
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        )));
          },
        ),
        BottomNavigationBar(
          onTap: onNavigated,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: items,
        ),
      ],
    );
  }
}

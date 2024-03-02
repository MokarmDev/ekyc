import 'package:ekyc/screens/home/home_screen.dart';
import 'package:ekyc/screens/on_boarding/on_boarding_screen.dart';
import 'package:ekyc/screens/selfie/selfie_screen.dart';
import 'package:ekyc/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'database/cache/cache_helper.dart';
import 'services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  await getIt<CacheHelper>().init();

  /// Change app to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EKYC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/onBoarding': (context) => const OnBoardingView(),
        '/selfie': (context) => const SelfieScreen(),
      },
    );
  }

  const MyApp({super.key});
}

import 'package:ekyc/screens/failure/failure_screen.dart';
import 'package:ekyc/screens/home/home_screen.dart';
import 'package:ekyc/screens/on_boarding/on_boarding_screen.dart';
import 'package:ekyc/screens/profile/profile_screen.dart';
import 'package:ekyc/screens/selfie/selfie_screen.dart';
import 'package:ekyc/screens/splash/splash_screen.dart';
import 'package:ekyc/screens/success/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  runApp(const EKYC());
}

class EKYC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
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
            '/success': (context) => const SuccessScreen(),
            '/failure': (context) => const FailureScreen(),
            '/profile': (context) => ProfileScreen(),
          },
        );
      },
    );
  }

  const EKYC({super.key});
}


import 'package:go_router/go_router.dart';
import 'package:newsapp/features/home/home_screen.dart';

import '../../splash_screen.dart';

class AppRouts {

  static const splashScreen = "/";
  static const homeScreen = "/homeScreen";



  static final GoRouter router = GoRouter(
    initialLocation: splashScreen,
    routes: [

      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),



    ],
  );
}
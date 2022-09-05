import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/utils/theme.dart';
import 'package:movie_app/views/details/detail_nowshowing_view.dart';
import 'package:movie_app/views/details/detail_person_view.dart';
import 'package:movie_app/views/home/home_view.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'views/search/search_page_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.resize(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
        background: Container(
          color: const Color(0xFFF5F5F5),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: lightTheme,
      routes: {
        '/': (context) => const HomeView(),
        '/detail-movie': (context) => const DetailNowShowingView(),
        '/search': (context) => const SearchPageView(),
        '/detail-person': (context) => const DetailPersonView(),
      },
      initialRoute: "/",
    );
  }
}

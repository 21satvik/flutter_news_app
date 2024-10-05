import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:lingopanda_news/views/news_feed_screen.dart';
import 'package:lingopanda_news/providers/news_provider.dart'; // Import the new Provider class
import 'views/login_screen.dart';
import 'views/signup_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyNews',
        initialRoute: '/news_feed',
        routes: {
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/news_feed': (context) => const NewsFeedScreen(),
        },
      ),
    );
  }
}

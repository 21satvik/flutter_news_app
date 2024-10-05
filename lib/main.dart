import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:lingopanda_news/views/news_feed_screen.dart';
import 'package:lingopanda_news/providers/news_provider.dart'; // Import the new Provider class
import 'package:lingopanda_news/providers/authentication_provider.dart'; // Import AuthProvider
import 'views/login_screen.dart';
import 'views/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // Handle error (e.g., log the error, show a message, etc.)
    debugPrint('Error initializing Firebase: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => NewsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyNews',
        initialRoute: '/signup',
        routes: {
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/news_feed': (context) => const NewsFeedScreen(),
        },
      ),
    );
  }
}

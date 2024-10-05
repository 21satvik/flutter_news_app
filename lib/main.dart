import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lingopanda_news/providers/region_provider.dart';
import 'package:lingopanda_news/views/region_selection_screen.dart';
import 'package:provider/provider.dart';
import 'package:lingopanda_news/views/news_feed_screen.dart';
import 'package:lingopanda_news/providers/news_provider.dart';
import 'package:lingopanda_news/providers/authentication_provider.dart';
import 'views/login_screen.dart';
import 'views/signup_screen.dart';

/// The entry point of the application.
///
/// This function initializes Firebase, loads environment variables,
/// and runs the MyApp widget.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
  }
  runApp(const MyApp());
}

/// The main application widget.
///
/// This widget sets up the routing and provider for the application,
/// including authentication, news, and region providers.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine initial route based on authentication status
    String initialRoute =
        FirebaseAuth.instance.currentUser == null ? '/login' : '/news_feed';

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => NewsProvider()),
        ChangeNotifierProvider(create: (context) => RegionProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyNews',
        initialRoute: initialRoute,
        routes: {
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/news_feed': (context) => const NewsFeedScreen(),
          '/region_selection': (context) => const RegionSelectorScreen(),
        },
      ),
    );
  }
}

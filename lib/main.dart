import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// THEME
import 'theme/app_theme.dart';

// GATE
import 'screens/auth/auth_gate.dart';
import 'screens/auth/login_screen.dart';
import 'screens/profile/edit_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyAppRoot());
}

class MyAppRoot extends StatefulWidget {
  const MyAppRoot({super.key});

  @override
  State<MyAppRoot> createState() => _MyAppRootState();
}

class _MyAppRootState extends State<MyAppRoot> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cafe IRBK",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,

      home: AuthGate(
        onToggleTheme: _toggleTheme,
        themeMode: _themeMode,
      ),

      routes: {
        '/login': (context) => LoginScreen(
            ),

        '/editProfile': (context) {
          final userId = ModalRoute.of(context)!.settings.arguments as String;
          return EditProfileScreen(userId: userId);
        },
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../home_screens.dart';

class AuthGate extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const AuthGate({
    required this.onToggleTheme,
    required this.themeMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        // Masih loading
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Jika user TIDAK login → ke LoginScreen
        if (!snap.hasData) {
          return const _LoginStartPage();
        }

        // Jika user SUDAH login → ke HomeScreen
        return HomeScreen(
          onToggleTheme: onToggleTheme,
          themeMode: themeMode,
        );
      },
    );
  }
}

class _LoginStartPage extends StatelessWidget {
  const _LoginStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Login dulu"),
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
        ),
      ),
    );
  }
}

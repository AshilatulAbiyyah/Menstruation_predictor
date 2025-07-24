import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart'; // Buat nanti
import 'screens/input_menstruasi.dart'; // Buat setelah login

void main() {
  runApp(const MenstruationPredictorApp());
}

class MenstruationPredictorApp extends StatelessWidget {
  const MenstruationPredictorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prediksi Menstruasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      // 👇 Halaman pertama saat aplikasi dijalankan
      home: const WelcomeScreen(),
      // 👇 Daftar rute navigasi
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        // '/input-menstruasi': (context) => const InputMenstruasiPage(userId: 1), // Kalau butuh
      },
    );
  }
}

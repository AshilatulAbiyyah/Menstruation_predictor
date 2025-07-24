import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_welcome.jpg', // Ganti dengan background kamu
              fit: BoxFit.cover,
            ),
          ),

          // Konten Utama
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'PEFLOW\nPERIOD\nTRACKER',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 254, 254),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Go With The Flow',
                  style: TextStyle(color:  Color.fromARGB(255, 155, 135, 135), fontSize: 13),
                ),
                const SizedBox(height: 40),

                // Tombol Sign In
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 222, 96, 138),
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Sign In"),
                ),
                const SizedBox(height: 15),

                // Tombol Sign Up
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 222, 96, 138),
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Sign Up"),
                ),

                const SizedBox(height: 20),

                // Text bawah
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    "Already Have An Account?  Sign In",
                    style: TextStyle(color: Color.fromARGB(255, 155, 135, 135), fontSize: 13),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
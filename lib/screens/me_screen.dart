import 'package:flutter/material.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy user
    final userName = "Ashilatul Abiyyah";
    final userEmail = "ashila@example.com";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Saya"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text("👤 Nama: $userName", style: const TextStyle(fontSize: 18)),
            Text("📧 Email: $userEmail", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            const Text("🔧 Pengaturan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Keluar"),
              onTap: () {
                // TODO: Arahkan ke login atau bersihkan session
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),

            const Spacer(),
            const Divider(),
            const Center(
              child: Text(
                "Versi 1.0.0 • Dikembangkan oleh Cyinn 💖",
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}

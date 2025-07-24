import 'package:flutter/material.dart';

class CycleLengthScreen extends StatelessWidget {
  const CycleLengthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy histori panjang siklus
    final List<Map<String, dynamic>> cycleHistory = [
      {"tanggal": "01 Jan 2025", "panjang": 28},
      {"tanggal": "29 Jan 2025", "panjang": 27},
      {"tanggal": "25 Feb 2025", "panjang": 30},
      {"tanggal": "27 Mar 2025", "panjang": 28},
      {"tanggal": "24 Apr 2025", "panjang": 26},
      {"tanggal": "21 Mei 2025", "panjang": 29},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cycle Length History"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: cycleHistory.length,
        itemBuilder: (context, index) {
          final item = cycleHistory[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text("Tanggal: ${item['tanggal']}"),
              subtitle: Text("Panjang Siklus: ${item['panjang']} hari"),
            ),
          );
        },
      ),
    );
  }
}

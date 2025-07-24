import 'package:flutter/material.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk tampilan awal (nanti bisa diisi dari backend)
    final predictedDate = "22 Juli 2025";
    final averageCycle = 28;
    final lastDuration = 5;
    final stressAdvice = "Kurangi stres dengan relaksasi dan tidur cukup.";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Insights"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📅 Prediksi Menstruasi Berikutnya",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text("➡️ $predictedDate\n", style: const TextStyle(fontSize: 16)),

            Text("📊 Rata-rata Panjang Siklus",
                style: Theme.of(context).textTheme.titleMedium),
            Text("➡️ $averageCycle hari\n", style: const TextStyle(fontSize: 16)),

            Text("🩸 Lama Menstruasi Terakhir",
                style: Theme.of(context).textTheme.titleMedium),
            Text("➡️ $lastDuration hari\n", style: const TextStyle(fontSize: 16)),

            Text("💡 Saran",
                style: Theme.of(context).textTheme.titleMedium),
            Text("➡️ $stressAdvice", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

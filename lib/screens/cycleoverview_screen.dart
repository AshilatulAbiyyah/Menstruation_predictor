import 'package:flutter/material.dart';

class CycleOverviewScreen extends StatelessWidget {
  const CycleOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy (bisa nanti diambil dari API/backend)
    final totalCycles = 6;
    final avgCycleLength = 28;
    final avgDuration = 5;
    final shortestCycle = 25;
    final longestCycle = 32;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cycle Overview"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📅 Jumlah Siklus Tercatat",
                style: Theme.of(context).textTheme.titleMedium),
            Text("➡️ $totalCycles siklus\n", style: const TextStyle(fontSize: 16)),

            Text("📊 Rata-rata Panjang Siklus",
                style: Theme.of(context).textTheme.titleMedium),
            Text("➡️ $avgCycleLength hari\n", style: const TextStyle(fontSize: 16)),

            Text("🩸 Rata-rata Lama Menstruasi",
                style: Theme.of(context).textTheme.titleMedium),
            Text("➡️ $avgDuration hari\n", style: const TextStyle(fontSize: 16)),

            Text("⏱️ Siklus Terpendek",
                style: Theme.of(context).textTheme.titleMedium),
            Text("➡️ $shortestCycle hari\n", style: const TextStyle(fontSize: 16)),

            Text("⏳ Siklus Terpanjang",
                style: Theme.of(context).textTheme.titleMedium),
            Text("➡️ $longestCycle hari", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  // Data dummy tanggal menstruasi
  final List<DateTime> menstruationDates = [
    DateTime(2025, 6, 21),
    DateTime(2025, 5, 24),
    DateTime(2025, 4, 27),
  ];

  // Fungsi untuk tandai menstruasi
  bool isMenstruation(DateTime day) {
    return menstruationDates.any((d) =>
        d.year == day.year && d.month == day.month && d.day == day.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalender Menstruasi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2024, 1, 1),
          lastDay: DateTime.utc(2026, 12, 31),
          focusedDay: focusedDay,
          selectedDayPredicate: (day) => isMenstruation(day),
          onDaySelected: (selected, focused) {
            setState(() {
              selectedDay = selected;
              focusedDay = focused;
            });
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, _) {
              final isM = isMenstruation(day);
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isM ? Colors.pink[200] : null,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: isM ? Colors.white : null,
                    fontWeight: isM ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MenstruationQuestionsScreen extends StatefulWidget {
  final int userId; 

  const MenstruationQuestionsScreen({Key? key, required this.userId}) : super(key: key); // ✅ Tambahkan required this.userId

  @override
  _MenstruationQuestionsScreenState createState() => _MenstruationQuestionsScreenState();
}

class _MenstruationQuestionsScreenState extends State<MenstruationQuestionsScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _lastPeriodDate;
  final TextEditingController _cycleLengthController = TextEditingController();
  final TextEditingController _periodDurationController = TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _lastPeriodDate != null) {
      final data = {
        "user_id": widget.userId, // ✅ Kirim user_id ke backend
        "last_period_date": _lastPeriodDate!.toIso8601String(),
        "cycle_length": int.parse(_cycleLengthController.text),
        "period_duration": int.parse(_periodDurationController.text),
        "symptoms": _symptomsController.text,
        "age": int.parse(_ageController.text),
      };

      final response = await http.post(
        Uri.parse("http://172.20.10.10:5000/submit-menstruation-data"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final predictedDate = result["predicted_next_period"];

        Navigator.pushNamed(context, '/prediction-result', arguments: predictedDate);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal submit data.")),
        );
      }
    }
  }

  @override
  void dispose() {
    _cycleLengthController.dispose();
    _periodDurationController.dispose();
    _symptomsController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pertanyaan Menstruasi")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  _lastPeriodDate == null
                      ? "Pilih tanggal menstruasi terakhir"
                      : "Tanggal terakhir: ${DateFormat.yMMMd().format(_lastPeriodDate!)}",
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _lastPeriodDate = picked;
                    });
                  }
                },
              ),
              TextFormField(
                controller: _cycleLengthController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Rata-rata panjang siklus (hari)"),
                validator: (value) => value!.isEmpty ? "Isi panjang siklus" : null,
              ),
              TextFormField(
                controller: _periodDurationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Durasi menstruasi (hari)"),
                validator: (value) => value!.isEmpty ? "Isi durasi menstruasi" : null,
              ),
              TextFormField(
                controller: _symptomsController,
                decoration: const InputDecoration(labelText: "Gejala (opsional)"),
              ),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Usia"),
                validator: (value) => value!.isEmpty ? "Isi usia" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

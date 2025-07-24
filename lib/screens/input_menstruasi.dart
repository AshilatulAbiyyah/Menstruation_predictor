import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';

class InputMenstruasiPage extends StatefulWidget {
  final int userId;

  const InputMenstruasiPage({super.key, required this.userId});

  @override
  State<InputMenstruasiPage> createState() => _InputMenstruasiPageState();
}

class _InputMenstruasiPageState extends State<InputMenstruasiPage> {
  DateTime? startDate;
  final _cycleController = TextEditingController();
  final _durationController = TextEditingController();

  void _submitData() async {
    if (startDate == null ||
        _cycleController.text.isEmpty ||
        _durationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua data wajib diisi")),
      );
      return;
    }

    final success = await ApiService.inputMenstruasi(
      widget.userId,
      DateFormat('yyyy-MM-dd').format(startDate!),
      int.parse(_cycleController.text),
      int.parse(_durationController.text),
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data berhasil dikirim")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal mengirim data")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Input Data Menstruasi")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(startDate == null
                  ? "Pilih tanggal mulai menstruasi"
                  : DateFormat('yyyy-MM-dd').format(startDate!)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    startDate = picked;
                  });
                }
              },
            ),
            TextField(
              controller: _cycleController,
              decoration: const InputDecoration(labelText: "Panjang Siklus (hari)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _durationController,
              decoration: const InputDecoration(labelText: "Durasi Menstruasi (hari)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text("Kirim Data"),
            ),
          ],
        ),
      ),
    );
  }
}
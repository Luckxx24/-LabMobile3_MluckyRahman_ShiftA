import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Daily extends StatefulWidget {
  const Daily({Key? key}) : super(key: key);

  @override
  _DailyState createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  final TextEditingController _kegiatanController = TextEditingController();
  final TextEditingController _jamController = TextEditingController();

  Future<bool> _saveKegiatan() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> activities = prefs.getStringList('activities') ?? [];

      Map<String, String> newActivity = {
        'activity': _kegiatanController.text,
        'time': _jamController.text,
      };

      activities.add(jsonEncode(newActivity));
      await prefs.setStringList('activities', activities);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Widget _showInput(TextEditingController controller, String placeholder) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: placeholder,
      ),
    );
  }

  Future<void> _showPopUp(String pesan) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(pesan),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Routine'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.grey,
        child: Column(
          children: [
            _showInput(_kegiatanController, 'Masukkan kegiatan Anda'),
            _showInput(_jamController, 'Masukkan jadwal kegiatan'),
            ElevatedButton(
              child: const Text('Simpan'),
              onPressed: () async {
                bool isSuccess = await _saveKegiatan();
                if (isSuccess) {
                  _showPopUp('Kegiatan berhasil disimpan!');
                  _kegiatanController.clear();
                  _jamController.clear();
                } else {
                  _showPopUp('Gagal menyimpan kegiatan. Coba lagi.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
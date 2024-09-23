import 'package:flutter/material.dart';
import 'sidemenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? namauser;
  List<Map<String, dynamic>> _dailyActivities = [];

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namauser = prefs.getString('username') ?? 'User';
    });
  }

  void _loadDaily() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> activities = prefs.getStringList('activities') ?? [];

    setState(() {
      _dailyActivities = activities.map((e) {
        final data = jsonDecode(e);
        return {'kegiatan': data['activity'], 'jam': data['time']};
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadDaily();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Datang ${namauser ?? ''}'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _dailyActivities.length,
        itemBuilder: (context, index) {
          final activity = _dailyActivities[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity['kegiatan']!,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    activity['jam']!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      drawer: const Sidemenu(),
    );
  }
}
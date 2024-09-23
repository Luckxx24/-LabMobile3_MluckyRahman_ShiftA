import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key : key);
@override
_LoginPageState createState() => _LoginPageState();

  }
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //ignore: prefer_typing_uninitialized_variables
  var namauser;

  Future<void> _saveUsername() async {
    // Inisialisasi Shared Preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Simpan username ke local storage
    prefs.setString('username', _usernameController.text);
  }

  Widget _showInput(TextEditingController namacontroller, String placeholder, bool isPassword) {
    return TextField(
      controller: namacontroller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: placeholder,
      ),
    );
  }

  Future<void> _showDialog(String pesan, Widget alamat) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(pesan),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => alamat),
                );
              },
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
        title: const Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _showInput(_usernameController, 'Masukkan username', false),
            _showInput(_passwordController, 'Masukkan password', true),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                if (_usernameController.text == 'Lucky' && _passwordController.text == '12345') {
                  // Simpan username
                  _saveUsername();
                  // Tampilkan alert
                  _showDialog('Anda berhasil login', const HomePage());
                } else {
                  // Tampilkan alert jika login gagal
                  _showDialog('Username dan password salah', const LoginPage());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

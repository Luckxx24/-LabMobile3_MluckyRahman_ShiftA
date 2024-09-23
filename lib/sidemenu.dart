import 'package:flutter/material.dart';
import 'mengisi.dart';
import 'home.dart';
import 'login.dart';


class Sidemenu extends StatelessWidget{
  const Sidemenu ({Key? key}) : super(key:key);

  Future<void> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('apakah anda yakin ingin Logout?'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>const LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context){
    return Drawer(
      child:ListView(
        children: [
          const DrawerHeader(
            child:Text('sidemenu'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: (){
              // navigasi ke halaman homepage
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage(),
              ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Jadwal Kegiatan'),
            onTap: (){
              // navigasi ke halamann about
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Daily(),
              ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: (){
              _showDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
          style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF1E40AF),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'Umum',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.person_outline, color: Colors.blue),
            title: const Text('Nama'),
            trailing: const Text('Mirel Geralyn.', style: TextStyle(color: Colors.grey)),
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.phone_android, color: Colors.blue),
            title: const Text('Nomor HP'),
            trailing: const Text('+62 878-6548-8316', style: TextStyle(color: Colors.grey)),
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.email_outlined, color: Colors.blue),
            title: const Text('Email'),
            trailing: const Text('mirelsimanjorang@gmail.com', style: TextStyle(color: Colors.grey)),
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.language, color: Colors.blue),
            title: const Text('Bahasa'),
            trailing: const Text('Indonesia', style: TextStyle(color: Colors.grey)),
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.dark_mode, color: Colors.blue),
            title: const Text('Mode Gelap'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Dark mode toggle
              },
            ),
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.notifications_active, color: Colors.blue),
            title: const Text('Notifikasi'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Toggle notifikasi
              },
            ),
          ),
          const Divider(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'Tentang',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.blue),
            title: const Text('Versi Aplikasi'),
            trailing: const Text('1.0.0', style: TextStyle(color: Colors.grey)),
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.developer_mode, color: Colors.blue),
            title: const Text('Dikembangkan oleh'),
            trailing: const Text('Mirel Tech', style: TextStyle(color: Colors.grey)),
          ),
          const Divider(height: 20),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Keluar'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Yakin ingin keluar dari akun Anda?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _logout(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  // Logika logout
  void _logout(BuildContext context) async {
    // Menghapus data autentikasi yang tersimpan
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus semua data yang tersimpan

    // Alihkan ke halaman login setelah logout
    Navigator.pushReplacementNamed(context, '/login'); // Gantilah '/login' dengan route halaman login Anda
  }
}

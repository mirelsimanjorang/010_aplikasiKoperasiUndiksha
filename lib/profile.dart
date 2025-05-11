import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'nasabah_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nasabah = context.watch<NasabahProvider>();
    final saldo = nasabah.saldo;
    final formattedSaldo = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2).format(saldo);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Nasabah',
          style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Foto Profil
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage('assets/mirel.jpg'),
            ),

            const SizedBox(height: 16), 

            
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Informasi Nasabah",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _infoRow("ID Nasabah", nasabah.idNasabah),
                    const Divider(),
                    _infoRow("Nama", nasabah.nama),
                    const Divider(),
                    _infoRow("No. Telepon", nasabah.nomorTelepon),
                    const Divider(),
                    _infoRow("Email", nasabah.email),
                    const Divider(),
                    _infoRow("Alamat", nasabah.alamat),
                    const Divider(),
                    _infoRow("Terdaftar Sejak", nasabah.tanggalRegistrasiFormatted),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Saldo
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.blue[50],
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet, color: Colors.blue[800]),
                title: const Text("Saldo Saat Ini"),
                subtitle: Text(
                  formattedSaldo,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Mengurangi jarak vertikal antar baris
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$title:",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

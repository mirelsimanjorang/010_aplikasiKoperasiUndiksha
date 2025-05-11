import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';  
import 'pengajuan_pinjaman.dart';
import 'nasabah_provider.dart'; 

class PinjamanPage extends StatefulWidget {
  const PinjamanPage({super.key});

  @override
  State<PinjamanPage> createState() => _PinjamanPageState();
}

class _PinjamanPageState extends State<PinjamanPage> {
  List<Map<String, String>> daftarPinjaman = [];

  @override
  void initState() {
    super.initState();
    _loadPinjaman();
  }

  Future<void> _loadPinjaman() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('pinjamanData') ?? [];
    setState(() {
      daftarPinjaman = data.map((item) => Map<String, String>.from(jsonDecode(item))).toList();
    });
  }

  Future<void> _savePinjaman() async {
    final prefs = await SharedPreferences.getInstance();
    final data = daftarPinjaman.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('pinjamanData', data);
  }

  Future<void> _tambahPinjaman() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PengajuanPinjamanPage(),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        daftarPinjaman.add(result);
      });
      await _savePinjaman();

      // Menambahkan transaksi ke mutasi
      context.read<NasabahProvider>().addTransaksi({
        'deskripsi': 'Pinjaman sebesar Rp ${result['jumlahPinjaman']} selama ${result['lamaPinjaman']} bulan',
        'jumlah': double.tryParse(result['jumlahPinjaman']!) ?? 0, // Pinjaman sebagai pemasukan
        'waktu': DateFormat('HH:mm:ss').format(DateTime.now()),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pinjaman',
          style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF1E40AF),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Pinjaman Anda',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (daftarPinjaman.isEmpty)
              const Text('Belum ada pinjaman aktif.')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: daftarPinjaman.length,
                  itemBuilder: (context, index) {
                    final pinjaman = daftarPinjaman[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const Icon(Icons.account_balance_wallet),
                        title: Text('Rp ${pinjaman['jumlahPinjaman']}'),
                        subtitle: Text('${pinjaman['lamaPinjaman']} bulan'),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _tambahPinjaman,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,),
                label: const Text(
                  'Ajukan Pinjaman Baru',
                  style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E40AF),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  
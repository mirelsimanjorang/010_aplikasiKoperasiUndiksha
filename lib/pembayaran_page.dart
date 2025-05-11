import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'nasabah_provider.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  List<Map<String, String>> daftarPembayaran = [];

  @override
  void initState() {
    super.initState();
    _loadPembayaran();
  }

  // Load data pembayaran dari SharedPreferences
  Future<void> _loadPembayaran() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('pembayaranData') ?? [];
    setState(() {
      daftarPembayaran = data.map((item) => Map<String, String>.from(jsonDecode(item))).toList();
    });
  }

  // Menyimpan data pembayaran ke SharedPreferences
  Future<void> _savePembayaran() async {
    final prefs = await SharedPreferences.getInstance();
    final data = daftarPembayaran.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('pembayaranData', data);
  }

  // Fungsi untuk menambahkan pembayaran dan transaksi
  Future<void> _tambahPembayaran() async {
    final controllerJumlah = TextEditingController();
    final controllerTanggal = TextEditingController();

    // Tampilkan dialog untuk menambah pembayaran
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Pembayaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controllerJumlah,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Jumlah Pembayaran'),
            ),
            TextField(
              controller: controllerTanggal,
              decoration: const InputDecoration(labelText: 'Tanggal Pembayaran'),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  controllerTanggal.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Menutup dialog
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controllerJumlah.text.isNotEmpty && controllerTanggal.text.isNotEmpty) {
                final jumlahPembayaran = double.tryParse(controllerJumlah.text);
                if (jumlahPembayaran == null) {
                  // Menampilkan error jika input jumlah bukan angka
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Jumlah pembayaran harus angka valid')),
                  );
                  return;
                }

                // Menambahkan pembayaran ke dalam daftar
                setState(() {
                  daftarPembayaran.add({
                    'jumlah': controllerJumlah.text,
                    'tanggal': controllerTanggal.text,
                  });
                });

                // Menambahkan transaksi pengeluaran ke dalam NasabahProvider
                final transaksi = {
                  'deskripsi': 'Pengeluaran: Pembayaran Rp ${controllerJumlah.text}',  // Deskripsi pengeluaran
                  'jumlah': -jumlahPembayaran,  // Angka jumlah sebagai pengeluaran
                  'waktu': controllerTanggal.text,
                };

                // Mengupdate saldo nasabah setelah pembayaran
                final nasabahProvider = context.read<NasabahProvider>();
                nasabahProvider.updateSaldo(nasabahProvider.saldoNasabah - jumlahPembayaran);

                // Menambahkan transaksi ke provider
                nasabahProvider.addTransaksi(transaksi);

                // Menyimpan data pembayaran ke SharedPreferences
                _savePembayaran();
                Navigator.pop(context); // Menutup dialog setelah simpan
              } else {
                // Menampilkan error jika input kosong
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Isi semua data pembayaran')),
                );
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pembayaran',
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
              'Riwayat Pembayaran',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (daftarPembayaran.isEmpty)
              const Text('Belum ada pembayaran tercatat.')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: daftarPembayaran.length,
                  itemBuilder: (context, index) {
                    final pembayaran = daftarPembayaran[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const Icon(Icons.payment),
                        title: Text('Rp ${pembayaran['jumlah']}'),
                        subtitle: Text('Tanggal: ${pembayaran['tanggal']}'),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 10),
            Text(
              'Saldo Tersisa: Rp ${context.watch<NasabahProvider>().saldoNasabah}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _tambahPembayaran, // Menambahkan pembayaran
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Tambah Pembayaran',
                  style: TextStyle(color: Colors.white),
                  ),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'nasabah_provider.dart';

class TambahTransaksiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Transaksi',
          style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Membuat transaksi baru
            final transaksi = {
              'deskripsi': 'Pembayaran Internet',
              'waktu': DateTime.now().toString(),
              'jumlah': -50000, // Pengeluaran
            };
            // Menambahkan transaksi ke provider
            context.read<NasabahProvider>().addTransaksi(transaksi);
            // Menampilkan SnackBar untuk memberi tahu pengguna
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Transaksi berhasil ditambahkan')),
            );
          },
          child: const Text('Tambah Transaksi'),
        ),
      ),
    );
  }
}

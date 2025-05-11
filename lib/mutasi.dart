import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'nasabah_provider.dart';

class MutasiPage extends StatelessWidget {
  const MutasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data transaksi dari provider
    final mutasi = context.watch<NasabahProvider>().transaksi;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Mutasi',
          style: TextStyle(
            color: Colors.white, 
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: mutasi.isEmpty
          ? const Center(child: Text('Tidak ada mutasi transaksi'))
          : ListView.builder(
              itemCount: mutasi.length,
              itemBuilder: (context, index) {
                final transaksi = mutasi[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(transaksi['deskripsi']),
                    subtitle: Text('${transaksi['waktu']}'),
                    trailing: Text(
                      transaksi['jumlah'] < 0
                          ? 'Pengeluaran: ${transaksi['jumlah']}'
                          : 'Pemasukan: ${transaksi['jumlah']}',
                      style: TextStyle(
                        color: transaksi['jumlah'] < 0
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

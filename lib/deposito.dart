import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'nasabah_provider.dart';

class DepositoPage extends StatefulWidget {
  const DepositoPage({super.key});

  @override
  State<DepositoPage> createState() => _DepositoPageState();
}

class _DepositoPageState extends State<DepositoPage> {
  final _jumlahController = TextEditingController();
  final _tokenController = TextEditingController();

  void _depositSaldo(BuildContext context) {
    final jumlah = double.tryParse(_jumlahController.text.replaceAll(',', '').replaceAll('.', '')) ?? 0;
    final token = _tokenController.text.trim();

    if (jumlah <= 0 || token.isEmpty) {
      _showDialog('Jumlah deposito atau token tidak valid');
      return;
    }

    if (token != '321') {
      _showDialog('Token salah. Silakan coba lagi.');
      return;
    }

    final formattedJumlah = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    ).format(jumlah);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi Deposito'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Apakah Anda yakin ingin mendepositokan sejumlah:'),
            const SizedBox(height: 8),
            Text(
              formattedJumlah,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              final saldo = context.read<NasabahProvider>().saldo;
              context.read<NasabahProvider>().updateSaldo(saldo + jumlah);
              Navigator.pop(context); // tutup konfirmasi
              _showDialog('Deposito berhasil sejumlah $formattedJumlah');

              // Menambahkan transaksi deposito ke daftar mutasi
              context.read<NasabahProvider>().addTransaksi({
                'deskripsi': 'Deposito sejumlah $formattedJumlah',
                'jumlah': jumlah, // Deposit berarti pemasukan
                'waktu': DateFormat('HH:mm:ss').format(DateTime.now()),
              });

              _jumlahController.clear();
              _tokenController.clear();
            },
            child: const Text('Ya, Setor'),
          ),
        ],
      ),
    );
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Informasi'),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final saldo = context.watch<NasabahProvider>().saldo;
    final formattedSaldo = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2).format(saldo);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Deposito',
          style: TextStyle(color: Colors.white),
          ),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('Saldo Saat Ini: $formattedSaldo', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: _jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah Deposito',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tokenController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Token',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _depositSaldo(context),
                icon: const Icon(
                  Icons.savings,
                  color: Colors.white),
                label: const Text(
                  'Deposit',
                  style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white, 
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

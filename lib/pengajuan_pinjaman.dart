import 'package:flutter/material.dart';

class PengajuanPinjamanPage extends StatefulWidget {
  const PengajuanPinjamanPage({super.key});

  @override
  State<PengajuanPinjamanPage> createState() => _PengajuanPinjamanPageState();
}

class _PengajuanPinjamanPageState extends State<PengajuanPinjamanPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _lamaController = TextEditingController();

  void _ajukanPinjaman() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'jumlahPinjaman': _jumlahController.text,
        'lamaPinjaman': _lamaController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajukan Pinjaman',
          style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF1E40AF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _jumlahController,
                decoration: const InputDecoration(labelText: 'Jumlah Pinjaman (Rp)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Masukkan jumlah pinjaman' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _lamaController,
                decoration: const InputDecoration(labelText: 'Lama Pinjaman (bulan)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Masukkan lama pinjaman' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _ajukanPinjaman,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E40AF),
                ),
                child: const Text(
                  'Ajukan',
                  style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

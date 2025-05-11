import 'package:flutter/material.dart';

class NasabahProvider extends ChangeNotifier {
  // Data dasar nasabah
  String idNasabah = '2315091010';
  String nama = 'Mirel Geralyn Simanjorang';
  String nomorTelepon = '081234567890';
  String email = 'mirel@email.com';
  String alamat = 'Jl. Bhisma No. 76, Bali';
  DateTime tanggalRegistrasi = DateTime(2023, 1, 15);
  double saldo = 7000000;

  
  List<Map<String, dynamic>> transaksiList = [];

  
  void updateSaldo(double baru) {
    saldo = baru;
    notifyListeners();
  }

  
  void addTransaksi(Map<String, dynamic> transaksi) {
    transaksiList.add(transaksi);
    notifyListeners(); 
  }

  
  void addPembayaran(String jumlah, String tanggal) {
    
    final transaksi = {
      'deskripsi': 'Pembayaran: Rp $jumlah',
      'jumlah': double.parse(jumlah), 
      'waktu': tanggal,
    };

    addTransaksi(transaksi); // Panggil addTransaksi untuk menambahkan transaksi
  }

  // Fungsi untuk menambahkan pengeluaran ke dalam mutasi transaksi
  void addPengeluaran(String jumlah, String tanggal) {
    // Menambahkan data pengeluaran ke dalam mutasi
    final transaksi = {
      'deskripsi': 'Pengeluaran: Rp $jumlah',  // Deskripsi untuk pengeluaran
      'jumlah': -double.parse(jumlah),         // Jumlah pengeluaran dalam format negatif
      'waktu': tanggal,
    };

    addTransaksi(transaksi); // Panggil addTransaksi untuk menambahkan transaksi
  }

  // Fungsi untuk mendapatkan transaksi
  List<Map<String, dynamic>> get transaksi => transaksiList;

  // Fungsi untuk mendapatkan saldo
  double get saldoNasabah => saldo;

  // Fungsi untuk format tanggal registrasi
  String get tanggalRegistrasiFormatted {
    return '${tanggalRegistrasi.day}-${tanggalRegistrasi.month}-${tanggalRegistrasi.year}';
  }
}

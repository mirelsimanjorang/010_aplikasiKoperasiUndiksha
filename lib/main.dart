import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Halaman-halaman yang diimport
import 'login.dart';
import 'menu_utama.dart';
import 'nasabah_provider.dart';
import 'cek_saldo.dart';
import 'transfer_page.dart';
import 'deposito.dart';
import 'mutasi.dart'; 
import 'qr.dart';
import 'setting.dart';
import 'pinjaman_page.dart';
import 'pengajuan_pinjaman.dart';
import 'profile.dart';
import 'pembayaran_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (_) => NasabahProvider(),
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const MenuUtama() : const LoginPage(),
      routes: {
        '/login': (_) => const LoginPage(),
        '/cek_saldo': (_) => const CekSaldoPage(),
        '/transfer': (_) => const TransferPage(),
        '/deposito': (_) => const DepositoPage(),
        '/pembayaran': (_) => const PembayaranPage(),
        '/pinjaman': (_) => const PinjamanPage(),
        '/mutasi': (_) => const MutasiPage(),
        '/setting': (_) => const SettingPage(),
        '/qrcode': (_) => const QRCodeScreen(),
        '/profile': (_) => const ProfilePage(),
        '/ajukan_pinjaman': (_) => const PengajuanPinjamanPage(),
      },
    );
  }
}

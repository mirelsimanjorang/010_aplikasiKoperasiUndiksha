import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'nasabah_provider.dart';  // Pastikan sudah menyiapkan Provider yang sesuai

class MenuUtama extends StatefulWidget {
  const MenuUtama({super.key});

  @override
  _MenuUtamaState createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  String namaNasabah = 'Mirel Geralyn Simnjorang';

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged_in');
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final saldo = context.watch<NasabahProvider>().saldo;
    final formattedSaldo = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    ).format(saldo);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Menu Utama',
          style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E40AF), 
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Konfirmasi', style: TextStyle(color: Colors.black)),
                  content: const Text('Apakah Anda yakin ingin keluar?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () => _logout(context),
                      child: const Text('Keluar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Kartu Profil dan Saldo
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage('assets/mirel.jpg'), // Ganti dengan foto sesuai
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          _infoCard('Nasabah', namaNasabah),
                          const SizedBox(height: 5),
                          _infoCard('Total Saldo Anda', formattedSaldo),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Menu Navigasi
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/cek_saldo'),
                      child: _menuCard(Icons.account_balance_wallet, 'Cek Saldo'),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/transfer'),
                      child: _menuCard(Icons.send, 'Transfer'),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/deposito'),
                      child: _menuCard(Icons.savings, 'Deposito'),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/pembayaran'),
                      child: _menuCard(Icons.payment, 'Pembayaran'),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/pinjaman'),
                      child: _menuCard(Icons.money, 'Pinjaman'),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/mutasi'),
                      child: _menuCard(Icons.receipt, 'Mutasi'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Bantuan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Butuh Bantuan?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text(
                        '0878-1234-1024',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.phone, color: const Color(0xFF1E40AF), size: 60),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Bottom Menu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/setting'),
                    child: _bottomMenu(Icons.settings, 'Setting', false),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/qrcode'),
                    child: _bottomMenu(Icons.qr_code, 'QR Code', true),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/profile'),
                    child: _bottomMenu(Icons.person, 'Profile', false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _infoCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFD7DDFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }

  static Widget _menuCard(IconData icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFFD6D6D6),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Icon(icon, size: 36, color: const Color(0xFF1E40AF)),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  static Widget _bottomMenu(IconData icon, String title, bool isMain) {
    final double size = isMain ? 70 : 50;

    return Column(
      children: [
        Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMain ? const Color(0xFF0A237E) : Colors.white,
            borderRadius: BorderRadius.circular(isMain ? 35 : 10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
            border: isMain
                ? null
                : Border.all(color: const Color(0xFF0A237E), width: 2),
          ),
          child: Icon(
            icon,
            size: isMain ? 40 : 25,
            color: isMain ? Colors.white : const Color(0xFF0A237E),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

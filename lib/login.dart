import 'package:flutter/material.dart';
import 'menu_utama.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key}); // 

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Harap isi username dan password!")),
      );
      return;
    }

    if (username == "2315091010" && password == "2315091010") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuUtama()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username atau password salah!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          buildHeader(),
          buildLogo(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    buildLoginForm(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          buildFooter(),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      width: double.infinity,
      color: Color(0xFF0D47A1),
      padding: EdgeInsets.symmetric(vertical: 18),
      child: Center(
        child: Text(
          "Koperasi Undiksha",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
          ),
        ),
      ),
    );
  }

  Widget buildLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Image.asset(
        'assets/logo.png',
        height: 150,
      ),
    );
  }

  Widget buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: "Username",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey, width: 1.5),
              ),
              prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey, width: 1.5),
              ),
              prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: login,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0D47A1),
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
            ),
            child: Text(
              "Login",
              style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Arial'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFooter() {
    return Container(
      width: double.infinity,
      color: const Color.fromARGB(255, 179, 200, 240),
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Text(
          "Copyright ©2025 by Undiksha",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SiparisSayfa extends StatefulWidget {
  const SiparisSayfa({super.key});

  @override
  State<SiparisSayfa> createState() => _SiparisSayfaState();
}

class _SiparisSayfaState extends State<SiparisSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Siparişler',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orange ,Colors.orangeAccent], // Gradient renkleri
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Siparişler"),
      ),
    );
  }
}

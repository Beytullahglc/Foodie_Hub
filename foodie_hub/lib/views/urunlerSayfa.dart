import 'package:flutter/material.dart';

class UrunlerSayfa extends StatefulWidget {
  const UrunlerSayfa({super.key});

  @override
  State<UrunlerSayfa> createState() => _UrunlerSayfaState();
}

class _UrunlerSayfaState extends State<UrunlerSayfa> {

  bool aramaYapiliyorMu = false;
  String aramaSonucu = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? TextField(
          decoration: const InputDecoration(
            hintText: "Ara",
            hintStyle: TextStyle(color: Colors.black),
          ),
          style: const TextStyle(color: Colors.black),
          onChanged: (value) {
            setState(() {
              aramaSonucu = value;
            });
          },
        )
            : const Text(
          'Ürünler',
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
        actions: [
          aramaYapiliyorMu
              ? IconButton(
            color: Colors.black,
            icon: const Icon(Icons.cancel_outlined),
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = false;
                aramaSonucu = ""; // Arama iptal edilince arama sonucunu temizle
              });
            },
          )
              : IconButton(
            color: Colors.black,
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = true;
              });
            },
          ),
        ],
      ),
      body: const Center(
        child: Text("Ürünler"),
      ),
    );
  }
}

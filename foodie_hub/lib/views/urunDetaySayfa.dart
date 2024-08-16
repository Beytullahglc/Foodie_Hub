import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodie_hub/entity/urunler.dart';

class UrunDetaySayfa extends StatefulWidget {
  final Urunler urun;
  const UrunDetaySayfa({super.key, required this.urun});

  @override
  State<UrunDetaySayfa> createState() => _UrunDetaySayfaState();
}

class _UrunDetaySayfaState extends State<UrunDetaySayfa> {
  final DatabaseReference refSiparisler =
  FirebaseDatabase.instance.ref().child("siparisler_tablo");

  final TextEditingController adetController = TextEditingController();

  Future<void> siparisEkle() async {
    var bilgi = HashMap<String, dynamic>();
    bilgi["urunAdi"] = widget.urun.urunAd;
    bilgi["siparisAdeti"] = int.parse(adetController.text); // Değeri al
    await refSiparisler.push().set(bilgi); // await ekle
    _showSnackBar(); // SnackBar göster
  }

  void _showSnackBar() {
    const snackBar = SnackBar(
      content: Text('Siparişiniz başarıyla verildi!'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    double ekranYuksekligi = ekranBilgisi.size.height;
    double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 120, left: 10, right: 10, bottom: 50),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10.0), // Görüntünün köşe yuvarlaklığı
                    border: Border.all(
                      color: Colors.orange, // Kenar çizgisi rengi
                      width: 1.0, // Kenar çizgisi kalınlığı
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orangeAccent.withOpacity(
                            0.5), // Gölge rengi
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Gölge konumu
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10.0), // Görüntünün köşe yuvarlaklığı
                    child: Image.asset(
                      widget.urun.urunResim, // Görüntünün yolunu belirtin
                      width: ekranGenisligi * 3 / 4,
                      fit: BoxFit.cover, // Görüntüyü boyutlandırma modu
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 8, right: 8, bottom: 30),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10.0), // Görüntünün köşe yuvarlaklığı
                    color: Colors.orange,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orangeAccent.withOpacity(
                            0.5), // Gölge rengi
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Gölge konumu
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(widget.urun.urunAd,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                            "${widget.urun.urunFiyat.toString()} TL",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 15, right: 15, bottom: 50),
                child: TextField(
                  controller: adetController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Adet",
                    hintStyle: TextStyle(color: Colors.orange),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                  onPressed: () {
                    siparisEkle();
                  },
                  child: const Text(
                    "Sepete Ekle",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

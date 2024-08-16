import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_hub/cubits/urunlerCubit.dart';
import 'package:foodie_hub/entity/urunler.dart';
import 'package:foodie_hub/views/urunDetaySayfa.dart';

class UrunlerSayfa extends StatefulWidget {
  const UrunlerSayfa({super.key});

  @override
  State<UrunlerSayfa> createState() => _UrunlerSayfaState();
}

class _UrunlerSayfaState extends State<UrunlerSayfa> {
  bool aramaYapiliyorMu = false;
  String aramaSonucu = "";
  var refUrunler = FirebaseDatabase.instance.ref().child("urunler_tablo");

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
              colors: [Colors.deepOrange, Colors.orange, Colors.orangeAccent],
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
                aramaSonucu = "";
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
      body: StreamBuilder<DatabaseEvent>(
        stream: refUrunler.onValue,
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            var urunListesi = <Urunler>[];
            var gelenDegerler = snapshot.data!.snapshot.value;


            if (gelenDegerler is Map) {
              (gelenDegerler).forEach((key, nesne) {
                // Verinin JSON formatında olduğunu varsayıyoruz
                var gelenUrun = Urunler.fromJson(key, nesne);
                urunListesi.add(gelenUrun);
              });

              if (aramaSonucu.isNotEmpty) {
                urunListesi = urunListesi.where((urun) {
                  return urun.urunAd
                      .toLowerCase()
                      .contains(aramaSonucu.toLowerCase());
                }).toList();
              }
            } else {
              return Center(child: Text('Beklenmedik veri türü: ${gelenDegerler.runtimeType}'));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2.5,
              ),
              itemCount: urunListesi.length,
              itemBuilder: (context, index) {
                var urun = urunListesi[index];
                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UrunDetaySayfa(urun: urun)));
                  },
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.orange,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: IconButton(
                                color: Colors.orange,
                                icon: urun.favoriMi
                                    ? const Icon(Icons.favorite)
                                    : const Icon(Icons.favorite_outline),
                                onPressed: () {
                                  var cubit = BlocProvider.of<UrunlerCubit>(context);
                                  cubit.favoriDurumunuDegistir(urun.urunId, !urun.favoriMi);
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: SizedBox(
                            height: 150,
                            child: Image.asset(
                              urun.urunResim,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text(
                                urun.urunAd,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.orange),
                              ),
                              const Spacer(),
                              Text(
                                "${urun.urunFiyat.toString()} TL",
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Veri bulunamadı'));
          }
        },
      ),
    );
  }
}
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_hub/cubits/sepetCubit.dart';
import 'package:foodie_hub/cubits/siparisCubit.dart';
import 'package:foodie_hub/cubits/adresCubit.dart'; // AdresCubit'i ekleyin
import 'package:foodie_hub/entity/sepet.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({super.key});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  var refSepet = FirebaseDatabase.instance.ref().child("sepet_tablo");

  String adres = "";

  @override
  void initState() {
    super.initState();
    _adresGetir();
  }

  Future<void> _adresGetir() async {
    var adresCubit = context.read<AdresCubit>();


    await adresCubit.adresleriYukle();


    var adresler = adresCubit.state;
    if (adresler.isNotEmpty) {
      setState(() {
        adres = adresler.first.adres;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void showSnackBar() {
      const snackBar = SnackBar(
        content: Text('Siparişiniz başarıyla verildi!'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    context.read<SepetCubit>().sepetiYukle();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sepetim',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orange, Colors.orangeAccent], // Gradient renkleri
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SepetCubit, List<Sepet>>(
        builder: (context, sepetUrunleri) {
          if (sepetUrunleri.isEmpty) {
            return const Center(child: Text('Sepetiniz boş'));
          }

          return ListView.builder(
            itemCount: sepetUrunleri.length,
            itemBuilder: (context, index) {
              final urun = sepetUrunleri[index];
              return GestureDetector(
                onTap: () async {},
                child: Card(
                  shadowColor: Colors.orange,
                  child: SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Image.asset(urun.urunResim.toLowerCase()),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "${urun.sepetAdeti} Adet",
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.remove_shopping_cart),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Sepetten Sil"),
                                            content: const Text("Bu ürünü silmek istediğinizden emin misiniz?"),
                                            actions: [
                                              TextButton(
                                                child: const Text("Evet"),
                                                onPressed: () {
                                                  context.read<SepetCubit>().sepettenKaldir(urun.sepetId);
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text("Hayır"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          setState(() {
            var sepetCubit = context.read<SepetCubit>();
            var siparisCubit = BlocProvider.of<SiparisCubit>(context);

            var sepetUrunleri = sepetCubit.state; // Sepetteki ürünler

            siparisCubit.siparisEkle(sepetUrunleri, adres); // Siparişe çevir ve kaydet
          });
          showSnackBar();
        },
        child: const Icon(Icons.assignment_return_outlined, color: Colors.white),
      ),
    );
  }
}

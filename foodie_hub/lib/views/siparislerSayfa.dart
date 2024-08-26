import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_hub/cubits/siparisCubit.dart';
import 'package:foodie_hub/entity/siparisler.dart';

class SiparisSayfa extends StatefulWidget {
  const SiparisSayfa({super.key});

  @override
  State<SiparisSayfa> createState() => _SiparisSayfaState();
}

class _SiparisSayfaState extends State<SiparisSayfa> {
  @override
  void initState() {
    super.initState();
    context.read<SiparisCubit>().siparisleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Siparişler',
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
      ),
      body: BlocBuilder<SiparisCubit, List<Siparisler>>(
        builder: (context, siparisler) {
          if (siparisler.isEmpty) {
            return const Center(child: Text('Sipariş bulunamadı'));
          }

          return ListView.builder(
            itemCount: siparisler.length,
            itemBuilder: (context, index) {
              final siparis = siparisler[index];
              final ilkUrun = siparis.urunler.isNotEmpty ? siparis.urunler[0] : {}; // İlk ürüne erişim

              return ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sipariş: ${ilkUrun['urunAd'] ?? 'Ürün Adı'}'), // İlk ürünün adı
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Siparişi silmek için onay diyaloğu ekleyebilirsiniz
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Siparişi Sil'),
                            content: Text('Bu siparişi silmek istediğinizden emin misiniz?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.read<SiparisCubit>().siparisiSil(siparis.siparisId);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Evet'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Hayır'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: siparis.urunler.length,
                    itemBuilder: (context, urunIndex) {
                      final urun = siparis.urunler[urunIndex];
                      return ListTile(
                        title: Text(urun['urunAd']),
                        subtitle: Text('Adet: ${urun['adet']}, Fiyat: ${urun['fiyat']}'),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Toplam Tutar: ${siparis.toplamTutar}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Sipariş Tarihi: ${siparis.siparisTarihi}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Teslimat Adresi: ${siparis.adres ?? 'Adres belirtilmemiş'}'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

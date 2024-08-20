import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_hub/entity/sepet.dart';
import 'package:foodie_hub/entity/siparisler.dart';
import 'package:foodie_hub/repo/urunlerdao_repository.dart';


class SiparisCubit extends Cubit<List<Siparisler>>{
  SiparisCubit () : super([]);

  final UrunlerDaoRepository urepo = UrunlerDaoRepository();
  final refUrunler = FirebaseDatabase.instance.ref().child("urunler_tablo");
  final refSepet = FirebaseDatabase.instance.ref().child("sepet_tablo");
  final refSiparis = FirebaseDatabase.instance.ref().child("siparisler_tablo");


  Future<void> siparisEkle(List<Sepet> sepetUrunleri) async {
    if (sepetUrunleri.isNotEmpty) {
      // Ürün isimlerini, adetlerini ve toplam tutarı hesaplayalım
      List<Map<String, dynamic>> urunBilgileri = [];
      double toplamTutar = 0;

      for (var urun in sepetUrunleri) {
        urunBilgileri.add({
          "urunAd": urun.urunAd,
          "adet": urun.sepetAdeti,
          "fiyat": urun.urunFiyat,
        });
        toplamTutar += urun.urunFiyat * urun.sepetAdeti;
      }

      var siparisBilgisi = <String, dynamic>{
        "siparisId": "", // ID Firebase tarafından atanacak
        "urunler": urunBilgileri, // Ürün adları ve adetleri ile birlikte
        "toplamTutar": toplamTutar,
        "siparisTarihi": DateTime.now().toString(),
      };

      await refSiparis.push().set(siparisBilgisi);

      // Sipariş eklendikten sonra sepeti temizleyin
      for (var urun in sepetUrunleri) {
        await FirebaseDatabase.instance.ref().child("sepet_tablo").child(urun.sepetId).remove();
      }
    }
  }

  Future<void> siparisleriYukle() async {
    try {
      final snapshot = await refSiparis.once();
      final gelenDegerler = snapshot.snapshot.value;

      if (gelenDegerler != null && gelenDegerler is Map<dynamic, dynamic>) {
        final siparisListesi = gelenDegerler.entries
            .map((entry) => Siparisler.fromJson(entry.key, entry.value))
            .toList();

        emit(siparisListesi);
      } else {
        emit([]);
        print("Beklenmeyen veri formatı: $gelenDegerler");
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }
}
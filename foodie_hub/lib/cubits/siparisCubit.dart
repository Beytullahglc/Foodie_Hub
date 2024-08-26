import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_hub/entity/sepet.dart';
import 'package:foodie_hub/entity/siparisler.dart';

class SiparisCubit extends Cubit<List<Siparisler>> {
  SiparisCubit() : super([]);

  final refUrunler = FirebaseDatabase.instance.ref().child("urunler_tablo");
  final refSepet = FirebaseDatabase.instance.ref().child("sepet_tablo");
  final refSiparis = FirebaseDatabase.instance.ref().child("siparisler_tablo");

  Future<void> siparisiSil(String siparisId) async {
    await refSiparis.child(siparisId).remove();
    await siparisleriYukle(); // Listeyi güncellemek için tekrar yükleme yapılır
  }

  Future<void> siparisEkle(List<Sepet> sepetUrunleri, String? teslimatAdres) async {
    if (sepetUrunleri.isNotEmpty) {
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
        "siparisId": "",
        "urunler": urunBilgileri,
        "toplamTutar": toplamTutar,
        "siparisTarihi": DateTime.now().toString(),
        "adres": teslimatAdres ?? 'Adres belirtilmemiş', // Adres ekleme
      };

      await refSiparis.push().set(siparisBilgisi);

      for (var urun in sepetUrunleri) {
        await FirebaseDatabase.instance
            .ref()
            .child("sepet_tablo")
            .child(urun.sepetId)
            .remove();
      }
    }
  }

  Future<void> siparisleriYukle() async {
    refSiparis.onValue.listen((event) {
      var gelenDegerler = event.snapshot.value as Map<dynamic, dynamic>?;

      if (gelenDegerler != null) {
        var siparisListe = <Siparisler>[];
        gelenDegerler.forEach((key, nesne) {
          try {
            var siparis = Siparisler.fromJson(key, Map<String, dynamic>.from(nesne));
            siparisListe.add(siparis);
          } catch (e) {
            print("Hata: $e");
          }
        });
        emit(siparisListe);
      }
    });
  }
}

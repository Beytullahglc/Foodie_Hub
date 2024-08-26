import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_hub/entity/sepet.dart';
import 'package:foodie_hub/entity/urunler.dart';

class SepetCubit extends Cubit<List<Sepet>>{

  SepetCubit () : super (<Sepet>[]);

  final refUrunler = FirebaseDatabase.instance.ref().child("urunler_tablo");
  final refSepet = FirebaseDatabase.instance.ref().child("sepet_tablo");
  final refSiparisler = FirebaseDatabase.instance.ref().child("siparisler_tablo");

  Future<void> sepeteEkle(Urunler urun, int adet) async {
    var bilgi = <dynamic, dynamic>{
      "urunId": urun.urunId,
      "urunFiyat": urun.urunFiyat,
      "urunAd": urun.urunAd,
      "favoriMi": urun.favoriMi,
      "urunStok": urun.urunStok,
      "urunResim": urun.urunResim,
      "sepetAdeti": adet,
      "sepetId" : "",
    };

    await refSepet.push().set(bilgi);

  }


  Future<void> sepetiYukle() async {
    final DatabaseReference sepetRef = FirebaseDatabase.instance.ref().child('sepet_tablo');
    final DatabaseEvent event = await sepetRef.once();

    final List<Sepet> loadedUrunler = [];
    final DataSnapshot snapshot = event.snapshot;
    final sepetMap = snapshot.value as Map<dynamic, dynamic>?;

    if (sepetMap != null) {
      sepetMap.forEach((key, value) {
        final urun = Sepet.fromJson(key ,value);
        loadedUrunler.add(urun);
      });
    }

    emit(loadedUrunler); // Verileri state'e emit ediyoruz
  }

  Future<void> sepettenKaldir(String sepetId) async {
    try {
      await refSepet.child(sepetId).remove();
      sepetiYukle();
    } catch (e) {
      print("Error removing item from sepet: $e");
    }
  }

  // Sepetteki Ürünleri Sipariş Verme Metodu
  Future<void> siparisVer() async {
    try {
      final snapshot = await refSepet.once();
      final sepetUrunleri = snapshot.snapshot.value as Map<dynamic, dynamic>;

      for (var entry in sepetUrunleri.entries) {
        await refSiparisler.push().set(entry.value);
      }

      // Siparişten sonra sepeti temizle
      await refSepet.remove();
    } catch (e) {
      print('Sipariş verme hatası: $e');
    }
  }
}
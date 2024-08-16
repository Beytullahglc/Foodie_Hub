import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_hub/entity/urunler.dart';
import 'package:foodie_hub/repo/urunlerdao_repository.dart';

class SepetCubit extends Cubit<List<Urunler>>{

  SepetCubit () : super (<Urunler>[]);

  final UrunlerDaoRepository urepo = UrunlerDaoRepository();
  final refUrunler = FirebaseDatabase.instance.ref().child("urunler_tablo");
  final refSepet = FirebaseDatabase.instance.ref().child("sepet_tablo");
  final refSiparisler = FirebaseDatabase.instance.ref().child("siparisler_tablo");

  Future<void> sepeteEkle(Urunler urun, int adet) async {
    var bilgi = <String, dynamic>{
      "urunId": urun.urunId,
      "urunFiyat": urun.urunFiyat,
      "urunAd": urun.urunAd,
      "favoriMi": urun.favoriMi,
      "urunStok": urun.urunStok,
      "urunResim": urun.urunResim,
      "adet": adet,
    };

    await refSepet.child(urun.urunId).set(bilgi);
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
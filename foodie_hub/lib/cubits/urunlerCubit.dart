import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_hub/entity/urunler.dart';

class UrunlerCubit extends Cubit<List<Urunler>> {
  UrunlerCubit() : super(<Urunler>[]);

  final refUrunler = FirebaseDatabase.instance.ref().child("urunler_tablo");

  Future<void> favoriDurumunuDegistir(String urunId, bool yeniDurum) async {
    var bilgi = <String, dynamic>{};
    bilgi["favoriMi"] = yeniDurum;

    try {
      await refUrunler.child(urunId).update(bilgi);
    } catch (e) {
      print("Favori durumu değiştirilemedi: $e");
    }
  }

  Future<void> urunleriYukle() async {
    try {
      final snapshot = await refUrunler.once();
      final gelenDegerler = snapshot.snapshot.value;

      if (gelenDegerler != null && gelenDegerler is Map<dynamic, dynamic>) {
        final urunListesi = gelenDegerler.entries
            .map((entry) => Urunler.fromJson(entry.key, entry.value))
            .toList();

        emit(urunListesi);
      } else {
        emit([]);
        print("Beklenmeyen veri formatı: $gelenDegerler");
      }
    } catch (e) {
      print('Ürünler yüklenirken hata oluştu: $e');
      emit([]);
    }
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_hub/entity/urunler.dart';
import 'package:foodie_hub/repo/urunlerdao_repository.dart';

class UrunlerCubit extends Cubit<List<Urunler>> {
  UrunlerCubit() : super(<Urunler>[]);

  final UrunlerDaoRepository urepo = UrunlerDaoRepository();
  final refUrunler = FirebaseDatabase.instance.ref().child("urunler_tablo");

  Future<void> favoriDurumunuDegistir(String urunId, bool yeniDurum) async {
    // Map'i doğru bir şekilde başlatıyoruz
    var bilgi = <String, dynamic>{};
    bilgi["favoriMi"] = yeniDurum;

    // Firebase veritabanında güncelleme yapıyoruz
    await refUrunler.child(urunId).update(bilgi);
  }


  Future<void> urunleriYukle() async {
    try {
      final snapshot = await refUrunler.once();
      final gelenDegerler = snapshot.snapshot.value as Map<dynamic, dynamic>;

      final urunListesi = gelenDegerler.entries
          .map((entry) => Urunler.fromJson(entry.key, entry.value))
          .toList();

      emit(urunListesi);
    } catch (e) {
      // Hata durumunda uygun bir işlem yap (örneğin, kullanıcıya hata mesajı göster)
      print('Hata oluştu: $e');
    }
  }
}
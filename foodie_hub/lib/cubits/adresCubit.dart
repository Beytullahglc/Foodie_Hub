import 'package:bloc/bloc.dart';
import 'package:foodie_hub/entity/adres.dart';
import 'package:firebase_database/firebase_database.dart';

class AdresCubit extends Cubit<List<Adres>> {
  AdresCubit() : super([]);

  var refAdresler = FirebaseDatabase.instance.ref().child("adresler");

  Future<void> adresleriYukle() async {
    refAdresler.onValue.listen((event) {
      var gelenDegerler = event.snapshot.value as Map<dynamic, dynamic>?;
      print("Gelen Değerler: $gelenDegerler"); // Debug için

      if (gelenDegerler != null) {
        var adresListe = <Adres>[];
        gelenDegerler.forEach((key, nesne) {
          try {
            var adres = Adres.fromJson(Map<String, dynamic>.from(nesne as Map));
            print("Adres: $adres"); // Debug için
            adresListe.add(adres);
          } catch (e) {
            print("Hata: $e");
          }
        });
        print("Emit ediliyor: adresListe - $adresListe"); // Debug için
        emit(adresListe);
      }
    });
  }

  Future<void> adresiGuncelle(String adresId, String yeniAdres) async {
    var bilgi = {'adres': yeniAdres};
    await refAdresler.child(adresId).update(bilgi);
  }
}

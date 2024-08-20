import 'package:foodie_hub/entity/urunler.dart';

class Siparisler {
  String siparisId;
  List<Map<String, dynamic>> urunler;
  double toplamTutar;
  String siparisTarihi;

  Siparisler({
    required this.siparisId,
    required this.urunler,
    required this.toplamTutar,
    required this.siparisTarihi,
  });

  factory Siparisler.fromJson(String key, Map<dynamic, dynamic> json) {
    List<Map<String, dynamic>> urunlerListesi = (json['urunler'] as List<dynamic>)
        .map((item) => item as Map<String, dynamic>)
        .toList();

    return Siparisler(
      siparisId: key,
      urunler: urunlerListesi,
      toplamTutar: json['toplamTutar'] as double,
      siparisTarihi: json['siparisTarihi'] as String,
    );
  }
}

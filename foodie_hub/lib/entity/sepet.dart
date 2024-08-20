import 'package:foodie_hub/entity/urunler.dart';

class Sepet extends Urunler {
  String sepetId;
  int sepetAdeti;

  Sepet({
    required super.urunId,
    required super.urunAd,
    required super.urunFiyat,
    required super.urunResim,
    required super.favoriMi,
    required super.urunStok,
    required this.sepetId,
    required this.sepetAdeti,
  });

  factory Sepet.fromJson(String key, Map<dynamic, dynamic> json) {
    return Sepet(
      urunId: json['urunId'] as String,
      urunAd: json['urunAd'] as String,
      urunFiyat: json['urunFiyat'] as int,
      urunResim: json['urunResim'] as String,
      favoriMi: json['favoriMi'] as bool,
      urunStok: json['urunStok'] as int,
      sepetId: key,
      sepetAdeti: json['sepetAdeti'] as int,
    );
  }
}
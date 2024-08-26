class Siparisler {
  String siparisId;
  List<Map<String, dynamic>> urunler;
  double toplamTutar;
  String siparisTarihi;
  String adres; // Teslimat adresi eklenmiş

  Siparisler({
    required this.siparisId,
    required this.urunler,
    required this.toplamTutar,
    required this.siparisTarihi,
    required this.adres,
  });

  factory Siparisler.fromJson(String key, Map<String, dynamic> json) {
    List<Map<String, dynamic>> urunlerListesi = (json['urunler'] as List<dynamic>)
        .map((item) => Map<String, dynamic>.from(item))
        .toList();

    return Siparisler(
      siparisId: key,
      urunler: urunlerListesi,
      toplamTutar: json['toplamTutar'] is int
          ? (json['toplamTutar'] as int).toDouble()
          : json['toplamTutar'],
      siparisTarihi: json['siparisTarihi'] as String,
      adres: json['adres'] as String, // Adres bilgisi alınıyor
    );
  }
}

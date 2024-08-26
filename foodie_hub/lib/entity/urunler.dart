class Urunler {
  String urunId;
  int urunFiyat;
  String urunAd;
  bool favoriMi;
  int urunStok;
  String urunResim;

  Urunler({
    required this.urunId,
    required this.urunFiyat,
    required this.urunAd,
    required this.favoriMi,
    required this.urunStok,
    required this.urunResim,
  });

  factory Urunler.fromJson(String key, Map<dynamic, dynamic> json) {
    return Urunler(
      urunId: key, // Gelen key değerini urunId olarak kullanıyoruz
      urunFiyat: json["urunFiyat"] as int? ?? 0, // Default değer 0
      urunAd: json["urunAd"] as String? ?? '', // Default değer boş string
      favoriMi: json["favoriMi"] as bool? ?? false, // Default değer false
      urunStok: json["urunStok"] as int? ?? 0, // Default değer 0
      urunResim: json["urunResim"] as String? ?? '', // Default değer boş string
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "urunId": urunId,
      "urunFiyat": urunFiyat,
      "urunAd": urunAd,
      "favoriMi": favoriMi,
      "urunStok": urunStok,
      "urunResim": urunResim,
    };
  }
}

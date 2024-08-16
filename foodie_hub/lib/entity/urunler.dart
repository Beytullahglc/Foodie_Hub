class Urunler{
  String urunId;
  int urunFiyat;
  String urunAd;
  bool favoriMi;
  int urunStok;
  String urunResim;

  Urunler({required this.urunId, required this.urunFiyat, required this.urunAd,
    required this.favoriMi, required this.urunStok, required this.urunResim});

  factory Urunler.fromJson(String key, Map<dynamic,dynamic> json){
    return Urunler(
        urunId: key,
        urunFiyat: json["urunFiyat"] as int,
        urunAd: json["urunAd"] as String,
        favoriMi: json["favoriMi"] as bool,
        urunStok: json["urunStok"] as int,
        urunResim: json["urunResim"] as String
    );
  }

}
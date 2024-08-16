class Siparisler{
  String siparisId;
  String urunAd;
  int siparisAdeti;

  Siparisler(this.siparisId, this.urunAd, this.siparisAdeti);

  factory Siparisler.fromJson(String key, Map<dynamic,dynamic> json){
    return Siparisler(key, json["urunAd"] as String, json["siparisAdeti"] as int);
  }
}
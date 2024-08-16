class Sepet{
  String sepetId;
  String urunAd;
  int sepetAdeti;

  Sepet({required this.sepetId, required this.urunAd, required this.sepetAdeti});

  factory Sepet.fromJson(String key, Map<dynamic,dynamic> json){
    return Sepet(sepetId:  key, urunAd:  json["urunAd"] as String, sepetAdeti:  json["siparisAdeti"] as int);
  }
}
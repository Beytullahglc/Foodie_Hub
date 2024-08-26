class Adres{
  final String adres;

  Adres({
    required this.adres,
  });

  factory Adres.fromJson(Map<String, dynamic> json) {
    return Adres(
      adres: json['adres'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adres': adres,
    };
  }
}
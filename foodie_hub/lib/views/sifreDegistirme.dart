import 'package:flutter/material.dart';
import 'package:foodie_hub/views/sayfalar.dart';

class SifreDegistirme extends StatefulWidget {
  const SifreDegistirme({super.key});

  @override
  State<SifreDegistirme> createState() => _SifreDegistirmeState();
}

class _SifreDegistirmeState extends State<SifreDegistirme>
    with TickerProviderStateMixin {
  late AnimationController iconKontrol;
  late Animation<double> iconAnimasyonDegerleri;

  @override
  void initState() {
    super.initState();

    iconKontrol = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    iconAnimasyonDegerleri = Tween(begin: 0.0, end: 250.0)
        .animate(CurvedAnimation(parent: iconKontrol, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });

    iconKontrol.forward();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    double ekranYuksekligi = ekranBilgisi.size.height;
    double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: ekranYuksekligi * 0.1), // Üst boşluk
              SizedBox(
                width: iconAnimasyonDegerleri.value,
                height: iconAnimasyonDegerleri.value,
                child: Image.asset("assets/foodieHub.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: ekranGenisligi * 4 / 5,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "e-Posta",
                      hintStyle: TextStyle(color: Colors.orange),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: ekranGenisligi * 4 / 5,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Şifre",
                      hintStyle: TextStyle(color: Colors.orange),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: ekranGenisligi * 4 / 5,
                  child: TextField(
                    controller: passwordAgainController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Şifre (Tekrar)",
                      hintStyle: TextStyle(color: Colors.orange),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 10),
                child: SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text(
                      "Kaydet",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Sayfalar()),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: ekranYuksekligi * 0.1), // Alt boşluk
            ],
          ),
        ),
      ),
    );
  }
}

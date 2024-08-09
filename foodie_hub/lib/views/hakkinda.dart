import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Hakkinda extends StatefulWidget {
  const Hakkinda({super.key});

  @override
  State<Hakkinda> createState() => _HakkindaState();
}

class _HakkindaState extends State<Hakkinda> {
  String appVersion = "";

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Hakkında',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orange ,Colors.orangeAccent], // Gradient renkleri
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent, // Sınır rengini değiştirmek için
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: const Text("Hizmetlerimiz",style: TextStyle(fontSize: 20,color: Colors.black),),
                iconColor: Colors.orange, // İkonun rengi açık olduğunda
                collapsedIconColor: Colors.orange, // İkonun rengi kapalı olduğunda
                children: const <Widget>[
                  ListTile(
                    title: Text("Dilediğiniz yemeğe kolay ve hızlıca sipariş verebilme, "
                        "ürünleri favorileme gibi birçok hizmetimiz mevcut"),
                  ),
                ],
              ),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent, // Sınır rengini değiştirmek için
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: const Text("Misyonumuz",style: TextStyle(fontSize: 20,color: Colors.black),),
                iconColor: Colors.orange, // İkonun rengi açık olduğunda
                collapsedIconColor: Colors.orange, // İkonun rengi kapalı olduğunda
                children: <Widget>[
                  const ListTile(
                    title: Text("Lezzetli yemekleri keşfetme deneyimini "
                        "kolaylaştırmak ve herkese uygun seçenekler sunmak"),
                  ),
                ],
              ),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent, // Sınır rengini değiştirmek için
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: const Text("Vizyonumuz",style: TextStyle(fontSize: 20,color: Colors.black),),
                iconColor: Colors.orange, // İkonun rengi açık olduğunda
                collapsedIconColor: Colors.orange, // İkonun rengi kapalı olduğunda
                children: <Widget>[
                  const ListTile(
                    title: Text("Yemek kültürünü zenginleştirirken, kullanıcılarımızın her öğününde tatmin edici, "
                        "sürdürülebilir ve yenilikçi seçenekler sunarak, global yemek trendlerine yön veren bir lider olmak."),
                  ),
                ],
              ),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent, // Sınır rengini değiştirmek için
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: const Text("Uygulama Versiyonu",style: TextStyle(fontSize: 20,color: Colors.black),),
                iconColor: Colors.orange, // İkonun rengi açık olduğunda
                collapsedIconColor: Colors.orange, // İkonun rengi kapalı olduğunda
                children: <Widget>[
                  ListTile(
                    title: Text("$appVersion"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

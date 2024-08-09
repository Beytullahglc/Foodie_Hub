import 'package:flutter/material.dart';
import 'package:foodie_hub/views/adres.dart';
import 'package:foodie_hub/views/hakkinda.dart';
import 'package:foodie_hub/views/main.dart';
import 'package:foodie_hub/views/sifreDegistirme.dart';

class Ayarlar extends StatefulWidget {
  const Ayarlar({super.key});

  @override
  State<Ayarlar> createState() => _AyarlarState();
}

class _AyarlarState extends State<Ayarlar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Ayarlar',
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
      body:  ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: ListTile(
              title: const Text("Hesap Değiştir",style: TextStyle(color: Colors.black,fontSize: 20),),
              trailing: const Icon(Icons.arrow_right,color: Colors.orange,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: "",)));
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top:10,bottom: 10),
            child: ListTile(
              title: const Text("Şifre Değiştir",style: TextStyle(color: Colors.black, fontSize: 20),),
              trailing: const Icon(Icons.arrow_right,color: Colors.orange,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SifreDegistirme()));
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top:10,bottom: 10),
            child: ListTile(
              title: const Text("Adres",style: TextStyle(color: Colors.black, fontSize: 20),),
              trailing: const Icon(Icons.arrow_right,color: Colors.orange,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Adres()));
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top:10,bottom: 10),
            child: ListTile(
              title: const Text("Hakkında",style: TextStyle(color: Colors.black, fontSize: 20),),
              trailing: const Icon(Icons.arrow_right,color: Colors.orange,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Hakkinda()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

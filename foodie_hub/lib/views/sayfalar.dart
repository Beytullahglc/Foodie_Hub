import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodie_hub/views/ayarlar.dart';
import 'package:foodie_hub/views/favorilerSayfa.dart';
import 'package:foodie_hub/views/sepetSayfa.dart';
import 'package:foodie_hub/views/siparislerSayfa.dart';
import 'package:foodie_hub/views/urunlerSayfa.dart';

class Sayfalar extends StatefulWidget {
  const Sayfalar({super.key});

  @override
  State<Sayfalar> createState() => _SayfalarState();
}

class _SayfalarState extends State<Sayfalar> {
  int page = 2; // Varsayılan olarak 3. sayfa seçili

  var sayfaListesi = [
    const SiparisSayfa(),
    const SepetSayfa(),
    const UrunlerSayfa(),
    const FavoriSayfa(),
    const Ayarlar()
  ];

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sayfaListesi[page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: page,
        items: <Widget>[
          Icon(page == 0 ? Icons.assignment : Icons.assignment_outlined,
              size: 30, color: page == 0 ? Colors.white : Colors.black),
          Icon(page == 1 ? Icons.shopping_cart : Icons.shopping_cart_outlined,
              size: 30, color: page == 1 ? Colors.white : Colors.black),
          Icon(page == 2 ? Icons.inventory_2 : Icons.inventory_2_outlined,
              size: 30, color: page == 2 ? Colors.white : Colors.black),
          Icon(page == 3 ? Icons.favorite : Icons.favorite_outline,
              size: 30, color: page == 3 ? Colors.white : Colors.black),
          Icon( page == 4 ? Icons.settings : Icons.settings_outlined,
              size: 30, color: page == 4 ? Colors.white : Colors.black),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.orange,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (int index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

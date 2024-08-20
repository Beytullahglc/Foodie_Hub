import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_hub/cubits/sepetCubit.dart';
import 'package:foodie_hub/cubits/siparisCubit.dart';
import 'package:foodie_hub/cubits/urunlerCubit.dart';
import 'package:foodie_hub/firebase_options.dart';
import 'package:foodie_hub/service/auth.dart';
import 'package:foodie_hub/views/sayfalar.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
          BlocProvider<UrunlerCubit>(
            create: (context) => UrunlerCubit(),
          ),
          BlocProvider<SepetCubit>(
            create: (context) => SepetCubit(),
          ),
        BlocProvider<SiparisCubit>(
          create: (context) => SiparisCubit(),
        ),
      ],
      child: MaterialApp(
        title: '',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: ''),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  late AnimationController iconKontrol;
  late Animation<double> iconAnimasyonDegerleri;

  var refUrunler = FirebaseDatabase.instance.ref().child("urunler_tablo");
  var refSepet = FirebaseDatabase.instance.ref().child("sepet_tablo");
  var refSiparis = FirebaseDatabase.instance.ref().child("siparisler_tablo");

  bool isLogin = true;
  String? errorMessage;

  Future<void> createUser() async{
    try{
      await Auth().createUser(email: emailController.text, password: passwordController.text);
    }on FirebaseAuthException catch(e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signIn(BuildContext context) async{
    try{
      await Auth().signIn(email: emailController.text, password: passwordController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Sayfalar()));
    }on FirebaseAuthException catch(e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> sepetEkle() async{
    var bilgi = HashMap<String,dynamic>();
    bilgi["sepetId"] = "";
    bilgi["urunAd"] = "Döner";
    bilgi["sepetAdeti"] = 2;

    refSepet.push().set(bilgi);
  }

  Future<void> siparisEkle() async {
    final refSiparis = FirebaseDatabase.instance.ref().child("siparisler_tablo");

    // Sipariş detaylarını tanımlayın
    var siparisBilgisi = <String, dynamic>{
      "siparisId": "", // Firebase tarafından otomatik atanacak
      "urunler": [
        {
          "urunAd": "Döner",
          "adet": 2,
          "fiyat": 50,
        },
        {
          "urunAd": "Pide",
          "adet": 1,
          "fiyat": 30,
        }
      ],
      "toplamTutar": 130,
      "siparisTarihi": DateTime.now().toString(),
    };

    // Veriyi Firebase'e ekleyin
    await refSiparis.push().set(siparisBilgisi);
  }


  @override
  void dispose() {
    iconKontrol.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    //sepetEkle();
    //siparisEkle();

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

  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    double ekranYuksekligi = ekranBilgisi.size.height;
    double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "e Mail",
                    hintStyle: TextStyle(color: Colors.orange),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2.0), // Seçili durumdaki kenar rengi
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
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.orange),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2.0), // Seçili durumdaki kenar rengi
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
            ),

            errorMessage != null ? Text(errorMessage!) : const SizedBox.shrink(),

            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              child: SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: isLogin? const Text("Giriş Yap",style: TextStyle(color: Colors.white),)
                      : const Text("Kayıt Ol",style: TextStyle(color: Colors.white)),
                  onPressed: (){
                    if(isLogin){
                      signIn(context);
                    }else{
                      createUser();
                    }
                  },
                ),
              ),
            ),
            TextButton(
              child: const Text("Kayıt Ol", style: TextStyle(color: Colors.orange),),
              onPressed: (){
                setState(() {
                  isLogin = !isLogin;
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}

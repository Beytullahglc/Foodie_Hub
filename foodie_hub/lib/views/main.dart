import 'package:flutter/material.dart';
import 'package:foodie_hub/views/sayfalar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
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
                  controller: passwordController,
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

            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              child: SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text("Giriş Yap",style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Sayfalar()));
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text("Kayıt Ol", style: TextStyle(color: Colors.orange),),
                  onPressed: (){

                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    child: const Text("Şifremi Unuttum", style: TextStyle(color: Colors.orange),),
                    onPressed: (){

                    },
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

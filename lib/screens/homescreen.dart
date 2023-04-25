import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    int plastic = 20;
    int cans = 10;
    int nivel = 2;
    String nomeUsuario = "Dow";
    final DatabaseReference _ref = FirebaseDatabase.instance.ref('users');
    late StreamSubscription _subscription;

    @override
    void initState() {
      super.initState();
      _subscription = _ref.child('nome').onValue.listen((event) {
        setState(() {
          nomeUsuario = event.snapshot.value as String;
          print(nomeUsuario);
        });
      });
    }

    return Scaffold(
      /*drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: CircleAvatar(
                  child: Text('DOW'),
                )),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => print('aawasdsas'),
            ),
          ],
        ),
      ),*/
      appBar: AppBar(
        title: const Text('SUSTENDOW', style: TextStyle(fontSize: 30)),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Transform.rotate(
                              angle: -3 * math.pi / 4,
                              child: CircularPercentIndicator(
                                progressColor:
                                    Color.fromARGB(255, 233, 236, 233),
                                radius: 85,
                                lineWidth: 25,
                                percent: 0.75,
                                circularStrokeCap: CircularStrokeCap.round,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Transform.rotate(
                              angle: -3 * math.pi / 4,
                              child: CircularPercentIndicator(
                                progressColor: Colors.green,
                                radius: 85,
                                lineWidth: 25,
                                percent: 0.30,
                                circularStrokeCap: CircularStrokeCap.round,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Nivel\n$nivel',
                                    style: TextStyle(fontSize: 35),
                                    textAlign: TextAlign.center,
                                  ),
                                ])
                          ]),
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.green,
                                  width: 6,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  "lib\\assets\\images\\logo_DOW.png"),
                              radius: 90,
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Olá, $nomeUsuario',
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                                textAlign: TextAlign.center),
                            Icon(
                              Icons.waving_hand_rounded,
                              color: Colors.green,
                              size: 45,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                  color: Colors.green,
                  height: 20,
                  thickness: 5.5,
                  indent: 20,
                  endIndent: 20),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Recicle', style: TextStyle(fontSize: 30)),
                              IconButton(
                                iconSize: 100,
                                highlightColor:
                                    Color.fromARGB(255, 161, 216, 163),
                                hoverColor: Color.fromARGB(255, 161, 216, 163),
                                isSelected: true,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: Container(
                                            height: 80,
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20)),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, left: 20),
                                              child: Text(
                                                'Reciclar',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          titlePadding: const EdgeInsets.all(0),
                                          content: Image.asset(
                                              "lib\\assets\\images\\barcode.png",
                                              scale: 0.25,
                                              width: 400,
                                              height: 300),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: Text('OK',
                                                  style:
                                                      TextStyle(fontSize: 35)),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.recycling,
                                  color: Colors.green,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Pontos de Coleta',
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.center,
                              ),
                              IconButton(
                                iconSize: 80,
                                highlightColor:
                                    Color.fromARGB(255, 161, 216, 163),
                                hoverColor: Color.fromARGB(255, 161, 216, 163),
                                isSelected: true,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: Container(
                                            height: 80,
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20)),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, left: 20),
                                              child: Text(
                                                'Pontos de Coleta',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          titlePadding: const EdgeInsets.all(0),
                                          content: SizedBox(
                                            width: 500,
                                            height: 600,
                                            child: ListView(
                                              shrinkWrap: true,
                                              children: const [
                                                Text(
                                                    'Ponto de Coleta 1\nRua 1, 123\nBairro 1\nCidade 1\nCEP 12345-678\nTelefone: (11) 1234-5678'),
                                                Divider(
                                                  height: 10,
                                                  color: Colors.black,
                                                  thickness: 1,
                                                ),
                                                Text(
                                                    'Ponto de Coleta 2\nRua 2, 456\nBairro 2\nCidade 2\nCEP 12345-678\nTelefone: (11) 1234-5678'),
                                                Divider(
                                                  height: 10,
                                                  color: Colors.black,
                                                  thickness: 1,
                                                ),
                                                Text(
                                                    'Ponto de Coleta 3\nRua 3, 789\nBairro 3\nCidade 3\nCEP 12345-678\nTelefone: (11) 1234-5678'),
                                                Divider(
                                                  height: 10,
                                                  color: Colors.black,
                                                  thickness: 1,
                                                ),
                                                Text(
                                                    'Ponto de Coleta 4\nRua 4, 012\nBairro 4\nCidade 4\nCEP 12345-678\nTelefone: (11) 1234-5678'),
                                                Divider(
                                                  height: 10,
                                                  color: Colors.black,
                                                  thickness: 1,
                                                ),
                                                Text(
                                                    'Ponto de Coleta 5\nRua 5, 345\nBairro 5\nCidade 5\nCEP 12345-678\nTelefone: (11) 1234-5678'),
                                                Divider(
                                                  height: 10,
                                                  color: Colors.black,
                                                  thickness: 1,
                                                ),
                                                Text(
                                                    'Ponto de Coleta 6 \nRua 6, 678\nBairro 6\nCidade 6\nCEP 12345-678\nTelefone: (11) 1234-5678'),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: Text('OK',
                                                  style:
                                                      TextStyle(fontSize: 35)),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Info',
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.center,
                              ),
                              IconButton(
                                iconSize: 100,
                                highlightColor:
                                    Color.fromARGB(255, 161, 216, 163),
                                hoverColor: Color.fromARGB(255, 161, 216, 163),
                                isSelected: true,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: Container(
                                            height: 80,
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20)),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, left: 20),
                                              child: Text(
                                                'Informaões de Reciclagem',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          titlePadding: const EdgeInsets.all(0),
                                          content: SizedBox(
                                            width: 500,
                                            height: 400,
                                            child: Text(
                                              '$plastic garrafas recicladas\n$cans latas recicladas\n',
                                              style: TextStyle(
                                                  fontSize: 30, height: 1.5),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: Text('OK',
                                                  style:
                                                      TextStyle(fontSize: 35)),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.info_outline_rounded,
                                  color: Colors.green,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),

              SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: Colors.green,
                                size: 40,
                              ),
                              Text(
                                'Dicas de Reciclagem',
                                style: TextStyle(fontSize: 40),
                              ),
                              Icon(
                                Icons.lightbulb_outline,
                                color: Colors.green,
                                size: 40,
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            softWrap: true,
                            '1. Separe os materiais recicláveis',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            softWrap: true,
                            '2. Coloque os materiais recicláveis em sacos plásticos',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            softWrap: true,
                            '3. Coloque os sacos plásticos em um local de fácil acesso',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Text(
                            softWrap: true,
                            '4. Leve os sacos plásticos ate o tótem de coleta mais próximo',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //noticias sobre reciclagem
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: Colors.green,
                                size: 40,
                              ),
                              Text(
                                'Notícias sobre Reciclagem',
                                style: TextStyle(fontSize: 40),
                              ),
                              Icon(
                                Icons.lightbulb_outline,
                                color: Colors.green,
                                size: 40,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            '1. Notícia 1',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            '2. Notícia 2',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            '3. Notícia 3',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            '4. Notícia 4',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              )
              //get data from recycle newsleters
            ],
          ),
        ),
      ),
    );
  }
}

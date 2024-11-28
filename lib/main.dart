import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_curd/addcontact.dart';
import 'package:flutter/material.dart';

import 'ListPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA1YazrsyxZYj39q09EN5ptxqsiLg5u9lM",
          projectId: "fir-curd-6e27b",
          messagingSenderId: "689550437433",
          appId: "1:689550437433:web:3f618e4c488a254c82b1e8"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(tab == 0 ? "List Page" : "Add contacts"),
        ),
        bottomNavigationBar: Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Colors.red, Colors.blue],
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    tab = 0;
                  });
                },
                icon: const Icon(
                  Icons.list_alt_rounded,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    tab = 1;
                  });
                },
                icon: const Icon(
                  Icons.add_ic_call_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
        body: tab == 0 ? Listpage() : Addcontact()
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ),
        );
  }
}

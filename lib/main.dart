import 'package:animal_fetch/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/animal_provider.dart';

Future<void> main() async {
  //our flutter releted configation must initialized 1st before firebase
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // adding contect services at root of application
    return ChangeNotifierProvider<AnimalProvider>(
       create: (context) => AnimalProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dog fetching',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  HomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

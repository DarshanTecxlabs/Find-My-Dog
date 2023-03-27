import 'dart:async';
import 'dart:math';

import 'package:animal_fetch/photobook.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider/animal_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  bool textbool = false;

  getupImages() async {
    AnimalProvider myPhotoList = Provider.of(context, listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();
    myPhotoList.contectList = pref.getStringList("dogs") ?? [];
  }

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('No Connection'),
            content: const Text('Please check your internet connectivity'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  setState(() => isAlertSet = false);
                  isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected && isAlertSet == false) {
                    showDialogBox();
                    setState(() => isAlertSet = true);
                  }
                },
                child: const Text('OK'),
              ),
            ],
          ));

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void initState() {
    getConnectivity();
    getupImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "Find Your Dog",
          ),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.blue.withOpacity(.8),
            Colors.blue.withOpacity(.2),
          ])),
          child: Consumer<AnimalProvider>(
            builder: (context, value, child) => Column(children: [
              const SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  textbool == false
                      ? const Text(
                          "Welcome click on Let's Find to find your Dog",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )
                      : Container(),
                  value.myUrl != ""
                      ? Container(
                          margin: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  colors: [
                                    Colors.blue.withOpacity(.8),
                                    Colors.blue.withOpacity(.2),
                                  ]),
                              image: DecorationImage(
                                scale: 400.0,
                                opacity: 400.0,
                                image: NetworkImage(value.myUrl),
                                fit: BoxFit.cover,
                              )),
                          child: Image.network(
                            value.myUrl,
                            height: 300,
                            width: double.infinity,
                          ),
                        )
                      : Container(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 10, right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        value.getAll();
                        setState(() {
                          textbool = true;
                        });
                      },
                      child: const Text("Let's Find"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 10, right: 10),
                    child: textbool != false
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const PhotoBook()));
                            },
                            child: const Text("Dog Book"),
                          )
                        : Container(),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}

import 'package:animal_fetch/provider/animal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoBook extends StatefulWidget {
  const PhotoBook({super.key});

  @override
  State<PhotoBook> createState() => _PhotoBookState();
}

class _PhotoBookState extends State<PhotoBook> {
  List? myPhotoList;
  @override
  void initState() {
    AnimalProvider myPhotoList = Provider.of(context, listen: false);
    this.myPhotoList = myPhotoList.contectList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Book"),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.blue.withOpacity(.8),
            Colors.blue.withOpacity(.2),
          ])),
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: myPhotoList?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(1),
                child: myPhotoList != []
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(myPhotoList![index]),
                              fit: BoxFit.cover,
                            )),
                      )
                    : const Center(
                        child: Text(
                          "No Dogs please click on Let's Find ",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}

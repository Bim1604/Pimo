import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';

class CollectionProject extends StatelessWidget {
  //Khai báo những thuộc tính có trong 1 object
  CollectionProject(
      {this.title = "Placeholder Title",
        this.name,
        this.collectionId,
        this.description,
        this.img = "",
        this.tap = defaultFunc});

  final String name;
  final String description;
  final String img;
  final int collectionId;
  final Function tap;
  final String title;

  factory CollectionProject.fromJson(Map<String, dynamic> json) {
    return CollectionProject(
      name: json['listCollectionProject'][1]['collection']['name'],
      description: json['listCollectionProject'][1]['collection']['description'],
      img: json['listCollectionProject'][1]['imageList']['fileName'],
    );
  }

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: 130,
          margin: EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: tap,
            child: Stack(overflow: Overflow.clip, children: [
              Card(
                elevation: 0.7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                child: Row(
                  children: [
                    Flexible(flex: 1, child: Container()),
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title,
                                  style: TextStyle(
                                      color: MaterialColors.caption,
                                      fontSize: 15)),
                              Text(name,
                                  style: TextStyle(
                                      color: MaterialColors.muted,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              FractionalTranslation(
                translation: Offset(0.0, -0.09),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, bottom: 0, left: 13, right: 13),
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16, bottom: 0, top: 16),
                        height: 127,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: Offset(0, 0))
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            image: DecorationImage(
                                image: NetworkImage(img), fit: BoxFit.cover))),
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}
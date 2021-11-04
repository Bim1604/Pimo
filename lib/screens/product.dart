import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/models/brand.dart';

//widgets
import 'package:pimo/widgets/navbar.dart';
import 'package:pimo/widgets/slider.dart';
import 'package:pimo/widgets/product-size-picker.dart';
import 'package:pimo/screens/chat.dart';
import 'package:intl/intl.dart';

class Product extends StatelessWidget {
  final double height = window.physicalSize.height;
  final String urlImg;
  final String title;
  final String brandName;
  final String logo;
  final String description;
  final String address;
  final String salary;
  final String openTime;
  final String closeTime;
  final String gender;
  final String style;
  final String request;

  Product(
      {this.brandName = "Hello",
      this.logo = "",
      this.description = "Hello",
      this.address = "",
      this.salary = "",
      this.openTime = "",
      this.closeTime = "",
      this.gender = "",
      this.style = "",
      this.request = "",
      this.title = "Shoes",
      this.urlImg = "https://via.placeholder.com/250"});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [urlImg, urlImg];
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: "",
          transparent: true,
          backButton: false,
          bgColor: MaterialColors.mainColor,
        ),
        backgroundColor: MaterialColors.bgColorScreen,
        body: SingleChildScrollView(
          child: Stack(children: [
            Container(
                height: 0.18 * height, child: ImageSlider(imgArray: imgList)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 8,
                              blurRadius: 10,
                              offset: Offset(0, 0))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(13.0),
                          topRight: Radius.circular(13.0),
                        )),
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.48,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Stack(children: [
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          child: SafeArea(
                            bottom: true,
                            top: false,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 80.0),
                                  child: Text(title,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Avatar
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(logo),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("$brandName",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              // Text('Casting tại: ' + address,
                                              //     style: TextStyle(
                                              //         color:
                                              //             MaterialColors.muted)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Text("${salary}VNĐ",
                                    //     style: TextStyle(
                                    //         fontWeight: FontWeight.w600,
                                    //         fontSize: 16))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0, bottom: 6),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Thông tin chi tiết",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500))),
                                ),
                                SizedBox(
                                    width: 4,
                                    height: 4),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: MaterialColors.mainColor
                                              .withOpacity(0.5),
                                          offset: Offset(0, 5),
                                          blurRadius: 10,
                                        )
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [

                                          Padding(
                                            padding: EdgeInsets.only(top: 4, right: 5),
                                            child:
                                                Icon(Icons.transgender, size: 20),
                                          ),
                                          Text(
                                            'Giới tính: ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors
                                                    .black), // padding: EdgeInsets.symmetric(vertical: 5),
                                          ),
                                          Spacer(),
                                          Text('Người mẫu ' + gender)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(right: 5),
                                              child: Icon(
                                                Icons.location_on_outlined,
                                                size: 20,
                                              )),
                                          Text(
                                            'Địa điểm: ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          Spacer(),
                                          Text('${address}' ?? '')
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(right: 5),
                                              child: Icon(
                                                Icons.star_border_outlined,
                                                size: 20,
                                              )),
                                          Text(
                                            'Phong cách: ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          Spacer(),
                                          Text('${style}' ?? ''),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(right: 5),
                                              child: Icon(
                                                Icons.timer,
                                                size: 20,
                                              )),
                                          Text(
                                            'Bắt đầu: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Text('${openTime}' ?? ''),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(right: 5),
                                              child: Icon(
                                                Icons.timer_off_outlined,
                                                size: 20,
                                              )),
                                          Text(
                                            'Kết thúc: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Text('${closeTime}' ?? ''),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 4),
                                            child: Icon(Icons.attach_money,
                                                size: 20),
                                          ),
                                          Text('Tiền luơng: ',
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                          Spacer(),
                                          Text(
                                            salary + 'VNĐ' ?? '',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amberAccent),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // ProductSizePicker(),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Công việc",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                SizedBox(
                                    width: 4,
                                    height: 4),
                                //Mô tả
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: MaterialColors.mainColor
                                              .withOpacity(0.5),
                                          offset: Offset(0, 5),
                                          blurRadius: 10,
                                        )
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 8,
                                        height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Icon(
                                                Icons.description_outlined,
                                                size: 20),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                description ?? '',
                                                maxLines: 10,
                                                // softWrap: true,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Yêu cầu",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500))),
                                ),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: MaterialColors.mainColor
                                              .withOpacity(0.5),
                                          offset: Offset(0, 5),
                                          blurRadius: 10,
                                        )
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                          width: 4,
                                          height: 4),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 5, left: 2),
                                            child: Icon(
                                                Icons.speaker_notes_outlined,
                                                size: 20),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                request.isEmpty ? 'Hiện tại chưa có yêu cầu nào' : request,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                        onPressed: () {},
                                        textColor: Colors.white,
                                        color: MaterialColors.buttonColor,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16.0),
                                        child: Text("ỨNG TUYỂN",
                                            style: TextStyle(fontSize: 16))),
                                  ),
                                )
                              ],
                            ),
                          )),
                      FractionalTranslation(
                        translation: Offset(-0.04, -0.08),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: MaterialColors.primary,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Chat()));
                              },
                              icon: Icon(Icons.message),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ])))
          ]),
        ));
  }
}

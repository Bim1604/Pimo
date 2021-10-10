import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import "package:http/http.dart" as http;
import 'dart:convert';


class Brands {
  //Khai báo những thuộc tính có trong 1 object
  Brands({this.id, this.description, this.name});
  final int id;
  final String description;
  final String name;
  factory Brands.fromJson(Map<String, dynamic> json) {
    return Brands(
      name: json['casting']['name'],
      id: json['casting']['id'],
      description: json['casting']['decription'],
    );
  }

// final int id;
// final String name;
// final String description;
// final int status;
// final int brandCateId;
// final String mail;
// final String address;
// final String phone;
// final String logo;
}

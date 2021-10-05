import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/utils/google_sign_in.dart';
import 'package:pimo/widgets/drawer-tile.dart';
import 'package:provider/provider.dart';
class MaterialDrawer extends StatelessWidget {
  final String currentPage;

  MaterialDrawer({this.currentPage});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Container(
          child: Column(children: [
        DrawerHeader(
            decoration: BoxDecoration(color: MaterialColors.drawerHeader),
            child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                  child: Text(user.displayName,
                      style: TextStyle(color: Colors.white, fontSize: 21)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: MaterialColors.label),
                            child: Text("Pro",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text("Người mẫu",
                            style: TextStyle(
                                color: MaterialColors.muted, fontSize: 16)),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text("4.8",
                                style: TextStyle(
                                    color: MaterialColors.warning,
                                    fontSize: 16)),
                          ),
                          Icon(Icons.star_border,
                              color: MaterialColors.warning, size: 20)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ))),
        Expanded( // List view sidebar
            child: ListView(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            DrawerTile(
                icon: Icons.home,
                onTap: () {
                  if (currentPage != "Home")
                    Navigator.pushReplacementNamed(context, '/home');
                },
                iconColor: Colors.black,
                title: "Trang chủ",
                isSelected: currentPage == "Home" ? true : false),
            DrawerTile(
                icon: Icons.local_activity_outlined,
                onTap: () {
                  if (currentPage != "Thương hiệu")
                    Navigator.pushReplacementNamed(context, '/woman');
                },
                iconColor: Colors.black,
                title: "Thương hiệu",
                isSelected: currentPage == "Thương hiệu" ? true : false),
            DrawerTile(
                icon: Icons.connect_without_contact_outlined,
                onTap: () {
                  if (currentPage != "Casting")
                    Navigator.pushReplacementNamed(context, '/man');
                },
                iconColor: Colors.black,
                title: "Casting",
                isSelected: currentPage == "Casting" ? true : false),
            DrawerTile(
                icon: Icons.task,
                onTap: () {
                  if (currentPage != "Nhiệm vụ")
                    Navigator.pushReplacementNamed(context, '/kids');
                },
                iconColor: Colors.black,
                title: "Nhiệm vụ",
                isSelected: currentPage == "Nhiệm vụ" ? true : false),
            DrawerTile(
                icon: Icons.settings_accessibility_outlined,
                onTap: () {
                  if (currentPage != "Cơ thể")
                    Navigator.pushReplacementNamed(context, '/newcollection');
                },
                iconColor: Colors.black,
                title: "Cơ thể",
                isSelected: currentPage == "Cơ thể" ? true : false),
            DrawerTile(
                icon: Icons.settings_input_component,
                onTap: () {
                  if (currentPage != "Components")
                    Navigator.pushReplacementNamed(context, '/components');
                },
                iconColor: Colors.black,
                title: "Components",
                isSelected: currentPage == "Components" ? true : false),
            DrawerTile(
                icon: Icons.account_circle,
                onTap: () {
                  if (currentPage != "Hồ sơ")
                    Navigator.pushReplacementNamed(context, '/profile');
                },
                iconColor: Colors.black,
                title: "Hồ sơ",
                isSelected: currentPage == "Hồ sơ" ? true : false),
            DrawerTile(
                icon: Icons.settings,
                onTap: () {
                  if (currentPage != "Cài đặt")
                    Navigator.pushReplacementNamed(context, '/settings');
                },
                iconColor: Colors.black,
                title: "Cài đặt",
                isSelected: currentPage == "Điều chỉnh" ? true : false),
            DrawerTile(
                icon: Icons.exit_to_app,
                onTap: () {
                  if (currentPage != "Đăng xuất") {
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.logout();
                  }
                },
                iconColor: Colors.black,
                title: "Đăng xuất",
                isSelected: currentPage == "Đăng xuất" ? true : false),
          ],
        ))
      ])),
    );
  }
}

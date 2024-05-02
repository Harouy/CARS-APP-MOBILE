import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/pages/Deposez.dart';
import 'package:project/sidebar/menu_list.dart';
import 'package:rxdart/rxdart.dart';

import '../pages/Hompage.dart';

class SideBar extends StatefulWidget {
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationcontroller;
  late StreamController<bool> isSidebarStreamController;
  late StreamSink<bool> isSidebarOpenedSink;
  late Stream<bool> isSidebarOpenedStream;

  final _animationduration = const Duration(milliseconds: 500);
  void initState() {
    super.initState();
    _animationcontroller =
        AnimationController(vsync: this, duration: _animationduration);
    isSidebarStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarStreamController.stream;
    isSidebarOpenedSink = isSidebarStreamController.sink;
  }

  void dispose() {
    _animationcontroller.dispose();
    isSidebarStreamController.close();
    isSidebarOpenedSink.close();

    super.dispose();
  }

  void onMenuItemTapped(String title) {
    Navigator.pop(context); // Close the sidebar
    if (title == 'Découvrez') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (title == 'Déposez') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Deposez()),
      );
      // You can navigate to another page here
    } else if (title == 'Logout') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      // Handle logout action here
    }
  }

  void oniconpressed() {
    final animationstatus = _animationcontroller.status;
    final isanimationcompleted = animationstatus == AnimationStatus.completed;
    if (isanimationcompleted) {
      isSidebarOpenedSink.add(false);
      _animationcontroller.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationcontroller.forward();
    }
  }

  @override
  Widget build(context) {
    final screenwidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return StreamBuilder<bool>(
        initialData: false,
        stream: isSidebarOpenedStream,
        builder: (context, isSidebaropened) {
          final isSidebarData = isSidebaropened.data ?? false;

          return AnimatedPositioned(
            duration: _animationduration,
            top: 0,
            bottom: 0,
            left: isSidebarData ? 0 : -screenwidth,
            right: isSidebarData ? 0 : screenwidth - 35,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 163, 13, 13),
                    child: Column(children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const ListTile(
                        title: Text("Ralph",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          "oussama",
                          style: TextStyle(
                              color: Color.fromARGB(255, 163, 160, 160),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Color.fromARGB(255, 14, 13, 13),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItems(
                          icon: Icons.explore,
                          title: "Découvrez",
                          onTap: () => onMenuItemTapped("Découvrez")),
                      MenuItems(
                          icon: Icons.plus_one,
                          title: "Déposez annonce",
                          onTap: () => onMenuItemTapped("Déposez")),
                      const Divider(
                        height: 120,
                        thickness: 0.5,
                        color: Color.fromARGB(255, 14, 13, 13),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItems(
                          icon: Icons.logout,
                          title: "Logout",
                          onTap: () => onMenuItemTapped("Découvrez")),
                    ]),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -0.9),
                  child: GestureDetector(
                    onTap: () {
                      oniconpressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                          width: 35,
                          height: 110,
                          color: Color.fromARGB(255, 163, 13, 13),
                          alignment: Alignment.centerLeft,
                          child: AnimatedIcon(
                            progress: _animationcontroller,
                            icon: AnimatedIcons.menu_close,
                            color: Color(0xFF1BB5FD),
                            size: 25,
                          )),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;
    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);

    path.close();

    // TODO: implement getClip
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

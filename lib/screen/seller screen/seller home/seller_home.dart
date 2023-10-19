import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:morrf/screen/seller%20screen/seller%20home/seller_home_screen.dart';
import 'package:morrf/screen/widgets/constant.dart';

import '../orders/seller_orders.dart';
import '../profile/seller_profile.dart';
import '../seller messgae/chat_list.dart';
import '../seller services/create_service.dart';

class SellerHome extends StatefulWidget {
  int? currentPage;
  SellerHome({super.key, this.currentPage});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  int _currentPage = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    SellerHomeScreen(),
    ChatScreen(),
    CreateService(),
    SellerOrderList(),
    SellerProfile(),
  ];

  @override
  void initState() {
    super.initState();

    _currentPage = widget.currentPage != null ? widget.currentPage! : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_currentPage),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        child: BottomNavigationBar(
          elevation: 0.0,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.chat),
              label: "Message",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.paperPlus),
              label: "Service",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.document),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.profile),
              label: "Profile",
            ),
          ],
          onTap: (int index) {
            setState(() => _currentPage = index);
          },
          currentIndex: _currentPage,
        ),
      ),
    );
  }
}

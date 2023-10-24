import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/client%20screen/client%20home/client_home.dart';
import 'package:morrf/screen/seller%20screen/seller%20home/seller_home_screen.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.off(() => ClientHome());
        },
        child: const FaIcon(FontAwesomeIcons.cartShopping),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidMessage),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.fileCirclePlus),
            label: "Service",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidFileLines),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userAstronaut),
            label: "Profile",
          ),
        ],
        onTap: (int index) {
          setState(() => _currentPage = index);
        },
        currentIndex: _currentPage,
      ),
    );
  }
}

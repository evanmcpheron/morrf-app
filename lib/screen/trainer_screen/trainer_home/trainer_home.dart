import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/client_screen/client_home/client_home.dart';
import 'package:morrf/screen/trainer_screen/trainer_home/trainer_home_screen.dart';

import '../orders/trainer_orders.dart';
import '../profile/trainer_profile.dart';
import '../trainer_messages/chat_list.dart';
import '../trainer_services/create_service.dart';

class TrainerHome extends StatefulWidget {
  int? currentPage;
  TrainerHome({super.key, this.currentPage});

  @override
  State<TrainerHome> createState() => _TrainerHomeState();
}

class _TrainerHomeState extends State<TrainerHome> {
  int _currentPage = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    TrainerHomeScreen(),
    ChatScreen(),
    CreateService(),
    TrainerOrderList(),
    TrainerProfile(),
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

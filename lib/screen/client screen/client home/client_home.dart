import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:morrf/screen/widgets/constant.dart';

import '../../seller screen/seller messgae/chat_list.dart';
import '../client job post/client_job_post.dart';
import '../client orders/client_orders.dart';
import '../client profile/client_profile.dart';
import 'client_home_screen.dart';

class ClientHome extends StatefulWidget {
  int? currentPage;
  ClientHome({super.key, this.currentPage});

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  int _currentPage = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ClientHomeScreen(),
    ChatScreen(),
    JobPost(),
    ClientOrderList(),
    ClientProfile(),
  ];

  @override
  void initState() {
    super.initState();

    _currentPage = widget.currentPage ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_currentPage),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
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
              label: "Job Apply",
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

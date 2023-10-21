import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morrf/screen/client%20screen/client_authentication/client_sign_in.dart';
import 'package:morrf/screen/client%20screen/client_authentication/client_sign_up.dart';

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
  bool isSignedIn = FirebaseAuth.instance.currentUser != null;
  int _currentPage = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ClientHomeScreen(),
    ChatScreen(),
    JobPost(),
    ClientOrderList(),
    ClientProfile(),
  ];

  static final List<Widget> _guestWidgetOptions = <Widget>[
    const ClientHomeScreen(),
    ClientSignIn(isHome: true),
    ClientSignUp(isHome: true),
    const ClientProfile(),
  ];

  @override
  void initState() {
    super.initState();

    _currentPage = widget.currentPage ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSignedIn
          ? _widgetOptions.elementAt(_currentPage)
          : _guestWidgetOptions.elementAt(_currentPage),
      bottomNavigationBar: Container(
        child: isSignedIn
            ? BottomNavigationBar(
                showUnselectedLabels: true,
                backgroundColor: Theme.of(context).cardColor,
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
                    label: "Job Apply",
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
                  setState(() => {
                        {_currentPage = index}
                      });
                },
                currentIndex: _currentPage,
              )
            : BottomNavigationBar(
                backgroundColor: Theme.of(context).cardColor,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.house),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.arrowRightToBracket),
                    label: "Sign In",
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.userPlus),
                    label: "Sign Up",
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.gear),
                    label: "Settings",
                  ),
                ],
                onTap: (int index) {
                  print(index);
                  setState(() => {_currentPage = index});
                },
                currentIndex: _currentPage,
              ),
      ),
    );
  }
}

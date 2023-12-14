import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/providers/user_provider.dart';
import 'package:morrf/screen/client_screen/client_notification/client_notification.dart';
import 'package:morrf/screen/client_screen/client_search/client_search.dart';
import 'package:morrf/screen/global_screen/global_authentication/global_sign_up.dart';
import 'package:morrf/screen/global_screen/global_messages/rooms.dart';
import 'package:morrf/screen/trainer_screen/trainer_home/trainer_home.dart';
import 'package:morrf/screen/trainer_screen/trainer_home/trainer_starter_home.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';

import '../client_orders/client_orders.dart';
import '../client_profile/client_profile.dart';
import 'client_home_screen.dart';

class ClientHome extends ConsumerStatefulWidget {
  int? currentPage;
  ClientHome({super.key, this.currentPage});

  @override
  ConsumerState<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends ConsumerState<ClientHome> {
  int _currentPage = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ClientSearchScreen(),
    ClientOrderList(),
    ClientProfile(),
  ];

  static final List<Widget> _guestWidgetOptions = <Widget>[
    const ClientSearchScreen(),
    ClientSignUp(isHome: true),
    const ClientProfile(),
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentPage ?? 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSignedIn = FirebaseAuth.instance.currentUser != null;
    var morrfUser = ref.watch(morrfUserProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: ListTile(
          contentPadding: const EdgeInsets.only(bottom: 10),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GestureDetector(
              child: Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: isSignedIn
                          ? NetworkImage(morrfUser.photoURL)
                          : const AssetImage('images/user_profile.jpg')
                              as ImageProvider,
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          title: isSignedIn
              ? MorrfText(text: morrfUser.fullName, size: FontSize.h5)
              : const MorrfText(text: "Guest", size: FontSize.h5),
        ),
      ),
      body:
          isSignedIn ? _widgetOptions.elementAt(_currentPage) : getGuestLinks(),
      floatingActionButton: isSignedIn
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primaryColor,
              onPressed: () {
                FirebaseAuth.instance.currentUser!.reload();
                if (morrfUser.morrfTrainer != null) {
                  Get.offAll(() => TrainerHome());
                } else {
                  Get.offAll(() => const TrainerStarterHome());
                }
              },
              child: const FaIcon(FontAwesomeIcons.moneyBill1Wave),
            )
          : null,
      bottomNavigationBar: Container(
        child: isSignedIn
            ? BottomNavigationBar(
                showUnselectedLabels: true,
                backgroundColor: Theme.of(context).cardColor,
                selectedItemColor: Theme.of(context).colorScheme.primaryColor,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                    label: "Search",
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
              )
            : BottomNavigationBar(
                backgroundColor: Theme.of(context).cardColor,
                selectedItemColor: Theme.of(context).colorScheme.primaryColor,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                    label: "Search",
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
                  setState(() => _currentPage = index);
                },
                currentIndex: _currentPage,
              ),
      ),
    );
  }

  Widget getGuestLinks() {
    if (_currentPage == 4) {
      setState(() {
        _currentPage = 0;
      });
    }
    return _guestWidgetOptions.elementAt(_currentPage);
  }
}

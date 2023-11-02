import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/providers/user_provider.dart';
import 'package:morrf/screen/client_screen/client_notification/client_notification.dart';
import 'package:morrf/screen/client_screen/client_search/client_search.dart';
import 'package:morrf/screen/global_screen/global_authentication/global_sign_up.dart';
import 'package:morrf/screen/trainer_screen/trainer_home/trainer_home.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';

import '../../trainer_screen/trainer_messages/chat_list.dart';
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
  bool isSignedIn = FirebaseAuth.instance.currentUser != null;
  int _currentPage = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ClientHomeScreen(),
    ClientSearchScreen(),
    ChatScreen(),
    ClientOrderList(),
    ClientProfile(),
  ];

  static final List<Widget> _guestWidgetOptions = <Widget>[
    const ClientHomeScreen(),
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
              // onTap: ()=>const TrainerProfile().launch(context),
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
          trailing: isSignedIn
              ? GestureDetector(
                  onTap: () => Get.to(() => const ClientNotification()),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(),
                    ),
                    child: const FaIcon(FontAwesomeIcons.solidBell),
                  ),
                )
              : const SizedBox(),
        ),
      ),
      body: isSignedIn
          ? _widgetOptions.elementAt(_currentPage)
          : _guestWidgetOptions.elementAt(_currentPage),
      floatingActionButton: isSignedIn
          ? FloatingActionButton(
              onPressed: () {
                Get.offAll(() => TrainerHome());
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
                    icon: FaIcon(FontAwesomeIcons.house),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.solidMessage),
                    label: "Message",
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
                selectedItemColor: Theme.of(context).colorScheme.primaryColor,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.house),
                    label: "Home",
                  ),
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
                  setState(() => {_currentPage = index});
                },
                currentIndex: _currentPage,
              ),
      ),
    );
  }
}

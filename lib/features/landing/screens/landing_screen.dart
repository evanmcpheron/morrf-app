import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morrf/features/auth/controller/auth_controller.dart';
import 'package:morrf/features/auth/screens/menu_screen.dart';
import 'package:morrf/models/user/morrf_user.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  int _currentPage = 0;
  late MorrfUser? morrfUser = ref.watch(userDataAuthProvider).value;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Text("Auth 1"),
    Text("Auth 2"),
    MenuScreen(),
  ];

  String welcomeHeader() {
    if (user != null && morrfUser!.firstName != "") {
      return "Welcome ${morrfUser!.firstName}";
    } else if (user != null) {
      return "Welcome back";
    } else {
      return "Guest";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          welcomeHeader(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_currentPage),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (tabBarController.index == 0) {
            print("tab bar controller == 0");
          } else {
            print(" else");
          }
        },
        child: const Icon(
          Icons.comment,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: Container(
        child: morrfUser != null
            ? BottomNavigationBar(
                showUnselectedLabels: true,
                selectedItemColor: Theme.of(context).colorScheme.primary,
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
                showUnselectedLabels: true,
                selectedItemColor: Theme.of(context).colorScheme.primary,
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
}

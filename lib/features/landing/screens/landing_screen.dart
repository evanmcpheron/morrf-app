import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/widgets/error.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/features/auth/controller/auth_controller.dart';
import 'package:morrf/features/auth/screens/menu_screen.dart';
import 'package:morrf/features/services/all_services/screens/all_services_screen.dart';
import 'package:morrf/features/splash_screen/screens/splash_screen.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  int _currentPage = 0;
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
        ref.read(authControllerProvider.notifier).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        ref.read(authControllerProvider.notifier).setUserState(false);
        break;
    }
  }

  static const List<Widget> _widgetOptions = <Widget>[
    AllServicesScreen(),
    Text("Auth 2"),
    MenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    late bool isSignedIn = user != null;

    return ref.watch(getUserDataProvider(user!.uid)).when(
        data: (morrfUser) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: false,
                title: MorrfText(
                    text: "Morrf",
                    size: FontSize.h3,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
              ),
              body: _widgetOptions.elementAt(_currentPage),
              bottomNavigationBar: Container(
                child: isSignedIn
                    ? BottomNavigationBar(
                        showUnselectedLabels: true,
                        selectedItemColor:
                            Theme.of(context).colorScheme.primary,
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
                        selectedItemColor:
                            Theme.of(context).colorScheme.primary,
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
            ),
        error: (Object error, StackTrace stackTrace) => ErrorScreen(
              error: error.toString(),
            ),
        loading: () => const SplashScreen());
  }
}

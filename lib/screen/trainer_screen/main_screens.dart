import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/client_screen/client_home/client_home_screen.dart';
import 'package:morrf/screen/client_screen/client_job_post/client_job_post.dart';
import 'package:morrf/screen/client_screen/client_orders/client_orders.dart';
import 'package:morrf/screen/client_screen/client_profile/client_profile.dart';
import 'package:morrf/screen/trainer_screen/orders/trainer_orders.dart';
import 'package:morrf/screen/trainer_screen/profile/trainer_profile.dart';
import 'package:morrf/screen/trainer_screen/trainer_home/trainer_home_screen.dart';
import 'package:morrf/screen/global_screen/global_messages/chat_list_depr.dart';
import 'package:morrf/screen/trainer_screen/trainer_services/create_service.dart';

class MainScreen extends StatefulWidget {
  bool isTrainer;
  MainScreen({super.key, this.isTrainer = false});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isSignedIn = FirebaseAuth.instance.currentUser != null;

  int _currentPage = 0;
  double height = 80;

  final PageController _pageController = PageController(initialPage: 0);

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.house), label: "Home"),
    BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.magnifyingGlass), label: "Search"),
    BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.heart), label: "WishList"),
    BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.message), label: "Chat"),
    BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.user), label: "Profile"),
  ];

  late final List<Widget> availableClientScreens = const <Widget>[
    ClientHomeScreen(),
    ChatScreen(),
    JobPost(),
    ClientOrderList(),
    ClientProfile(),
  ];

  late final List<Widget> availableTrainerScreens = const <Widget>[
    TrainerHomeScreen(),
    ChatScreen(),
    CreateService(),
    TrainerOrderList(),
    TrainerProfile(),
  ];

  FloatingActionButtonLocation? fabLocation;
  final NotchedShape? shape = const CircularNotchedRectangle();

  Widget get getAvatar {
    if (isSignedIn && FirebaseAuth.instance.currentUser!.photoURL != null) {
      return CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(
            FirebaseAuth.instance.currentUser!.photoURL!,
            scale: 30),
        backgroundColor: Colors.transparent,
      );
    }
    return const FaIcon(FontAwesomeIcons.user);
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != _currentPage && mounted) {
          changePage(value);
        }
      },
    );
  }

  void changePage(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.notifications_outlined),
              )
            ],
            leading: GestureDetector(
                onTap: () => Get.toNamed('/settings'),
                child: const Icon(Icons.settings_outlined)),
          ),
        ),
        body: PageView(
            onPageChanged: (newIndex) {
              setState(() {
                if (!isSignedIn && (newIndex == 2 || newIndex == 3)) {
                  _currentPage = 0;
                } else {
                  _currentPage = newIndex;
                }
              });
            },
            controller: _pageController,
            children: widget.isTrainer
                ? availableTrainerScreens
                : availableClientScreens),
        bottomNavigationBar: SizedBox(
          height: height + MediaQuery.of(context).padding.bottom,
          child: BottomNavigationBar(
            currentIndex: _currentPage,
            items: _bottomNavigationBarItems,
            backgroundColor: Theme.of(context).colorScheme.surface,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            onTap: (index) {
              setState(() {
                if (!isSignedIn && (index == 2 || index == 3)) {
                  _currentPage = 0;
                  _pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.ease);
                  Get.toNamed('/sign-in');
                } else {
                  _pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.ease);
                }
              });
            },
            type: BottomNavigationBarType.fixed,
          ),
        ));
  }
}

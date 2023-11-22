import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:morrf/providers/user_provider.dart';
import 'package:morrf/screen/client_screen/client_home/client_home.dart';
import 'package:morrf/screen/client_screen/client_notification/client_notification.dart';
import 'package:morrf/screen/global_screen/global_messages/chat_list_depr.dart';
import 'package:morrf/screen/trainer_screen/trainer_home/trainer_home_screen.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';

import '../orders/trainer_orders.dart';
import '../profile/trainer_profile.dart';
import '../trainer_services/create_service.dart';

class TrainerHome extends ConsumerStatefulWidget {
  int? currentPage;
  TrainerHome({super.key, this.currentPage});

  @override
  ConsumerState<TrainerHome> createState() => _TrainerHomeState();
}

class _TrainerHomeState extends ConsumerState<TrainerHome> {
  int _currentPage = 0;
  User user = FirebaseAuth.instance.currentUser!;

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
    MorrfUser morrfUser = ref.watch(morrfUserProvider);
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
                      image: NetworkImage(morrfUser.photoURL),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          title: MorrfText(text: morrfUser.fullName, size: FontSize.h5),
          trailing: GestureDetector(
            onTap: () => Get.to(() => const ClientNotification()),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryColor
                        .withOpacity(.5)),
              ),
              child: const FaIcon(FontAwesomeIcons.solidBell),
            ),
          ),
        ),
      ),
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

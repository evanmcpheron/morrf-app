import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/theme_switcher.dart';
import 'package:morrf/menu_router.dart';
import 'package:morrf/models/general/menu_item.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    bool isSignedIn = user != null;

    final List<MenuItem> menuItems =
        isSignedIn ? mainSignedinProfileMenu : mainGuestProfileMenu;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                MenuItem currentMenuItem = menuItems[index];
                Color currentColor = menuColors[index % menuColors.length];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20.0),
                    ListTile(
                      onTap: () => Get.to(() => currentMenuItem.destination),
                      visualDensity: const VisualDensity(vertical: -3),
                      horizontalTitleGap: 10,
                      contentPadding: const EdgeInsets.only(bottom: 20),
                      leading: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentColor,
                          ),
                          child: FaIcon(
                            currentMenuItem.icon,
                          )),
                      title: MorrfText(
                          text: currentMenuItem.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          size: FontSize.lp),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
            const Divider(),
            const ThemeSwitcher()
          ],
        ),
      ),
    );
  }
}

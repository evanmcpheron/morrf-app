import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_scaffold.dart';
import 'package:morrf/features/settings/screens/about_screen.dart';
import 'package:morrf/features/settings/screens/policy_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return MorrfScaffold(
      title: "Settings",
      body: Column(
        children: [
          const SizedBox(height: 30.0),
          ListTile(
            visualDensity: const VisualDensity(vertical: -3),
            horizontalTitleGap: 10,
            contentPadding: const EdgeInsets.only(bottom: 15),
            leading: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE7FFED),
              ),
              child: const Icon(
                IconlyBold.notification,
              ),
            ),
            title: const MorrfText(
                text: 'Push Notifications',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                size: FontSize.p),
            trailing: CupertinoSwitch(
              value: isOn,
              onChanged: (value) {
                setState(() {
                  isOn = value;
                });
              },
            ),
          ),
          ListTile(
            onTap: () => const PolicyScreen()
                .launch(context), // TODO: write privacy policy
            visualDensity: const VisualDensity(vertical: -3),
            horizontalTitleGap: 10,
            contentPadding: const EdgeInsets.only(bottom: 15),
            leading: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFEFE0),
              ),
              child: const Icon(
                IconlyBold.danger,
                color: Color(0xFFFF7A00),
              ),
            ),
            title: const MorrfText(
                text: 'Privacy Policy',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                size: FontSize.p),
          ),
          ListTile(
            onTap: () => const AboutScreen()
                .launch(context), // TODO: write terms of service
            visualDensity: const VisualDensity(vertical: -3),
            horizontalTitleGap: 10,
            contentPadding: const EdgeInsets.only(bottom: 15),
            leading: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE8E1FF),
              ),
              child: const Icon(
                IconlyBold.shieldDone,
                color: Color(0xFF7E5BFF),
              ),
            ),
            title: const MorrfText(
                text: 'Terms of Service',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                size: FontSize.p),
          ),
        ],
      ),
    );
  }
}

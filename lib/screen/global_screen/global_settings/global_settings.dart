import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:morrf/screen/global_screen/global_settings/global_about.dart';
import 'package:morrf/screen/global_screen/global_settings/global_policy.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';

class GlobalSettings extends StatefulWidget {
  const GlobalSettings({super.key});

  @override
  State<GlobalSettings> createState() => _GlobalSettingsState();
}

class _GlobalSettingsState extends State<GlobalSettings> {
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
                color: kPrimaryColor,
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
            onTap: () => const ClientPolicy()
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
            onTap: () => const ClientAbout()
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

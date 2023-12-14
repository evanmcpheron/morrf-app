import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/client_screen/client_home/client_home.dart';
import 'package:morrf/screen/global_screen/global_add_payment_method/global_add_payment_method.dart';
import 'package:morrf/screen/global_screen/global_settings/global_settings.dart';
import 'package:morrf/screen/trainer_screen/profile/trainer_profile_details.dart';
import 'package:morrf/screen/trainer_screen/withdraw_money/trainer_withdraw_history.dart';
import 'package:morrf/screen/trainer_screen/withdraw_money/trainer_withdraw_money.dart';
import 'package:morrf/services/auth_service.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/theme_switcher.dart';
import 'package:nb_utils/nb_utils.dart';

class TrainerProfile extends StatefulWidget {
  const TrainerProfile({super.key});

  @override
  State<TrainerProfile> createState() => _TrainerProfileState();
}

class _TrainerProfileState extends State<TrainerProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              ListTile(
                onTap: () => const TrainerProfileDetails().launch(context),
                visualDensity: const VisualDensity(vertical: -3),
                horizontalTitleGap: 10,
                contentPadding: const EdgeInsets.only(bottom: 20),
                leading: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE2EED8),
                  ),
                  child: const Icon(
                    IconlyBold.profile,
                    color: kPrimaryColor,
                  ),
                ),
                title: const Text(
                  'My Profile',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
                  color: kLightNeutralColor,
                ),
              ),
              ListTile(
                onTap: () => const GlobalAddPaymentMethod().launch(context),
                visualDensity: const VisualDensity(vertical: -3),
                horizontalTitleGap: 10,
                contentPadding: const EdgeInsets.only(bottom: 12),
                leading: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFE5E3),
                  ),
                  child: const Icon(
                    IconlyBold.ticketStar,
                    color: Color(0xFFFF3B30),
                  ),
                ),
                title: const Text(
                  'Add Payment method',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
                  color: kLightNeutralColor,
                ),
              ),
              ExpansionTile(
                childrenPadding: EdgeInsets.zero,
                tilePadding: const EdgeInsets.only(bottom: 10),
                collapsedIconColor: kLightNeutralColor,
                iconColor: kLightNeutralColor,
                title: const Text(
                  'Withdraw',
                ),
                leading: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFEFE0),
                  ),
                  child: const Icon(
                    IconlyBold.wallet,
                    color: Color(0xFFFF7A00),
                  ),
                ),
                trailing: const Icon(
                  FeatherIcons.chevronDown,
                  color: kLightNeutralColor,
                ),
                children: [
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    horizontalTitleGap: 10,
                    contentPadding: const EdgeInsets.only(left: 60),
                    title: const Text(
                      'Withdraw Amount',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    trailing: const Icon(
                      FeatherIcons.chevronRight,
                      color: kLightNeutralColor,
                    ),
                    onTap: () => const TrainerWithdrawMoney().launch(context),
                  ),
                  ListTile(
                    onTap: () => const TrainerWithDrawHistory().launch(context),
                    visualDensity: const VisualDensity(vertical: -3),
                    horizontalTitleGap: 10,
                    contentPadding: const EdgeInsets.only(left: 60),
                    title: const Text(
                      'Withdrawal History',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    trailing: const Icon(
                      FeatherIcons.chevronRight,
                      color: kLightNeutralColor,
                    ),
                  ),
                ],
              ),
              ListTile(
                onTap: () => const GlobalSettings().launch(context),
                visualDensity: const VisualDensity(vertical: -3),
                horizontalTitleGap: 10,
                contentPadding: const EdgeInsets.only(bottom: 15),
                leading: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFDDED),
                  ),
                  child: const Icon(
                    IconlyBold.setting,
                    color: Color(0xFFFF298C),
                  ),
                ),
                title: const Text(
                  'Settings',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
                  color: kLightNeutralColor,
                ),
              ),
              ListTile(
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
                    IconlyBold.logout,
                    color: Color(0xFFFF7A00),
                  ),
                ),
                onTap: () =>
                    {AuthService().signout(), Get.off(() => ClientHome())},
                title: const Text(
                  'Log Out',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
                  color: kLightNeutralColor,
                ),
              ),
              const ThemeSwitcher()
            ],
          ),
        ),
      ),
    );
  }
}

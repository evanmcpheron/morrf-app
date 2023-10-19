import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/seller%20screen/seller%20home/seller_home.dart';
import 'package:morrf/screen/widgets/theme_switcher.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/constant.dart';
import '../client dashboard/client_dashboard.dart';
import '../client favourite/client_favourite_list.dart';
import '../client invite/client_invite.dart';
import '../client report/client_report.dart';
import '../client_setting/client_setting.dart';
import '../deposit/add_deposit.dart';
import '../deposit/deposit_history.dart';
import '../transaction/transaction.dart';
import 'client_profile_details.dart';

class ClientProfile extends StatefulWidget {
  const ClientProfile({Key? key}) : super(key: key);

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: kNeutralColor),
        titleSpacing: 0,
        title: ListTile(
          visualDensity: const VisualDensity(vertical: -4),
          contentPadding: EdgeInsets.zero,
          leading: Container(
            height: 45,
            width: 45,
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('images/profile1.png'), fit: BoxFit.cover),
            ),
          ),
          title: const Text(
            'Evan McPheron',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: RichText(
            text: const TextSpan(
              text: 'Deposit Balance: ',
              children: [
                TextSpan(
                  text: '$currencySign 500.00',
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
      ),
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
                onTap: () => const ClientProfileDetails().launch(context),
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
                ),
              ),
              ListTile(
                onTap: () => const ClientDashBoard().launch(context),
                visualDensity: const VisualDensity(vertical: -3),
                horizontalTitleGap: 10,
                contentPadding: const EdgeInsets.only(bottom: 20),
                leading: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE3EDFF),
                  ),
                  child: const Icon(
                    IconlyBold.chart,
                    color: Color(0xFF144BD6),
                  ),
                ),
                title: const Text(
                  'Dashboard',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
                ),
              ),
              ExpansionTile(
                childrenPadding: EdgeInsets.zero,
                tilePadding: const EdgeInsets.only(bottom: 10),
                collapsedIconColor: kLightNeutralColor,
                iconColor: kLightNeutralColor,
                title: const Text(
                  'Deposit',
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
                ),
                children: [
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    horizontalTitleGap: 10,
                    contentPadding: const EdgeInsets.only(left: 60),
                    title: const Text(
                      'Add Deposit',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    trailing: const Icon(
                      FeatherIcons.chevronRight,
                    ),
                    onTap: () => const AddDeposit().launch(context),
                  ),
                  ListTile(
                    onTap: () => const DepositHistory().launch(context),
                    visualDensity: const VisualDensity(vertical: -3),
                    horizontalTitleGap: 10,
                    contentPadding: const EdgeInsets.only(left: 60),
                    title: const Text(
                      'Deposit History',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    trailing: const Icon(
                      FeatherIcons.chevronRight,
                    ),
                  ),
                ],
              ),
              ListTile(
                onTap: () => const ClientTransaction().launch(context),
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
                  'Transaction',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
                ),
              ),
              ListTile(
                onTap: () => const ClientFavList().launch(context),
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
                    IconlyBold.heart,
                    color: Color(0xFF7E5BFF),
                  ),
                ),
                title: const Text(
                  'Favorite',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
                ),
              ),
              ListTile(
                onTap: () => const ClientReport().launch(context),
                visualDensity: const VisualDensity(vertical: -3),
                horizontalTitleGap: 10,
                contentPadding: const EdgeInsets.only(bottom: 15),
                leading: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD0F1FF),
                  ),
                  child: const Icon(
                    IconlyBold.document,
                    color: Color(0xFF06AEF3),
                  ),
                ),
                title: const Text(
                  'Seller Report',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
                ),
              ),
              ListTile(
                onTap: () => const ClientSetting().launch(context),
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
                  'Setting',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
                ),
              ),
              ListTile(
                onTap: () => const ClientInvite().launch(context),
                visualDensity: const VisualDensity(vertical: -3),
                horizontalTitleGap: 10,
                contentPadding: const EdgeInsets.only(bottom: 15),
                leading: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE2EED8),
                  ),
                  child: const Icon(
                    IconlyBold.addUser,
                    color: kPrimaryColor,
                  ),
                ),
                title: const Text(
                  'Invite Friends',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
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
                    color: Color(0xFFE3EDFF),
                  ),
                  child: const Icon(
                    IconlyBold.danger,
                    color: Color(0xFF144BD6),
                  ),
                ),
                title: const Text(
                  'Help & Support',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
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
                onTap: () => Get.off(() => SellerHome()),
                title: const Text(
                  'Log Out',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
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

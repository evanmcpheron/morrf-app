import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/client%20screen/client%20home/client_home.dart';
import 'package:morrf/screen/client%20screen/client_authentication/client_sign_in.dart';
import 'package:morrf/screen/client%20screen/client_authentication/client_sign_up.dart';
import 'package:morrf/screen/seller%20screen/add%20payment%20method/seller_add_payment_method.dart';
import 'package:morrf/utils/auth_service.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/theme_switcher.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../widgets/constant.dart';
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
  User? user;
  bool isExpandedPayment = false;
  bool isExpandedDeposit = false;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSignedIn = FirebaseAuth.instance.currentUser != null;
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        titleSpacing: 24,
        title: ListTile(
          visualDensity: const VisualDensity(vertical: -4),
          contentPadding: EdgeInsets.zero,
          leading: Container(
            height: 45,
            width: 45,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: isSignedIn
                      ? NetworkImage(user!.photoURL!)
                      : const AssetImage('assets/images/user_profile.jpg')
                          as ImageProvider,
                  fit: BoxFit.cover),
            ),
          ),
          title: isSignedIn
              ? MorrfText(
                  text: user!.displayName!,
                  size: FontSize.h6,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              : const MorrfText(text: "Guest", size: FontSize.h6),
          subtitle: isSignedIn
              ? Row(
                  children: const [
                    MorrfText(text: "Deposit Balance", size: FontSize.lp),
                    MorrfText(
                      text: "\$545.12",
                      size: FontSize.h6,
                    )
                  ],
                )
              : null,
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
              isSignedIn
                  ? ListTile(
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
                          child: const FaIcon(FontAwesomeIcons.userAstronaut,
                              color: kPrimaryColor)),
                      title: const MorrfText(
                          text: 'My Profile',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          size: FontSize.lp),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    )
                  : const SizedBox(),
              isSignedIn
                  ? ExpansionTile(
                      childrenPadding: EdgeInsets.zero,
                      tilePadding: const EdgeInsets.only(bottom: 10),
                      collapsedIconColor: kLightNeutralColor,
                      iconColor: kLightNeutralColor,
                      onExpansionChanged: (bool expanded) {
                        setState(() => isExpandedPayment = expanded);
                      },
                      title: const MorrfText(
                          text: 'Payment Method', size: FontSize.lp),
                      leading: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFFE5E3),
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.creditCard,
                          color: Color(0xFFFF3B30),
                        ),
                      ),
                      trailing: isExpandedPayment
                          ? const FaIcon(
                              FontAwesomeIcons.chevronDown,
                            )
                          : const FaIcon(
                              FontAwesomeIcons.chevronRight,
                            ),
                      children: [
                        ListTile(
                          visualDensity: const VisualDensity(vertical: -3),
                          horizontalTitleGap: 10,
                          contentPadding: const EdgeInsets.only(left: 60),
                          title: const MorrfText(
                              text: 'Add Card',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              size: FontSize.lp),
                          trailing: const FaIcon(
                            FontAwesomeIcons.chevronRight,
                          ),
                          onTap: () =>
                              Get.to(() => const SellerAddPaymentMethod()),
                        ),
                        ListTile(
                          onTap: () => const SellerAddPaymentMethod(),
                          visualDensity: const VisualDensity(vertical: -3),
                          horizontalTitleGap: 10,
                          contentPadding: const EdgeInsets.only(left: 60),
                          title: const MorrfText(
                              text: 'Billing Address',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              size: FontSize.lp),
                          trailing: const FaIcon(
                            FontAwesomeIcons.chevronRight,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              isSignedIn
                  ? ListTile(
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
                        child: const FaIcon(
                          FontAwesomeIcons.chartLine,
                          color: Color(0xFF144BD6),
                        ),
                      ),
                      title: const MorrfText(
                          text: 'Dashboard',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          size: FontSize.lp),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    )
                  : const SizedBox(),
              isSignedIn
                  ? ExpansionTile(
                      childrenPadding: EdgeInsets.zero,
                      tilePadding: const EdgeInsets.only(bottom: 10),
                      collapsedIconColor: kLightNeutralColor,
                      iconColor: kLightNeutralColor,
                      title:
                          const MorrfText(text: 'Deposit', size: FontSize.lp),
                      leading: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFFEFE0),
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.wallet,
                          color: Color(0xFFFF7A00),
                        ),
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isExpandedDeposit = expanded);
                      },
                      trailing: isExpandedDeposit
                          ? const FaIcon(
                              FontAwesomeIcons.chevronDown,
                            )
                          : const FaIcon(
                              FontAwesomeIcons.chevronRight,
                            ),
                      children: [
                        ListTile(
                          visualDensity: const VisualDensity(vertical: -3),
                          horizontalTitleGap: 10,
                          contentPadding: const EdgeInsets.only(left: 60),
                          title: const MorrfText(
                              text: 'Add Deposit',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              size: FontSize.lp),
                          trailing: const FaIcon(
                            FontAwesomeIcons.chevronRight,
                          ),
                          onTap: () => const AddDeposit().launch(context),
                        ),
                        ListTile(
                          onTap: () => const DepositHistory().launch(context),
                          visualDensity: const VisualDensity(vertical: -3),
                          horizontalTitleGap: 10,
                          contentPadding: const EdgeInsets.only(left: 60),
                          title: const MorrfText(
                              text: 'Deposit History',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              size: FontSize.lp),
                          trailing: const FaIcon(
                            FontAwesomeIcons.chevronRight,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              isSignedIn
                  ? ListTile(
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
                        child: const FaIcon(
                          FontAwesomeIcons.fileInvoice,
                          color: Color(0xFFFF3B30),
                        ),
                      ),
                      title: const MorrfText(
                          text: 'Transaction History',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          size: FontSize.lp),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    )
                  : const SizedBox(),
              isSignedIn
                  ? ListTile(
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
                        child: const FaIcon(
                          FontAwesomeIcons.solidHeart,
                          color: Color(0xFF7E5BFF),
                        ),
                      ),
                      title: const MorrfText(
                          text: 'Favorites',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          size: FontSize.lp),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    )
                  : const SizedBox(),
              isSignedIn
                  ? ListTile(
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
                        child: const FaIcon(
                          FontAwesomeIcons.solidFile,
                          color: Color(0xFF06AEF3),
                        ),
                      ),
                      title: const MorrfText(
                          text: 'Report Seller',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          size: FontSize.lp),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    )
                  : const SizedBox(),
              ListTile(
                onTap: () => Get.to(() => const ClientSetting()),
                visualDensity: const VisualDensity(vertical: -3),
                horizontalTitleGap: 10,
                contentPadding: const EdgeInsets.only(bottom: 15),
                leading: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFDDED),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.gear,
                      color: Color(0xFFFF298C),
                    )),
                title: const MorrfText(
                    text: 'Settings',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    size: FontSize.lp),
                trailing: const FaIcon(FontAwesomeIcons.chevronRight),
              ),
              isSignedIn
                  ? ListTile(
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
                          FontAwesomeIcons.userPlus,
                          color: kPrimaryColor,
                        ),
                      ),
                      title: const MorrfText(
                          text: 'Invite Friends',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          size: FontSize.lp),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    )
                  : const SizedBox(),
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
                  child: const FaIcon(FontAwesomeIcons.triangleExclamation,
                      color: Color(0xFF144BD6)),
                ),
                title: const MorrfText(
                    text: 'Help & Support',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    size: FontSize.lp),
                trailing: const FaIcon(FontAwesomeIcons.chevronRight),
              ),
              isSignedIn
                  ? ListTile(
                      visualDensity: const VisualDensity(vertical: -3),
                      horizontalTitleGap: 10,
                      contentPadding: const EdgeInsets.only(bottom: 15),
                      leading: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFFEFE0),
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.rightFromBracket,
                          color: Color(0xFFFF7A00),
                        ),
                      ),
                      onTap: () => {
                        AuthService().signout(),
                        Get.off(() => ClientHome())
                      },
                      title: const MorrfText(
                          text: 'Log Out',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          size: FontSize.lp),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    )
                  : ListTile(
                      visualDensity: const VisualDensity(vertical: -3),
                      horizontalTitleGap: 10,
                      contentPadding: const EdgeInsets.only(bottom: 15),
                      leading: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFFEFE0),
                          ),
                          child: const FaIcon(
                              FontAwesomeIcons.arrowRightToBracket,
                              color: Color(0xFFFF7A00))),
                      onTap: () => Get.to(() => ClientSignIn()),
                      title: const MorrfText(
                          text: 'Sign In',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          size: FontSize.lp),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    ),
              isSignedIn
                  ? const SizedBox()
                  : ListTile(
                      visualDensity: const VisualDensity(vertical: -3),
                      horizontalTitleGap: 10,
                      contentPadding: const EdgeInsets.only(bottom: 15),
                      leading: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFFE5E3),
                          ),
                          child: const FaIcon(FontAwesomeIcons.userPlus,
                              color: Color(0xFFFF3B30))),
                      onTap: () => Get.to(() => ClientSignUp()),
                      title: const MorrfText(
                          text: 'Sign Up',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          size: FontSize.lp),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    ),
              const ThemeSwitcher()
            ],
          ),
        ),
      ),
    );
  }
}

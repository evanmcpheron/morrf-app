import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:morrf/providers/user_provider.dart';
import 'package:morrf/screen/client_screen/client_home/client_home.dart';
import 'package:morrf/screen/global_screen/global_authentication/global_sign_in.dart';
import 'package:morrf/screen/global_screen/global_authentication/global_sign_up.dart';
import 'package:morrf/screen/global_screen/global_add_payment_method/global_add_payment_method.dart';
import 'package:morrf/screen/global_screen/global_help/global_help.dart';
import 'package:morrf/services/auth_service.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/theme_switcher.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../widgets/constant.dart';
import '../client_dashboard/client_dashboard.dart';
import '../client_report/client_report.dart';
import '../../global_screen/global_settings/global_settings.dart';
import 'client_profile_details.dart';

class ClientProfile extends ConsumerStatefulWidget {
  const ClientProfile({super.key});

  @override
  ConsumerState<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends ConsumerState<ClientProfile> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    bool isSignedIn = user != null;

    MorrfUser morrfUser = ref.read(morrfUserProvider);
    return Scaffold(
      key: UniqueKey(),
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
              // PRE-MVP version of item below. Delete this when we implement billing addresses.
              isSignedIn
                  ? ListTile(
                      onTap: () => Get.to(() => const GlobalAddPaymentMethod()),
                      visualDensity: const VisualDensity(vertical: -3),
                      horizontalTitleGap: 10,
                      iconColor: kLightNeutralColor,
                      contentPadding: const EdgeInsets.only(bottom: 20),
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
                      title: const MorrfText(
                          text: 'Add Payment Method',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          size: FontSize.lp),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    )
                  : const SizedBox(),
              // MVP
              // isSignedIn
              //     ? ExpansionTile(
              //         childrenPadding: EdgeInsets.zero,
              //         tilePadding: const EdgeInsets.only(bottom: 10),
              //         collapsedIconColor: kLightNeutralColor,
              //         iconColor: kLightNeutralColor,
              //         title: const MorrfText(
              //             text: 'Payment Method', size: FontSize.lp),
              //         leading: Container(
              //           padding: const EdgeInsets.all(10.0),
              //           decoration: const BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Color(0xFFFFE5E3),
              //           ),
              //           child: const FaIcon(
              //             FontAwesomeIcons.creditCard,
              //             color: Color(0xFFFF3B30),
              //           ),
              //         ),
              //         trailing: const FaIcon(
              //           FontAwesomeIcons.chevronRight,
              //         ),
              //         children: [
              //           ListTile(
              //             visualDensity: const VisualDensity(vertical: -3),
              //             horizontalTitleGap: 10,
              //             contentPadding: const EdgeInsets.only(left: 60),
              //             title: const MorrfText(
              //                 text: 'Add Card',
              //                 overflow: TextOverflow.ellipsis,
              //                 maxLines: 1,
              //                 size: FontSize.lp),
              //             trailing: const FaIcon(
              //               FontAwesomeIcons.chevronRight,
              //             ),
              //             onTap: () =>
              //                 Get.to(() => const GlobalAddPaymentMethod()),
              //           ),
              //           ListTile(
              //             onTap: () => const GlobalAddPaymentMethod(),
              //             visualDensity: const VisualDensity(vertical: -3),
              //             horizontalTitleGap: 10,
              //             contentPadding: const EdgeInsets.only(left: 60),
              //             title: const MorrfText(
              //                 text: 'Billing Address',
              //                 overflow: TextOverflow.ellipsis,
              //                 maxLines: 1,
              //                 size: FontSize.lp),
              //             trailing: const FaIcon(
              //               FontAwesomeIcons.chevronRight,
              //             ),
              //           ),
              //         ],
              //       )
              //     : const SizedBox(),
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
              // MVP
              // isSignedIn
              //     ? ExpansionTile(
              //         childrenPadding: EdgeInsets.zero,
              //         tilePadding: const EdgeInsets.only(bottom: 10),
              //         collapsedIconColor: kLightNeutralColor,
              //         iconColor: kLightNeutralColor,
              //         title:
              //             const MorrfText(text: 'Deposit', size: FontSize.lp),
              //         leading: Container(
              //           padding: const EdgeInsets.all(10.0),
              //           decoration: const BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Color(0xFFFFEFE0),
              //           ),
              //           child: const FaIcon(
              //             FontAwesomeIcons.wallet,
              //             color: Color(0xFFFF7A00),
              //           ),
              //         ),
              //         trailing: const FaIcon(
              //           FontAwesomeIcons.chevronRight,
              //         ),
              //         children: [
              //           ListTile(
              //             visualDensity: const VisualDensity(vertical: -3),
              //             horizontalTitleGap: 10,
              //             contentPadding: const EdgeInsets.only(left: 60),
              //             title: const MorrfText(
              //                 text: 'Add Deposit',
              //                 overflow: TextOverflow.ellipsis,
              //                 maxLines: 1,
              //                 size: FontSize.lp),
              //             trailing: const FaIcon(
              //               FontAwesomeIcons.chevronRight,
              //             ),
              //             onTap: () => const AddDeposit().launch(context),
              //           ),
              //           ListTile(
              //             onTap: () => const DepositHistory().launch(context),
              //             visualDensity: const VisualDensity(vertical: -3),
              //             horizontalTitleGap: 10,
              //             contentPadding: const EdgeInsets.only(left: 60),
              //             title: const MorrfText(
              //                 text: 'Deposit History',
              //                 overflow: TextOverflow.ellipsis,
              //                 maxLines: 1,
              //                 size: FontSize.lp),
              //             trailing: const FaIcon(
              //               FontAwesomeIcons.chevronRight,
              //             ),
              //           ),
              //         ],
              //       )
              //     : const SizedBox(),
              // MVP
              // isSignedIn
              //     ? ListTile(
              //         onTap: () => const ClientTransaction().launch(context),
              //         visualDensity: const VisualDensity(vertical: -3),
              //         horizontalTitleGap: 10,
              //         contentPadding: const EdgeInsets.only(bottom: 12),
              //         leading: Container(
              //           padding: const EdgeInsets.all(10.0),
              //           decoration: const BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Color(0xFFFFE5E3),
              //           ),
              //           child: const FaIcon(
              //             FontAwesomeIcons.fileInvoice,
              //             color: Color(0xFFFF3B30),
              //           ),
              //         ),
              //         title: const MorrfText(
              //             text: 'Transaction History',
              //             overflow: TextOverflow.ellipsis,
              //             maxLines: 1,
              //             size: FontSize.lp),
              //         trailing: const FaIcon(FontAwesomeIcons.chevronRight),
              //       )
              //     : const SizedBox(),
              // MVP
              // isSignedIn
              //     ? ListTile(
              //         onTap: () => const ClientFavList().launch(context),
              //         visualDensity: const VisualDensity(vertical: -3),
              //         horizontalTitleGap: 10,
              //         contentPadding: const EdgeInsets.only(bottom: 15),
              //         leading: Container(
              //           padding: const EdgeInsets.all(10.0),
              //           decoration: const BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Color(0xFFE8E1FF),
              //           ),
              //           child: const FaIcon(
              //             FontAwesomeIcons.solidHeart,
              //             color: Color(0xFF7E5BFF),
              //           ),
              //         ),
              //         title: const MorrfText(
              //             text: 'Favorites',
              //             overflow: TextOverflow.ellipsis,
              //             maxLines: 1,
              //             size: FontSize.lp),
              //         trailing: const FaIcon(FontAwesomeIcons.chevronRight),
              //       )
              //     : const SizedBox(),
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
                          text: 'Report Trainer',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          size: FontSize.lp),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    )
                  : const SizedBox(),
              ListTile(
                onTap: () => Get.to(() => const GlobalSettings()),
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
              // MVP
              // isSignedIn
              //     ? ListTile(
              //         onTap: () => const ClientInvite().launch(context),
              //         visualDensity: const VisualDensity(vertical: -3),
              //         horizontalTitleGap: 10,
              //         contentPadding: const EdgeInsets.only(bottom: 15),
              //         leading: Container(
              //           padding: const EdgeInsets.all(10.0),
              //           decoration: const BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Color(0xFFE2EED8),
              //           ),
              //           child: const Icon(
              //             FontAwesomeIcons.userPlus,
              //             color: kPrimaryColor,
              //           ),
              //         ),
              //         title: const MorrfText(
              //             text: 'Invite Friends',
              //             overflow: TextOverflow.ellipsis,
              //             maxLines: 1,
              //             size: FontSize.lp),
              //         trailing: const FaIcon(FontAwesomeIcons.chevronRight),
              //       )
              //     : const SizedBox(),
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
                onTap: () => {
                  Get.to(() => const GlobalHelpAndSupportScreen()),
                },
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
                        Get.offAllNamed("/"),
                        ref.read(morrfUserProvider.notifier).getCurrentUser(),
                      },
                      title: const MorrfText(
                          text: 'Sign Out',
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

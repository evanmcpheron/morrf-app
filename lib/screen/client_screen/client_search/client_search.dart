import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:morrf/providers/service/service_list_provider.dart';
import 'package:morrf/providers/user_provider.dart';
import 'package:morrf/screen/client_screen/client_notification/client_notification.dart';
import 'package:morrf/screen/client_screen/client_service_details/client_service_details.dart';
import 'package:morrf/screen/client_screen/search/search.dart';
import 'package:morrf/screen/trainer_screen/trainer_home/my%20service/service_details.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/format.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:nb_utils/nb_utils.dart';

class ClientSearchScreen extends ConsumerStatefulWidget {
  const ClientSearchScreen({super.key});

  @override
  ConsumerState<ClientSearchScreen> createState() => _ClientSearchScreenState();
}

class _ClientSearchScreenState extends ConsumerState<ClientSearchScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  late bool isSignedIn = user != null;

  @override
  void initState() {
    super.initState();
    ref.read(morrfServicesProvider.notifier).getAllServices();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MorrfUser morrfUser = ref.watch(morrfUserProvider);
    List<MorrfService> morrfServices = ref.watch(morrfServicesProvider);
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
                      image: isSignedIn
                          ? NetworkImage(morrfUser.photoURL)
                          : const AssetImage('images/user_profile.jpg')
                              as ImageProvider,
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          title: isSignedIn
              ? MorrfText(text: morrfUser.fullName, size: FontSize.h5)
              : const MorrfText(text: "Guest", size: FontSize.h5),
          trailing: GestureDetector(
            onTap: () => const ClientNotification().launch(context),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(),
              ),
              child: const FaIcon(FontAwesomeIcons.solidBell),
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: kDarkWhite,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ListTile(
                    horizontalTitleGap: 0,
                    visualDensity: const VisualDensity(vertical: -2),
                    leading: const Icon(
                      FeatherIcons.search,
                      color: kNeutralColor,
                    ),
                    title: Text(
                      'Search services...',
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                    ),
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15.0),
                    Column(
                      children: [
                        const SizedBox(height: 50.0),
                        Container(
                          height: 213,
                          width: 269,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/emptyservice.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const MorrfText(
                          text: 'Empty Service',
                          size: FontSize.h5,
                        ),
                      ],
                    ).visible(morrfServices.isEmpty),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 0.8,
                      crossAxisCount: 2,
                      children: List.generate(
                        morrfServices.length,
                        (index) {
                          MorrfService morrfService = morrfServices[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => ClientServiceDetails(
                                      serviceId: morrfService.id,
                                    ));
                              });
                            },
                            child: Container(
                              height: 205,
                              width: 156,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border:
                                    Border.all(color: kBorderColorTextField),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        key: UniqueKey(),
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8.0),
                                            topLeft: Radius.circular(8.0),
                                          ),
                                          image: DecorationImage(
                                              image: getHeroImage(morrfService),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      user != null
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isFavorite = !isFavorite;
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: isFavorite
                                                      ? const Center(
                                                          child: Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                            size: 16.0,
                                                          ),
                                                        )
                                                      : const Center(
                                                          child: Icon(
                                                            Icons
                                                                .favorite_border,
                                                            size: 16.0,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      height: 125,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MorrfText(
                                            text: morrfService.title,
                                            size: FontSize.lp,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 25.0),
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    IconlyBold.star,
                                                    color: Colors.amber,
                                                    size: 18.0,
                                                  ),
                                                  const SizedBox(width: 2.0),
                                                  const MorrfText(
                                                      text: '5.0',
                                                      size: FontSize.p),
                                                  const SizedBox(width: 2.0),
                                                  MorrfText(
                                                    text: '(520 reviews)',
                                                    size: FontSize.p,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10.0),
                                              Row(
                                                children: [
                                                  const MorrfText(
                                                      text: 'Price ',
                                                      size: FontSize.p),
                                                  MorrfText(
                                                    text:
                                                        '$currencySign${getLowestPrice(morrfServices[index].tiers)}',
                                                    size: FontSize.p,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .money),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ).visible(morrfServices.isNotEmpty),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  NetworkImage getHeroImage(MorrfService morrfService) {
    return NetworkImage(
      morrfService.heroUrl,
    );
  }
}

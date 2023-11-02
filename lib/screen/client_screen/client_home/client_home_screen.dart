import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/providers/service/service_list_provider.dart';
import 'package:morrf/providers/service/service_provider.dart';
import 'package:morrf/providers/user_provider.dart';
import 'package:morrf/screen/client_screen/client_home/client_all_categories.dart';
import 'package:morrf/screen/client_screen/client_home/popular_services.dart';
import 'package:morrf/screen/client_screen/client_home/top_seller.dart';
import 'package:morrf/utils/constants/constants.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/tiles/morrf_service_tile.dart';
import 'package:morrf/widgets/tiles/morrf_trainer_tile.dart';
import 'package:nb_utils/nb_utils.dart';

class ClientHomeScreen extends ConsumerStatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  ConsumerState<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends ConsumerState<ClientHomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  late bool isSignedIn = user != null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var morrfUser = ref.watch(morrfUserProvider);
    List<MorrfService> morrfServices = ref.watch(morrfServicesProvider);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: MorrfSize.s.size),
              HorizontalList(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(left: MorrfSize.m.size),
                spacing: MorrfSize.s.size,
                itemCount: 10,
                itemBuilder: (_, i) {
                  return Container(
                    height: 140,
                    width: 304,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MorrfSize.s.size),
                      image: const DecorationImage(
                          image: AssetImage('images/banner.png'),
                          fit: BoxFit.cover),
                    ),
                  );
                },
              ),
              SizedBox(height: MorrfSize.xl.size),
              Padding(
                padding: EdgeInsets.only(
                    left: MorrfSize.m.size, right: MorrfSize.m.size),
                child: Row(
                  children: [
                    const MorrfText(text: 'Categories', size: FontSize.h5),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => const ClientAllCategories().launch(context),
                      child:
                          const MorrfText(text: 'View All', size: FontSize.p),
                    ),
                  ],
                ),
              ),
              HorizontalList(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                    top: MorrfSize.l.size,
                    bottom: MorrfSize.l.size,
                    left: MorrfSize.m.size,
                    right: MorrfSize.m.size),
                spacing: MorrfSize.s.size,
                itemCount: catName.length,
                itemBuilder: (_, i) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: MorrfSize.s.size,
                        right: MorrfSize.s.size,
                        top: MorrfSize.s.size,
                        bottom: MorrfSize.s.size),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(MorrfSize.s.size),
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryColor
                                .withOpacity(.5))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 39,
                          width: 39,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(catIcon[i]),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(width: MorrfSize.s.size),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MorrfText(
                              text: catName[i],
                              size: FontSize.h6,
                            ),
                            SizedBox(height: MorrfSize.s.size),
                            MorrfText(
                              text: 'View ${catName[i]}',
                              size: FontSize.p,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MorrfSize.m.size, right: MorrfSize.m.size, top: 10),
                child: Row(
                  children: [
                    const MorrfText(
                      text: 'Popular Services',
                      size: FontSize.h5,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => const PopularServices().launch(context),
                      child:
                          const MorrfText(text: 'View All', size: FontSize.p),
                    ),
                  ],
                ),
              ),
              HorizontalList(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                    top: MorrfSize.l.size,
                    bottom: MorrfSize.l.size,
                    left: MorrfSize.m.size,
                    right: MorrfSize.m.size),
                spacing: MorrfSize.s.size,
                itemCount: morrfServices.isEmpty ? 1 : 10,
                itemBuilder: (_, i) {
                  if (morrfServices.isEmpty) {
                    return const MorrfText(
                        text: "Loading Services", size: FontSize.h6);
                  }
                  return MorrfServiceTile(
                      morrfService: morrfServices[i], fullWidth: false);
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MorrfSize.m.size, right: MorrfSize.m.size),
                child: Row(
                  children: [
                    const MorrfText(
                      text: 'Top Trainers',
                      size: FontSize.h5,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => const TopTrainer().launch(context),
                      child:
                          const MorrfText(text: 'View All', size: FontSize.p),
                    ),
                  ],
                ),
              ),
              HorizontalList(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                    top: MorrfSize.l.size,
                    bottom: MorrfSize.l.size,
                    left: MorrfSize.m.size,
                    right: MorrfSize.m.size),
                spacing: MorrfSize.s.size,
                itemCount: 10,
                itemBuilder: (_, i) {
                  return MorrfTrainerTile();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/providers/service/service_list_provider.dart';
import 'package:morrf/screen/client_screen/search/search.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/tiles/morrf_service_tile.dart';
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
    List<MorrfService> morrfServices = ref.watch(morrfServicesProvider);
    return Scaffold(
      body: SizedBox(
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
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 15.0),
                      shrinkWrap: true,
                      itemCount: morrfServices.length,
                      itemBuilder: (_, i) {
                        MorrfService morrfService = morrfServices[i];

                        return MorrfServiceTile(morrfService: morrfService);
                      },
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

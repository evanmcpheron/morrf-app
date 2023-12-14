import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/providers/service/service_list_provider.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/format.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';

import '../trainer_home/my service/service_details.dart';
import 'create_new_service.dart';

class CreateService extends ConsumerStatefulWidget {
  const CreateService({super.key});

  @override
  ConsumerState<CreateService> createState() => _CreateServiceState();
}

class _CreateServiceState extends ConsumerState<CreateService> {
  User user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
    ref
        .read(morrfServicesProvider.notifier)
        .getServicesByTrainer(user.displayName!);
  }

  @override
  Widget build(BuildContext context) {
    List<MorrfService?> morrfServices = ref.watch(morrfServicesProvider);
    print(morrfServices);
    return MorrfScaffold(
      title: 'Create Service',
      trailing: const FaIcon(FontAwesomeIcons.plus),
      trailingPressed: () {
        setState(() {
          const CreateNewService().launch(context);
        });
      },
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    MorrfService morrfService = morrfServices[index]!;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          ServiceDetails(serviceId: morrfService.id)
                              .launch(context);
                        });
                      },
                      child: Container(
                        height: 205,
                        width: 156,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: kBorderColorTextField),
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
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
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
                                                Icons.favorite_border,
                                                size: 16.0,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                              text: '5.0', size: FontSize.p),
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
                                      const SizedBox(height: 5.0),
                                      Row(
                                        children: [
                                          const MorrfText(
                                              text: 'Price ', size: FontSize.p),
                                          MorrfText(
                                              text:
                                                  '$currencySign${getLowestPrice(morrfService.tiers)}',
                                              size: FontSize.p,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .money))
                                        ],
                                      ),
                                    ],
                                  )
                                ],
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
      ),
    );
  }

  NetworkImage getHeroImage(MorrfService morrfService) {
    return NetworkImage(
      morrfService.heroUrl,
    );
  }
}

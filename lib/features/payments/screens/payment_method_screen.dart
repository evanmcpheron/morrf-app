import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/utils/format_date.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/core/widgets/morrf_scaffold.dart';
import 'package:morrf/features/payments/controller/payment_controller.dart';
import 'package:morrf/features/payments/screens/add_credit_card_screen.dart';
import 'package:morrf/models/stripe/card_model.dart';

class PaymentMethodsScreen extends ConsumerStatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  ConsumerState<PaymentMethodsScreen> createState() =>
      _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends ConsumerState<PaymentMethodsScreen> {
  bool isLoading = false;
  List<String> accList = [
    'Credit or Debit Card',
  ];

  List<IconData> imageList = [FontAwesomeIcons.creditCard];

  List<Widget> linkList = [
    const AddCreditCardScreen(),
  ];

  @override
  void initState() {
    super.initState();

    ref.read(morrfCrediCardProvider.notifier).getCards();
  }

  String getLogo(String brand) {
    switch (brand.toLowerCase()) {
      case "visa":
        return 'images/cards/visa.svg';
      case "mastercard":
        return 'images/cards/mastercard.svg';
      case "discover":
        return 'images/cards/discover.svg';
      case "amex":
        return 'images/cards/amex.svg';
      default:
        return 'images/cards/visa.svg';
    }
  }

  void updateDefault(String cardId) {
    ref.read(morrfCrediCardProvider.notifier).updateDefaultCard(cardId);
  }

  Future<void> onRefresh() async {
    print("updated");
    await ref.read(morrfCrediCardProvider.notifier).getCards();
  }

  @override
  Widget build(BuildContext context) {
    List<MorrfCreditCard> creditCards = ref.watch(morrfCrediCardProvider);

    return MorrfScaffold(
      title: "Payment Methods",
      body: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              creditCards.isEmpty
                  ? const Center(
                      child: MorrfText(
                          text: "You don't have any cards on file",
                          size: FontSize.h5),
                    )
                  : RefreshIndicator(
                      onRefresh: () => onRefresh(),
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount: creditCards.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 10.0),
                            itemBuilder: (_, i) {
                              MorrfCreditCard card = creditCards[i];
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Dismissible(
                                  key: Key(card.id),
                                  onDismissed: (direction) {
                                    ref
                                        .read(morrfCrediCardProvider.notifier)
                                        .deleteCard(card.id);
                                  },
                                  confirmDismiss: (direction) async {
                                    if (card.isDefault) {
                                      Get.snackbar("OOPS!",
                                          "Pick a new default payment method before you delete this one.");
                                      return false;
                                    }
                                    return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm"),
                                          content: const Text(
                                              "Are you sure you wish to delete this Payment Method?"),
                                          actions: <Widget>[
                                            MorrfButton(
                                                severity: Severity.danger,
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                text: "Delete"),
                                            MorrfButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              text: "Cancel",
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  background: Container(
                                      color: Colors.red,
                                      child: const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: FaIcon(
                                                  FontAwesomeIcons.trashCan)),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: FaIcon(
                                                  FontAwesomeIcons.trashCan)),
                                        ],
                                      )),
                                  child: ListTile(
                                    leading: SvgPicture.asset(
                                      getLogo(card.brand),
                                      semanticsLabel: getLogo(card.brand),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                    ),
                                    tileColor: Theme.of(context).cardColor,
                                    title: MorrfText(
                                        text: capitalize(card.brand),
                                        size: FontSize.h6),
                                    subtitle: MorrfText(
                                      text: "**** **** **** ${card.last4}",
                                      size: FontSize.p,
                                    ),
                                    onTap: () => card.isDefault
                                        ? print("do nothing")
                                        : updateDefault(card.id),
                                    trailing: MorrfText(
                                        text: card.isDefault ? "Default" : "",
                                        size: FontSize.h6),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
            ],
          ),
          Expanded(child: Container()),
          SafeArea(
            child: MorrfButton(
                onPressed: () => Get.to(() => const AddCreditCardScreen()),
                fullWidth: true,
                text: "Add a Card"),
          ),
        ],
      ),
    );
  }
}

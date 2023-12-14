import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/models/stripe/card_model.dart';
import 'package:morrf/providers/card_provider.dart';
import 'package:morrf/screen/client_screen/client_service_details/client_add_card.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/button_global.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:nb_utils/nb_utils.dart';

class ClientOrder extends ConsumerStatefulWidget {
  Tier service;
  String image;
  String title;

  ClientOrder(
      {super.key,
      required this.service,
      required this.image,
      required this.title});

  @override
  ConsumerState<ClientOrder> createState() => _ClientOrderState();
}

class _ClientOrderState extends ConsumerState<ClientOrder> {
  List<String> paymentMethod = [
    'Credit or Debit Card',
    'Paypal',
    'bkash',
  ];

  String selectedPaymentMethod = 'Credit or Debit Card';

  List<String> imageList = [
    'images/creditcard.png',
    'images/paypal2.png',
    'images/bkash2.png',
  ];

  @override
  void initState() {
    super.initState();

    ref.read(morrfCrediCardProvider.notifier).getCards();
  }

  @override
  Widget build(BuildContext context) {
    List<MorrfCreditCard> creditCards = ref.watch(morrfCrediCardProvider);
    double serviceFee =
        widget.service.price! * 0.05 >= 5 ? widget.service.price! * 0.05 : 5;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: kNeutralColor),
        title: Text(
          'Order',
          style: kTextStyle.copyWith(
              color: kNeutralColor, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: kWhite),
        child: ButtonGlobalWithoutIcon(
          buttontext: 'Continue',
          buttonDecoration: kButtonDecoration.copyWith(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
            setState(() {
              const AddNewCard().launch(context);
            });
          },
          buttonTextColor: kWhite,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          width: context.width(),
          decoration: const BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15.0),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: kBorderColorTextField),
                    boxShadow: const [
                      BoxShadow(
                        color: kDarkWhite,
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8.0),
                                topLeft: Radius.circular(8.0),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(widget.image),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: SizedBox(
                                width: 190,
                                child: Text(
                                  widget.title,
                                  style: kTextStyle.copyWith(
                                      color: kNeutralColor,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            RichText(
                              text: TextSpan(
                                text: 'Price: ',
                                style: kTextStyle.copyWith(
                                    color: kLightNeutralColor),
                                children: [
                                  TextSpan(
                                    text:
                                        '$currencySign${widget.service.price}',
                                    style: kTextStyle.copyWith(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  'Order Details',
                  style: kTextStyle.copyWith(
                      color: kNeutralColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    Text(
                      'Delivery days',
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                    ),
                    const Spacer(),
                    Text(
                      '2 days',
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                ListView.builder(
                  itemCount: widget.service.options.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 10.0),
                  itemBuilder: (_, i) {
                    Option currentOption = widget.service.options[i]!;
                    return Row(
                      children: [
                        MorrfText(
                          text: currentOption.title,
                          maxLines: 1,
                          size: FontSize.p,
                        ),
                        const Spacer(),
                        currentOption.isSelected
                            ? FaIcon(
                                FontAwesomeIcons.check,
                                color:
                                    Theme.of(context).colorScheme.primaryColor,
                              )
                            : const FaIcon(FontAwesomeIcons.minus),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                ListView.builder(
                  itemCount: creditCards.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, i) {
                    MorrfCreditCard card = creditCards[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: kWhite,
                          border: Border.all(color: kBorderColorTextField),
                        ),
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -2),
                          onTap: () {
                            setState(
                              () {
                                selectedPaymentMethod = paymentMethod[i];
                              },
                            );
                          },
                          contentPadding: const EdgeInsets.only(right: 8.0),
                          leading: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(imageList[i]),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          title: Text(
                            paymentMethod[i],
                            style: kTextStyle.copyWith(color: kNeutralColor),
                          ),
                          trailing: Icon(
                            selectedPaymentMethod == paymentMethod[i]
                                ? Icons.radio_button_checked_rounded
                                : Icons.radio_button_off_rounded,
                            color: selectedPaymentMethod == paymentMethod[i]
                                ? kPrimaryColor
                                : kSubTitleColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Order Summary',
                  style: kTextStyle.copyWith(
                      color: kNeutralColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Text(
                      'Subtotal',
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                    ),
                    const Spacer(),
                    Text(
                      '$currencySign${widget.service.price}',
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      'Service Fee',
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                    ),
                    const Spacer(),
                    Text(
                      '$currencySign${serviceFee}',
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: kTextStyle.copyWith(
                          color: kNeutralColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    const Spacer(),
                    Text(
                      '$currencySign${widget.service.price! + serviceFee}',
                      style: kTextStyle.copyWith(
                          color: kNeutralColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      'Delivery Date',
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                    ),
                    const Spacer(),
                    Text(
                      'Thursday, 14 July 2023',
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

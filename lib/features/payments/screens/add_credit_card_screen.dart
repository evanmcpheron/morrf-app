import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:morrf/core/utils.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/core/widgets/morrf_scaffold.dart';
import 'package:morrf/features/payments/controller/payment_controller.dart';

class AddCreditCardScreen extends ConsumerStatefulWidget {
  const AddCreditCardScreen({super.key});
  @override
  ConsumerState<AddCreditCardScreen> createState() {
    return AddCreditCardScreenState();
  }
}

class AddCreditCardScreenState extends ConsumerState<AddCreditCardScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  bool isLoading = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirebaseFunctions functions = FirebaseFunctions.instance;

  Future<void> addCard(paymentMethodId) async {
    try {
      setState(() {
        isLoading = true;
      });
      await ref
          .read(morrfCrediCardProvider.notifier)
          .createCard(paymentMethodId);

      setState(() {
        isLoading = false;
      });
      Get.back();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MorrfScaffold(
      title: "Add a Card",
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: <Widget>[
                  CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    isChipVisible: false,
                    cardBgColor: Theme.of(context).colorScheme.primary,
                    isSwipeGestureEnabled: false,
                    onCreditCardWidgetChange:
                        (CreditCardBrand creditCardBrand) {},
                    customCardTypeIcons: <CustomCardTypeIcon>[
                      CustomCardTypeIcon(
                        cardType: CardType.mastercard,
                        cardImage: SvgPicture.asset(
                          'images/cards/mastercard.svg',
                          semanticsLabel: 'Mastercard Logo',
                          width: MediaQuery.of(context).size.width / 8,
                        ),
                      ),
                      CustomCardTypeIcon(
                        cardType: CardType.visa,
                        cardImage: SvgPicture.asset(
                          'images/cards/visa.svg',
                          semanticsLabel: 'Visa Logo',
                          width: MediaQuery.of(context).size.width / 8,
                        ),
                      ),
                      CustomCardTypeIcon(
                        cardType: CardType.discover,
                        cardImage: SvgPicture.asset(
                          'images/cards/discover.svg',
                          semanticsLabel: 'Discover Logo',
                          width: MediaQuery.of(context).size.width / 8,
                        ),
                      ),
                      CustomCardTypeIcon(
                        cardType: CardType.americanExpress,
                        cardImage: SvgPicture.asset(
                          'images/cards/amex.svg',
                          semanticsLabel: 'American Express Logo',
                          width: MediaQuery.of(context).size.width / 8,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CreditCardForm(
                            formKey: formKey,
                            obscureCvv: true,
                            obscureNumber: true,
                            cardNumber: cardNumber,
                            cvvCode: cvvCode,
                            isHolderNameVisible: true,
                            isCardNumberVisible: true,
                            isExpiryDateVisible: true,
                            cardHolderName: cardHolderName,
                            expiryDate: expiryDate,
                            themeColor: Theme.of(context).colorScheme.primary,
                            cardNumberDecoration: InputDecoration(
                              labelText: 'Number',
                              hintText: 'XXXX XXXX XXXX XXXX',
                              hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              alignLabelWithHint: true,
                              filled: false,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                            ),
                            expiryDateDecoration: InputDecoration(
                              labelText: 'Expired Date',
                              hintText: 'XX/XX',
                              hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              alignLabelWithHint: true,
                              filled: false,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                            ),
                            cvvCodeDecoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              alignLabelWithHint: true,
                              filled: false,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              labelText: 'CVV',
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              alignLabelWithHint: true,
                              filled: false,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              labelText: 'Card Holder',
                            ),
                            onCreditCardModelChange: onCreditCardModelChange,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  MorrfButton(
                    onPressed: _onValidate,
                    fullWidth: true,
                    text: "Add Card",
                  ),
                ],
              ),
            ),
    );
  }

  void _onValidate() async {
    List<String> splitDate = expiryDate.split("/");
    final cardDetails = CardDetails(
      number: cardNumber,
      expirationMonth: int.parse(splitDate[0]),
      expirationYear: int.parse(splitDate[1]),
      cvc: cvvCode,
    );
    Stripe.instance.dangerouslyUpdateCardDetails(cardDetails);

    final billingDetails = BillingDetails(
      email: user.email,
      name: cardHolderName,
      address: const Address(
        country: "US",
        city: "my city",
        line1: "address",
        line2: '',
        state: "NY",
        postalCode: "53535",
      ),
    );

    try {
      /// create payment method
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(billingDetails: billingDetails),
        ),
      );

      addCard(paymentMethod.id);
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

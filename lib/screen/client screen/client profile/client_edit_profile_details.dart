import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:morrf/screen/client%20screen/client%20home/client_home.dart';
import 'package:morrf/screen/client%20screen/client_authentication/client_confirm_sign_in.dart';
import 'package:morrf/screen/seller%20screen/seller%20popUp/seller_popup.dart';
import 'package:morrf/screen/splash%20screen/loading_screen.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_input_field.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';

class ClientEditProfile extends StatefulWidget {
  const ClientEditProfile({Key? key}) : super(key: key);

  @override
  State<ClientEditProfile> createState() => _ClientEditProfileState();
}

class _ClientEditProfileState extends State<ClientEditProfile> {
  final User user = FirebaseAuth.instance.currentUser!;

  final _formKey = GlobalKey<FormState>();
  final _firstNameKey = GlobalKey<FormFieldState>();
  final _lastNameKey = GlobalKey<FormFieldState>();
  final _birthdayKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _phoneKey = GlobalKey<FormFieldState>();
  final _aboutMeKey = GlobalKey<FormFieldState>();
  TextEditingController birthdayController = TextEditingController();

  String _firstName = "";
  String _lastName = "";
  DateTime? _birthday;
  String _email = "";
  String _phoneNumber = "";
  String _selectedGender = "";
  String _aboutMe = "";

  void _onSubmit(String? gender) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      return;
    }
    try {
      String displayName = "$_firstName $_lastName";
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({
        'firstName': _firstName,
        'lastName': _lastName,
        'birthday': _birthday,
        'fullName': "$_firstName $_lastName",
        'email': _email,
        'phoneNumber': _phoneNumber,
        'gender': _selectedGender == "" ? gender : _selectedGender,
        'aboutMe': _aboutMe
      }).then((value) => {
                user.updateDisplayName(displayName),
                user.updateEmail(_email),
                Get.back()
              });

      // ignore: use_build_context_synchronously
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: MorrfText(
              size: FontSize.p,
              text: error.message ?? 'Authentication failed.'),
        ),
      );
    }
  }

  //__________gender___________________________________________________________
  DropdownButton<String> getGender(String? selectedGender) {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in gender) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: _selectedGender == "" ? selectedGender : _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = value!;
        });
      },
    );
  }

  //__________Add_Skill popup________________________________________________
  void showSkillPopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const SellerAddSkillPopUp(),
            );
          },
        );
      },
    );
  }

  //__________Confirmation Login________________________________________________
  void showImportSignIn(String? gender) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ClientConfirmSignIn();
        }).then((val) {
      _onSubmit(gender);
    });
    ;
  }

  //__________Import_Profile_picture_popup_____________________________________
  void showImportProfilePopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const ImportImagePopUp(),
            );
          },
        );
      },
    );
  }

  //__________Save_Profile_success_popup_______________________________________
  void saveProfilePopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const SaveProfilePopUp(),
            );
          },
        );
      },
    );
  }

  Color borderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF144185)
        : const Color(0xff216dde);
  }

  @override
  Widget build(BuildContext context) {
    return MorrfScaffold(
        title: "Edit Profile",
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("users")
                .doc(user.uid)
                .get(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                var morrfUser = snapshot.data.data();
                String? gender = morrfUser['gender'];
                String? aboutMe = morrfUser['aboutMe'];
                String? firstName = morrfUser['firstName'];
                String? lastName = morrfUser['lastName'];
                String? email = morrfUser['email'];
                String? phoneNumber = morrfUser['phoneNumber'];
                Timestamp? birthday = morrfUser['birthday'];

                String getBirthdayTextValue() {
                  if (_birthday != null) {
                    return "${_birthday!.toMoment().month.toString()}-${_birthday!.toMoment().day.toString()}-${_birthday!.toMoment().year.toString()}";
                  } else if (birthday != null) {
                    _birthday = birthday.toDate();
                    return "${birthday.toDate().month.toString()}-${birthday.toDate().day.toString()}-${birthday.toDate().year.toString()}";
                  } else if (birthday != null && _birthday != null) {
                    return "${birthday.toDate().month.toString()}-${birthday.toDate().day.toString()}-${birthday.toDate().year.toString()}";
                  } else {
                    return "";
                  }
                }

                birthdayController.text = getBirthdayTextValue();

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: kPrimaryColor),
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(user.photoURL!),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showImportProfilePopUp();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: kWhite,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: kPrimaryColor),
                                            ),
                                            child: const Icon(
                                              IconlyBold.camera,
                                              color: kPrimaryColor,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.displayName!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: kTextStyle.copyWith(
                                              color: kNeutralColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                        Text(
                                          user.email!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: kTextStyle.copyWith(
                                              color: kSubTitleColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30.0),
                                MorrfInputField(
                                  key: _firstNameKey,
                                  inputType: TextInputType.name,
                                  placeholder: "First Name*",
                                  hint: "Enter your first name",
                                  initialValue: firstName,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'You must have at least a first name.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _firstName = value.toString();
                                    });
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                MorrfInputField(
                                  key: _lastNameKey,
                                  inputType: TextInputType.name,
                                  placeholder: "Last Name",
                                  hint: "Enter your first name",
                                  initialValue: lastName,
                                  onSaved: (value) {
                                    setState(() {
                                      _lastName = value.toString();
                                    });
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                MorrfInputField(
                                  key: _emailKey,
                                  placeholder: "Email",
                                  hint: "Enter your email",
                                  initialValue: email,
                                  inputType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        !value.contains('@')) {
                                      return 'Please enter a valid email address.';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _email = value.toString();
                                    });
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                MorrfInputField(
                                  key: _phoneKey,
                                  inputType: TextInputType.phone,
                                  placeholder: "Phone Number",
                                  hint: "Enter your phone number",
                                  initialValue: phoneNumber?.replaceAllMapped(
                                      RegExp(r'(\d{3})(\d{3})(\d+)'),
                                      (Match m) => "(${m[1]}) ${m[2]}-${m[3]}"),
                                  onSaved: (value) {
                                    setState(() {
                                      _phoneNumber = value
                                          .toString()
                                          .replaceAllMapped(
                                              RegExp(r'(\d{3})(\d{3})(\d+)'),
                                              (Match m) =>
                                                  "(${m[1]}) ${m[2]}-${m[3]}");
                                    });
                                  },
                                ),
                                const SizedBox(height: 10.0),
                                MorrfInputField(
                                  key: _birthdayKey,
                                  controller: birthdayController,
                                  inputType: TextInputType.datetime,
                                  placeholder: "Birthday",
                                  hint: "Enter your birthday",
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1901),
                                        lastDate: DateTime(2030));
                                    if (picked != null) {
                                      setState(() => {
                                            birthdayController.text =
                                                "${picked.toMoment().month.toString()}-${picked.toMoment().day.toString()}-${picked.toMoment().year.toString()}",
                                            _birthday = picked
                                          });
                                    }
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                FormField(
                                  initialValue: selectedGender,
                                  builder: (FormFieldState<dynamic> field) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        filled: true,
                                        constraints:
                                            const BoxConstraints(maxHeight: 56),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: borderColor(context),
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
                                              color: borderColor(context),
                                              width: 2.0),
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                          child: getGender(gender)),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                SizedBox(
                                  height: 150,
                                  child: MorrfInputField(
                                    key: _aboutMeKey,
                                    onSaved: (value) {
                                      setState(() {
                                        _aboutMe = value.toString();
                                      });
                                    },
                                    initialValue: aboutMe,
                                    inputType: TextInputType.multiline,
                                    maxLines: null,
                                    expands: true,
                                    placeholder: 'About Me',
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      SafeArea(
                        child: MorrfButton(
                          onPressed: () {
                            showImportSignIn(gender);
                            // _onSubmit(gender);
                          },
                          fullWidth: true,
                          child: const MorrfText(
                              text: 'Update Profile', size: FontSize.p),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return LoadingPage();
              }
            }));
  }
}

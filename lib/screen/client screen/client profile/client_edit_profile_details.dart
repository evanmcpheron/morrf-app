import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:morrf/providers/user_provider.dart';
import 'package:morrf/screen/client%20screen/client_authentication/client_confirm_sign_in.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:uuid/uuid.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_input_field.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';

class ClientEditProfile extends ConsumerStatefulWidget {
  const ClientEditProfile({super.key});

  @override
  ConsumerState<ClientEditProfile> createState() => _ClientEditProfileState();
}

class _ClientEditProfileState extends ConsumerState<ClientEditProfile> {
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
  Timestamp? _birthday;
  String _email = "";
  String _phoneNumber = "";
  String _selectedGender = "";
  String _aboutMe = "";

  File? pickedImageFile;
  void _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) return;

    print(pickedImage);
    setState(() {
      pickedImageFile = File(pickedImage.path);
    });
  }

  void _onSubmit(String? gender) async {
    MorrfUser morrfUser = ref.watch(morrfUserProvider);
    String stripeId = morrfUser.stripe;
    List<MorrfProduct>? products = morrfUser.products;
    List<MorrfOrder>? orders = morrfUser.orders;
    String? imageUrl;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      return;
    }
    try {
      if (pickedImageFile != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${Uuid().v4()}.jpg');

        await storageRef.putFile(pickedImageFile!);

        imageUrl = await storageRef.getDownloadURL();
        user.updatePhotoURL(imageUrl);
      }

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
        'photoURL': imageUrl ?? user.photoURL,
        'phoneNumber': _phoneNumber,
        'gender': _selectedGender == "" ? gender : _selectedGender,
        'aboutMe': _aboutMe
      }).then((value) => {
                user.updateDisplayName(displayName),
                user.updateEmail(_email),
                ref.read(morrfUserProvider.notifier).updateUser({
                  'id': user.uid,
                  'firstName': _firstName,
                  'lastName': _lastName,
                  'birthday': _birthday,
                  'photoURL': imageUrl ?? user.photoURL,
                  'fullName': "$_firstName $_lastName",
                  'email': _email,
                  'phoneNumber': _phoneNumber,
                  'stripe': stripeId,
                  'gender': _selectedGender == "" ? gender : _selectedGender,
                  'aboutMe': _aboutMe,
                  'products': products,
                  'orders': orders,
                }),
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

  Color borderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF144185)
        : const Color(0xff216dde);
  }

  @override
  Widget build(BuildContext context) {
    MorrfUser morrfUser = ref.watch(morrfUserProvider);
    Timestamp? timestampBirthday = morrfUser.birthday;

    String getBirthdayTextValue() {
      if (_birthday != null) {
        DateTime dateBirthday = DateTime.fromMicrosecondsSinceEpoch(
            _birthday!.microsecondsSinceEpoch!);
        return "${dateBirthday.toMoment().month.toString()}-${dateBirthday.toMoment().day.toString()}-${dateBirthday.toMoment().year.toString()}";
      } else if (timestampBirthday != null) {
        _birthday = timestampBirthday;
        return "${timestampBirthday.toDate().month.toString()}-${timestampBirthday.toDate().day.toString()}-${timestampBirthday.toDate().year.toString()}";
      } else if (timestampBirthday != null && _birthday != null) {
        return "${timestampBirthday.toDate().month.toString()}-${timestampBirthday.toDate().day.toString()}-${timestampBirthday.toDate().year.toString()}";
      } else {
        return "";
      }
    }

    birthdayController.text = getBirthdayTextValue();

    return MorrfScaffold(
      title: "Edit Profile",
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
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
                                CircleAvatar(
                                  radius: 52,
                                  backgroundColor: kPrimaryColor,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey,
                                    foregroundImage: pickedImageFile != null
                                        ? FileImage(pickedImageFile!)
                                        : NetworkImage(morrfUser.photoURL)
                                            as ImageProvider,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _pickImage(ImageSource.gallery),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: kWhite,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: kPrimaryColor),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MorrfText(
                                    text: user.displayName!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    size: FontSize.h5),
                                MorrfText(
                                  text: user.email!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  size: FontSize.p,
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
                          initialValue: morrfUser.firstName,
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
                          initialValue: morrfUser.lastName,
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
                          initialValue: morrfUser.email,
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
                          initialValue: morrfUser.phoneNumber?.replaceAllMapped(
                              RegExp(r'(\d{3})(\d{3})(\d+)'),
                              (Match m) => "(${m[1]}) ${m[2]}-${m[3]}"),
                          onSaved: (value) {
                            setState(() {
                              _phoneNumber = value.toString().replaceAllMapped(
                                  RegExp(r'(\d{3})(\d{3})(\d+)'),
                                  (Match m) => "(${m[1]}) ${m[2]}-${m[3]}");
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
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1901),
                                lastDate: DateTime(2030));
                            if (picked != null) {
                              setState(() => {
                                    birthdayController.text =
                                        "${picked.toMoment().month.toString()}-${picked.toMoment().day.toString()}-${picked.toMoment().year.toString()}",
                                    _birthday = Timestamp.fromDate(picked)
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
                                      color: borderColor(context), width: 2.0),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: borderColor(context), width: 2.0),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                  child: getGender(morrfUser.gender)),
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
                            initialValue: morrfUser.aboutMe,
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
                    showImportSignIn(morrfUser.gender);
                    // _onSubmit(gender);
                  },
                  fullWidth: true,
                  child:
                      const MorrfText(text: 'Update Profile', size: FontSize.p),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

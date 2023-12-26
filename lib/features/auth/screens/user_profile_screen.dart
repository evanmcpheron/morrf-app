import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/utils.dart';
import 'package:morrf/core/widgets/error.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/core/widgets/morrf_dropdown.dart';
import 'package:morrf/core/widgets/morrf_input_field.dart';
import 'package:morrf/core/widgets/morrf_scaffold.dart';
import 'package:morrf/features/auth/controller/auth_controller.dart';
import 'package:morrf/features/auth/screens/become_trainer_screen.dart';
import 'package:morrf/features/splash_screen/screens/splash_screen.dart';
import 'package:morrf/models/user/morrf_user.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String userId;
  const UserProfileScreen({super.key, required this.userId});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  late User? user = FirebaseAuth.instance.currentUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  bool editMode = false;
  File? image;

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData(MorrfUser morrfUser) async {
    String name = nameController.text.trim();

    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider.notifier)
          .updateUserInFirebase(morrfUser, context, name, image, ref);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSignedInUser =
        widget.userId == FirebaseAuth.instance.currentUser?.uid;
    final size = MediaQuery.of(context).size;

    return ref.watch(getUserDataProvider(widget.userId)).when(
        data: (morrfUser) => MorrfScaffold(
              title: isSignedInUser ? "My Profile" : "Someone Else",
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Stack(
                                    children: [
                                      image == null
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                morrfUser.photoURL,
                                              ),
                                              radius: 64,
                                            )
                                          : CircleAvatar(
                                              backgroundImage: FileImage(
                                                image!,
                                              ),
                                              radius: 64,
                                            ),
                                      editMode
                                          ? Positioned(
                                              bottom: -10,
                                              left: 80,
                                              child: IconButton(
                                                onPressed: selectImage,
                                                icon: const Icon(
                                                  Icons.add_a_photo,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                                editMode
                                    ? Column(
                                        children: [
                                          MorrfInputField(
                                            controller: nameController,
                                            placeholder: 'Name',
                                            hint: "Name",
                                          ),
                                          MorrfInputField(
                                            controller: emailController,
                                            placeholder: 'Email',
                                            hint: "Email",
                                          ),
                                          MorrfInputField(
                                            controller: aboutMeController,
                                            placeholder: 'About Me',
                                            hint: "About Me",
                                            inputType: TextInputType.multiline,
                                            minLines: 1,
                                            maxLines: 5,
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0),
                                            child: MorrfText(
                                              text: morrfUser.displayName,
                                              size: FontSize.h5,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Divider(),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: MorrfText(
                                              text: morrfUser.aboutMe ?? "",
                                              softWrap: true,
                                              maxLines: 5,
                                              size: FontSize.p,
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                          isSignedInUser
                              ? Column(
                                  children: [
                                    MorrfButton(
                                      onPressed: () => editMode
                                          ? storeUserData(morrfUser)
                                          : setState(() {
                                              editMode = !editMode;
                                            }),
                                      fullWidth: true,
                                      text: editMode ? "Save" : "Edit Profile",
                                    ),
                                    editMode
                                        ? Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 8, 0, 0),
                                            child: MorrfButton(
                                              onPressed: () => setState(() {
                                                editMode = !editMode;
                                              }),
                                              fullWidth: true,
                                              text: "Cancel",
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                )
                              : SizedBox(),
                          isSignedInUser && morrfUser.morrfTrainer == null
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: MorrfButton(
                                    onPressed: () => Get.to(
                                        () => const BecomeTrainerScreen()),
                                    fullWidth: true,
                                    text: "Become a Morrf Trainer",
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        error: (Object error, StackTrace stackTrace) => ErrorScreen(
              error: error.toString(),
            ),
        loading: () => const SplashScreen());
  }
}

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/features/services/add_service/controller/service_controller.dart';
import 'package:morrf/features/splash_screen/screens/redirect_splash_screen.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:reorderables/reorderables.dart';
import 'package:uuid/uuid.dart';

class CreateNewServiceImagesScreen extends ConsumerStatefulWidget {
  final bool isVisible;
  final MorrfService morrfService;
  final Function(int page) pageChange;
  final Function(Map<String, dynamic> data) updateService;
  const CreateNewServiceImagesScreen({
    super.key,
    required this.isVisible,
    required this.pageChange,
    required this.morrfService,
    required this.updateService,
  });

  @override
  ConsumerState<CreateNewServiceImagesScreen> createState() =>
      _CreateNewServiceImagesScreenState();
}

class _CreateNewServiceImagesScreenState
    extends ConsumerState<CreateNewServiceImagesScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  List<Widget> _tiles = [];
  List<File> files = [];
  String imageUrl = "";
  List<String> imageList = [];

  void removeImage(UniqueKey key, File file) {
    List<Widget> updatedWidgets =
        _tiles.where((element) => element.key != key).toList();
    List<File> updatedFiles =
        files.where((element) => element.uri == file.uri).toList();
    setState(() {
      _tiles = updatedWidgets;
      files = updatedFiles;
    });
  }

  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
      maxWidth: 750,
    );
    if (pickedImage == null) return;
    UniqueKey key = UniqueKey();

    setState(
      () {
        if (_tiles.length <= 6) {
          _tiles = [
            ..._tiles,
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 24,
              key: key,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.topCenter,
                      image: FileImage(File(pickedImage.path)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => removeImage(key, File(pickedImage.path)),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.trash,
                          color: Theme.of(context).colorScheme.primary,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ];
          files.add(File(pickedImage.path));
        }
      },
    );
  }

  void _onSubmit() async {
    try {
      for (var i = 0; i < files.length; i++) {
        var storageRef = FirebaseStorage.instance
            .ref()
            .child('service_images')
            .child("${const Uuid().v4()}.jpg");
        await storageRef.putFile(files[i]);
        imageUrl = await storageRef.getDownloadURL();
        imageList = [...imageList, imageUrl];
      }

      Map<String, dynamic> data = {
        'heroUrl': imageList[0],
        'photoUrls': imageList,
      };

      widget.updateService(data);
      ref
          .read(serviceControllerProvider.notifier)
          .createService(widget.morrfService);
      const snackBar = SnackBar(
        content: MorrfText(
            text: 'Published Successfully!',
            size: FontSize.h5,
            textAlign: TextAlign.center),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Get.offAll(
        () => const RedirectSplashScreen(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 20.0),
        Row(
          children: [
            MorrfButton(
              onPressed: () {
                widget.pageChange(3);
              },
              width: MediaQuery.of(context).size.width / 2 - 23,
              text: "Back",
            ),
            const SizedBox(
              width: 16,
            ),
            MorrfButton(
              severity: Severity.success,
              onPressed: () {
                if (_tiles.isEmpty) {
                  const snackBar = SnackBar(
                    content: MorrfText(
                        text: 'Don\'t forget to add at least one image',
                        size: FontSize.h5,
                        textAlign: TextAlign.center),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  _onSubmit();
                }
              },
              width: MediaQuery.of(context).size.width / 2 - 23,
              text: "Publish",
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        const MorrfText(text: 'Images (Up to 6)', size: FontSize.h6),
        const SizedBox(height: 8.0),
        const MorrfText(
            text: '960 x 540px for best results', size: FontSize.h6),
        const SizedBox(height: 15.0),
        buildImageDisplay(context),
        MorrfButton(
            onPressed: () {
              pickImage();
            },
            disabled: _tiles.length > 5,
            severity: Severity.success,
            fullWidth: true,
            text: "Add Images"),
        const SizedBox(height: 16.0),
      ],
    ).visible(widget.isVisible);
  }

  Widget buildImageDisplay(BuildContext context) {
    void onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _tiles.removeAt(oldIndex);
        _tiles.insert(newIndex, row);

        File? file = files.removeAt(oldIndex);
        files.insert(newIndex, file);
      });
    }

    var wrap = ReorderableWrap(
      spacing: 16.0,
      runSpacing: 4.0,
      padding: const EdgeInsets.only(bottom: 16),
      onReorder: (int oldIndex, int newIndex) {
        onReorder(oldIndex, newIndex);
      },
      onNoReorder: (int index) {
        //this callback is optional
        debugPrint(
            '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
      },
      onReorderStarted: (int index) {
        //this callback is optional
        debugPrint(
            '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
      },
      children: _tiles,
    );

    return SingleChildScrollView(
      child: wrap,
    );
  }
}

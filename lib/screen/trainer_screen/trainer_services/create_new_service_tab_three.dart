import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/providers/loading_provider.dart';
import 'package:morrf/screen/trainer_screen/trainer_home/trainer_home.dart';
import 'package:morrf/screen/trainer_screen/trainer_services/new_service_provider.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/enums/severity.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:reorderables/reorderables.dart';
import 'package:uuid/uuid.dart';

class CreateNewServiceTabThree extends ConsumerStatefulWidget {
  bool isVisible;
  Function(int page) pageChange;
  CreateNewServiceTabThree(
      {super.key, required this.isVisible, required this.pageChange});

  @override
  ConsumerState<CreateNewServiceTabThree> createState() =>
      _CreateNewServiceTabThreeState();
}

class _CreateNewServiceTabThreeState
    extends ConsumerState<CreateNewServiceTabThree> {
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
                          color: kWhite,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color:
                                  Theme.of(context).colorScheme.dangerButton),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.trash,
                          color: Theme.of(context).colorScheme.dangerButton,
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
      ref.read(loadingProvider.notifier).startLoader();

      for (var i = 0; i < files.length; i++) {
        var storageRef = FirebaseStorage.instance
            .ref()
            .child('service_images')
            .child("${const Uuid().v4()}.jpg");
        await storageRef.putFile(files[i]);
        imageUrl = await storageRef.getDownloadURL();
        imageList = [...imageList, imageUrl];
        print(imageUrl);
      }

      Map<String, dynamic> data = {
        'heroUrl': imageList[0],
        'photoUrls': imageList,
      };

      ref.read(newServiceProvider.notifier).updateNewService(data);
      ref
          .read(newServiceProvider.notifier)
          .updateNewService({'trainerName': user.uid});
      MorrfService morrfService = ref.watch(newServiceProvider);
      ref.read(newServiceProvider.notifier).createService(morrfService);
      ref.read(loadingProvider.notifier).stopLoader();
      ref.read(newServiceProvider.notifier).disposeNewService();
      Get.offAll(
        () => TrainerHome(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    MorrfService morrfService = ref.watch(newServiceProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
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
        Row(
          children: [
            MorrfButton(
              onPressed: () {
                widget.pageChange(1);
              },
              width: MediaQuery.of(context).size.width / 2 - 23,
              text: "Back",
            ),
            const SizedBox(
              width: 16,
            ),
            MorrfButton(
              severity: Severity.success,
              disabled: _tiles.isEmpty,
              onPressed: () {
                _onSubmit();
              },
              width: MediaQuery.of(context).size.width / 2 - 23,
              text: "Create Listing",
            ),
          ],
        ),
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

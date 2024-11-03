import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';

class ImagePicker extends StatelessWidget {
  const ImagePicker({super.key, required this.child, required this.onSelected});
  final Widget child;
  final void Function(File file) onSelected;

  Future<File?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) {
      return null;
    }
    final files = result.files.map((e) => File(e.path!)).toList();
    return files[0];
  }

  Future<File?> cropImage({required File image}) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'トリミング',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'トリミング',
          aspectRatioPickerButtonHidden: true,
          rotateButtonsHidden: true,
          resetButtonHidden: true,
          rotateClockwiseButtonHidden: true,
          aspectRatioLockEnabled: true,
          doneButtonTitle: '決定',
          cancelButtonTitle: '戻る',
        ),
      ],
    );
    if (croppedFile == null) {
      return null;
    }
    return File(croppedFile.path);
  }

  Future<File?> compressImage(File file) async {
    final filePath = file.absolute.path;
    final fileSize = await file.length();

    // 2MB以下の場合、元のファイルを返す
    if (fileSize < 2 * 1024 * 1024) {
      return file;
    }

    // 画像を圧縮する
    final compressedImage =
        await FlutterImageCompress.compressWithFile(filePath, quality: 50);

    // 圧縮された画像を保存する
    final compressedFile = File(filePath)..writeAsBytesSync(compressedImage!);

    return compressedFile;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final selectedImage = await pickImage();
        if (selectedImage == null) {
          return;
        }
        final croppedImage = await cropImage(image: selectedImage);
        if (croppedImage == null) {
          return;
        }
        final compressedImage = await compressImage(croppedImage);
        if (compressedImage == null) {
          return;
        }
        onSelected(compressedImage);
      },
      child: child,
    );
  }
}

import 'dart:io';
import 'dart:typed_data';

import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/services/camera_service/camera_service.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imag;
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';

class IcCamera extends StatefulWidget {
  final void Function(Uint8List) onTakePicture;
  const IcCamera({super.key, required this.onTakePicture});

  @override
  State<IcCamera> createState() => _IcCameraState();
}

class _IcCameraState extends State<IcCamera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Gambar"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
      ),
      body: CameraWidget(
        overlay: const CameraOverlay(
          aspectRatio: 6 / 3,
          padding: 30,
        ),
        onTakePicture: (img) async {
          //>>> OPPO PHONE RESOLUTION CROP<<<<
          // final croppedImg = cropCenterRectangle(
          //   img,
          //   context,
          //   containerWidthRatio: 0.7,
          //   containerHeightRatio: 0.112,
          // );

          //>>> DEVICE V11 RESOLUTION CROP<<<<
          final croppedImg = cropImage(img, 2.3, 50);
          //-----------------------------------
          final result = await imageCropper(croppedImg);
          widget.onTakePicture(result);
        },
      ),
    );
  }

  Uint8List cropImage(
      Uint8List bytes, double overlayAspectRatio, double overlayPadding) {
    imag.Image? image = imag.decodeImage(bytes);

    if (image == null) return bytes; // handle image decoding failure

    // Calculate overlay dimensions relative to image size
    double overlayWidth, overlayHeight;
    double xOffset = 0, yOffset = 0;

    imag.Image? img = imag.decodeImage(bytes)!;

    final imageWidth = img.width.toDouble();
    final imageHeight = img.height.toDouble();

    double imageAspectRatio = imageWidth / img.height.toDouble();

    if (imageAspectRatio < overlayAspectRatio) {
      // Overlay fits based on image width
      overlayWidth = imageWidth - 2 * overlayPadding;
      overlayHeight = overlayWidth / overlayAspectRatio;
      yOffset = (imageHeight - overlayHeight) / 2;
    } else {
      // Overlay fits based on image height
      overlayHeight = imageHeight - 2 * overlayPadding;
      overlayWidth = overlayHeight * overlayAspectRatio;
      xOffset = (imageWidth - overlayWidth) / 5;
    }

    // Crop the image using the calculated overlay dimensions and position
    final croppedImage = imag.copyCrop(
      image,
      x: xOffset.round(),
      y: yOffset.round(),
      width: overlayWidth.round(),
      height: overlayHeight.round(),
    );

    final bmp = imag.encodeJpg(croppedImage);
    return Uint8List.fromList(bmp);
  }

  Future<Uint8List> imageCropper(Uint8List bytes) async {
    final path = await getTempPath(bytes, "temp_img.jpg");
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.primary.color,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: CropAspectRatioPreset.values,
        )
      ],
    );
    if (croppedFile == null) return bytes;
    return await croppedFile.readAsBytes();
  }

  Future<String> getTempPath(Uint8List img, String fileName) async {
    // Get the temporary directory
    final Directory tempDir = await getTemporaryDirectory();

    // Create a temporary file
    final File tempFile = File('${tempDir.path}/$fileName');

    // Write the Uint8List to the temporary file
    await tempFile.writeAsBytes(img);

    return tempFile.path; // Return the path of the temporary file
  }

  Uint8List cropCenterRectangle(
    Uint8List imageData,
    BuildContext context, {
    required double containerWidthRatio,
    required double containerHeightRatio,
  }) {
    // Decode the image
    imag.Image? originalImage = imag.decodeImage(imageData);

    if (originalImage == null) {
      throw Exception("Unable to decode image");
    }

    // Calculate the width and height for the container based on the screen size
    final containerWidth =
        MediaQuery.of(context).size.width * containerWidthRatio;
    final containerHeight =
        MediaQuery.of(context).size.height * containerHeightRatio;

    // Calculate the container aspect ratio
    final containerAspectRatio = containerWidth / containerHeight;

    // Determine the target crop dimensions based on the container's aspect ratio
    int targetWidth, targetHeight;

    if ((originalImage.width / originalImage.height) >= containerAspectRatio) {
      // Image is wider than the container's aspect ratio, so base target height on the image height
      targetHeight = originalImage.height;
      targetWidth = (targetHeight * containerAspectRatio).toInt();
    } else {
      // Image is taller than the container's aspect ratio, so base target width on the image width
      targetWidth = originalImage.width;
      targetHeight = (targetWidth / containerAspectRatio).toInt();
    }

    // Calculate the top-left coordinates to center the cropping rectangle
    int x = (originalImage.width - targetWidth) ~/ 2;
    int y = (originalImage.height - targetHeight) ~/ 2;

    // Perform the cropping
    imag.Image croppedImage = imag.copyCrop(
      originalImage,
      x: x,
      y: y,
      width: targetWidth,
      height: targetHeight,
    );

    // Convert the cropped image back to Uint8List
    return Uint8List.fromList(imag.encodePng(croppedImage));
  }
}

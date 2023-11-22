import 'package:appointment_app/presentation/providers/form/image_input_provider.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageInput extends StatelessWidget {
  const ImageInput({super.key});

  @override
  Widget build(BuildContext context) {
    final selectImage = context.watch<ImageInputProvider>();
    return Column(
      children: [
        selectImage.imageFile != null
        ? Image.file(selectImage.imageFile!, width: 100)
        : const Text('Image..'),
        StyleElevatedButton(
          onPressed: () {
            selectImage.showImageSourceDialog(context);
          },
          text: 'Select Image',
        ),
      ],
    );
  }
}
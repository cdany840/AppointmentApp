import 'package:appointment_app/presentation/providers/form/image_input_provider.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  @override
  Widget build(BuildContext context) {
    final selectImage = context.watch<ImageInputProvider>();

    return Column(
      children: [
        StyleElevatedButton(
          onPressed: () {
            selectImage.showImageSourceDialog(context);
          },
          text: 'Select Image',          
        ),
        const SizedBox( height: 16 ),
        selectImage.imageFile != null
        ? Image.file(selectImage.imageFile!, width: 300)
        : const Text('Image..')
      ],
    );
  }
}
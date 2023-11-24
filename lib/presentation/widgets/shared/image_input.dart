import 'package:appointment_app/presentation/providers/form/provider_image_input.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageInput extends StatelessWidget { 
  const ImageInput({super.key, this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final selectImage = context.watch<ProviderImageInput>();
    double screen = MediaQuery.of(context).size.height;
    return Column(
      children: [
        selectImage.imageFile != null || imageUrl!.isNotEmpty
        ? Container(
            margin: const EdgeInsets.only( top: 20),
            height: screen * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: selectImage.imageFile != null
                ? Image.file(selectImage.imageFile!)
                : Image.network(imageUrl!),
            ),
          )
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
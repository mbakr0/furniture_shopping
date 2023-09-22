
import 'package:flutter/cupertino.dart';

class ImageWidget extends StatelessWidget {
  final String path;
  const ImageWidget({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return ClipRRect
      (borderRadius: BorderRadius.circular(12),child: Image(
      width: 100,
      height: 100,
      fit: BoxFit.fill,
      image: AssetImage(path)));
  }

}
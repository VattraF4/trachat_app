//package
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RoundedImageNetwork extends StatelessWidget {
  final String imagePath;
  final String networkImage =
      'https://ranavattra.com/portfolio/assets/image/fav-image.png';
  final double size;
  const RoundedImageNetwork({
    // this.networkImage,
    required Key key,
    required this.imagePath,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(size)),
        color: Colors.black,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: CachedNetworkImage(
          imageUrl: imagePath,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[300],
            child: Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.error, color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class RoundedImageFile extends StatelessWidget {
  final PlatformFile image;
  final double size;
  const RoundedImageFile({
    required Key key,
    required this.image,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(File(image.path!)),
        ),
        borderRadius: BorderRadius.all(Radius.circular(size)),
        color: Colors.black,
      ),
    );
  }
}

class RoundedImageNetworkIndicator extends RoundedImageNetwork {
  final bool isActive;
  RoundedImageNetworkIndicator({
    required super.key,
    required String imagePath,
    required super.size,
    required this.isActive,
  }) : super(imagePath: imagePath);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        super.build(context),
        Container(
          height: size * 0.20,
          width: size * 0.20,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(size),
          ),
        ),
      ],
    );
  }
}

//Package
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Widget
import '../widgets/round_image.dart';

//Models
import '../models/users.dart';
import '../models/message.dart';

class CustomListViewTile extends StatelessWidget {
  final double height;
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isActive; // Use to show online status
  final bool isAcitivty; // Use to show activity
  final Function onTap;

  //Constructor
  const CustomListViewTile({
    super.key,
    required this.height,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.isActive,
    required this.isAcitivty,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      minVerticalPadding: height * 0.20,
      
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}

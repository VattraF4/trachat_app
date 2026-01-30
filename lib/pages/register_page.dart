//Package
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

//Service
import '../services/media_service.dart';
import '../services/database_service.dart';
import '../services/cloud_storage_service.dart';

//Widgets
import '../widgets/custom_input_field.dart';
import '../widgets/rounded_button.dart';
import '../widgets/round_image.dart';

//Provider
import '../provider/authenticator_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceHeigh;
  late double _deviceWidth;

  PlatformFile? _profileImage;

  @override
  Widget build(BuildContext context) {
    _deviceHeigh = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03, // padding 3% of width
          vertical: _deviceHeigh * 0.02, // padding 2% of heigh
        ),
        // color: Colors.red,
        height: _deviceHeigh * 0.98, //98% of height
        width: _deviceWidth * 0.97, // 97% of width
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileImageField(),
            const SizedBox(height: 6), // space between image and text
            const Text(
              "Click to Change Image",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileImageField() {
    return GestureDetector(
      onTap: () {
        GetIt.instance.get<MediaService>().pickImageFromLibrary().then((file) {
          return setState(() {
            _profileImage = file;
          });
        });
      },
      child: () {
        // Text("Click to Chagne Image", style: Color.fromRGBO(0, 0, 0, 1.0));
        if (_profileImage != null) {
          return RoundedImageFile(
            key: UniqueKey(),
            image: _profileImage!,
            size: _deviceHeigh * 0.15,
          );
        } else {
          return RoundedImageNetowrk(
            key: UniqueKey(),
            imagePath:
                'https://ranavattra.com/portfolio/assets/image/fav-image.png',
            size: _deviceHeigh * 0.15,
          );
        }
      }(),
    );
  }
}

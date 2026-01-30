//Package
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

//Service
import '../services/media_service.dart';
import '../services/database_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/navigation_service.dart';

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

  String? _email;
  String? _paswword;
  String? _name;
  PlatformFile? _profileImage;

  //Provider Action Button
  late AuthenticatorProvider _auth;

  //Service
  late DatabaseService _db;
  late CloudStorageService _cloudStorage;
  late NavigationService _navigation;

  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticatorProvider>(context);
    _db = GetIt.instance.get<DatabaseService>();
    _cloudStorage = GetIt.instance.get<CloudStorageService>();
    _navigation = GetIt.instance.get<NavigationService>();

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
            const Text(
              "Click to Change Image",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            _regiesterForm(),
            _registerButton(),
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
          // ============= Use Image from Internet ==========
          return RoundedImageNetwork(
            key: UniqueKey(),
            imagePath:
                'https://ranavattra.com/portfolio/assets/image/fav-image.png',

            size: _deviceHeigh * 0.15,
          );
        }
      }(),
    );
  }

  Widget _regiesterForm() {
    return Container(
      height: _deviceHeigh * 0.35,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              onSaved: (value) {
                setState(() {
                  _name = value;
                });
              },
              hintText: "Name",
              regEx: r'.{8,}',
              requiredMessage: 'Name is require',
              invalidMessage: "Name is not valid",
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              onSaved: (value) {
                setState(() {
                  _email = value;
                });
              },
              hintText: "Email",
              regEx: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              requiredMessage: 'Email is require',
              invalidMessage: "Email is not valid",
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              onSaved: (value) {
                setState(() {
                  _paswword = value;
                });
              },
              hintText: "Password",
              regEx: r'^.{6,}$',
              requiredMessage: 'Password is require',
              invalidMessage: "Pasword is not valied",
              isPassword: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    return RoundedButton(
      name: "Register",
      height: _deviceHeigh * 0.065,
      width: _deviceHeigh * 0.65,
      onPressed: () async {
        if (_registerFormKey.currentState!.validate() &&
            _profileImage != null) {
          //Continue register user

          _registerFormKey.currentState!.save();

          String? uid = await _auth.registerUserUsingEmailAndPassword(
            _email!,
            _paswword!,
          );
          String? imageUrl = await _cloudStorage.saveUserImageToStorage(
            uid!,
            _profileImage!,
          );
          await _db.createUser(uid, _email!, _name!, imageUrl!);
          // _navigation.goBack();
          await _auth.logout();
          await _auth.login(_email!, _paswword!);
        }
      },
    );
  }
}

import 'package:file_picker/file_picker.dart';

class MediaService {
  MediaService();

  //PlatformFile? is in the file_picker package
  Future<PlatformFile?> pickImageFromLibrary() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      return result.files.first;
      //return _result.files[0]; // same
    }
    return null;
  }
}

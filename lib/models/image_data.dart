import 'package:image_picker/image_picker.dart';

class ImageData {
  String imageUrl;
  String title;
  String description;
  final ImagePicker _picker = ImagePicker();
  String fileName = '';

  ImageData(
      {required this.title,
      this.fileName = '',
      required this.imageUrl,
      required this.description});

  ImageData.fromJson(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        title = json['title'],
        description = json['description'];

  pickImageFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    imageUrl = '${image?.path}';
  }

  pickImageNewCapPic() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    imageUrl = '${image?.path}';
  }
}

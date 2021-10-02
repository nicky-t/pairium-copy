import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<void> saveImage({required String imageUrl}) async {
  final url = Uri.parse(imageUrl);
  final response = await http.get(url);
  await ImageGallerySaver.saveImage(Uint8List.fromList(response.bodyBytes));
}

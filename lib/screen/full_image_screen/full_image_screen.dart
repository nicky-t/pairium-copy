import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:photo_view/photo_view.dart';

import '../../utility/save_image.dart';

class FullImageScreen extends StatelessWidget {
  const FullImageScreen({
    required this.imageProvider,
    required this.heroTag,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  static Route<void> route({
    required ImageProvider imageProvider,
    required String heroTag,
    required String imageUrl,
  }) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: FullImageScreen(
            imageProvider: imageProvider,
            heroTag: heroTag,
            imageUrl: imageUrl,
          ),
        );
      },
    );
  }

  final ImageProvider imageProvider;
  final String heroTag;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(appBarTheme: const AppBarTheme(color: Colors.white)),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 18 && details.globalPosition.dx < 80) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  onPressed: () async {
                    EasyLoading.instance.backgroundColor = Colors.black54;
                    await EasyLoading.showToast(
                      'デバイスに保存しました',
                      duration: const Duration(milliseconds: 2000),
                      maskType: EasyLoadingMaskType.none,
                    );
                    await saveImage(imageUrl: imageUrl);
                    EasyLoading.instance.backgroundColor = Colors.transparent;
                  },
                  icon: const Icon(
                    Icons.save_alt,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
          body: PhotoView(
            imageProvider: imageProvider,
            loadingBuilder: (context, chunk) {
              return const Center(child: CircularProgressIndicator());
            },
            heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
          ),
        ),
      ),
    );
  }
}

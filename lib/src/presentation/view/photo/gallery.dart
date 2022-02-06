import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GalleryPageState();
  }
}

class _GalleryPageState extends State<GalleryPage> {
  late List<String> _images;
  late int _index;

  @override
  void initState() {
    final _params = Get.arguments as GalleryParams;
    _images = _params.images;
    _index = _params.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (context, index) => _buildItem(_images[index], index),
            itemCount: _images.length,
            onPageChanged: (index) => setState(() {
              _index = index;
            }),
            scrollDirection: Axis.horizontal,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DotsIndicator(
              dotsCount: _images.length,
              position: _index.toDouble(),
            ),
          )
        ],
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(String path, int index) {
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(path),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * 1,
      maxScale: PhotoViewComputedScale.contained * 5,
      heroAttributes: PhotoViewHeroAttributes(tag: path),
    );
  }
}

class GalleryParams {
  List<String> images;
  int index;

  GalleryParams({
    required this.images, required this.index
  });
}
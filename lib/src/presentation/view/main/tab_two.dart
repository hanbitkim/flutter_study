import 'package:artitecture/src/presentation/route.dart';
import 'package:artitecture/src/presentation/view/photo/gallery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabTwo extends StatelessWidget {
  const TabTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed(galleryRoute, arguments: GalleryParams(images: ['https://picsum.photos/200/300', 'https://picsum.photos/200', 'https://picsum.photos/id/237/200/300'], index: 0));
      },
      child: const Text('gallery'),
    );
  }
}
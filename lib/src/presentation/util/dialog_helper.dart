import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class DialogHelper {
  static void showImagePickerDialog(BuildContext context, Function(String?) callback) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('사진을 어디서 가져올까요?'),
          content: SizedBox(
            width: 200,
            height: 120,
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return ListTile(
                      title: TextButton(
                        child: const Text('갤러리에서 가져오기'),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1000, maxHeight: 1000);
                          Logger().d('image selected = ${image?.path}');
                          callback.call(image?.path);
                        },
                      ),
                    );
                  } else {
                    return ListTile(
                      title: TextButton(
                        child: const Text('사진 촬영'),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await _picker.pickImage(source: ImageSource.camera, maxWidth: 1000, maxHeight: 1000);
                          Logger().d('image captured = ${image?.path}');
                          callback.call(image?.path);
                        },
                      ),
                    );
                  }
                }),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
          ],
        ));
  }
}
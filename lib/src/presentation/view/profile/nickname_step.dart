import 'package:artitecture/src/presentation/deep_link_manager.dart';
import 'package:flutter/material.dart';

class NickNameStep extends StatelessWidget {
  const NickNameStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () async {
      DeepLinkManager.sendDynamicLinkUri(Uri.parse("https://findpassword"));
    }, child: const Text('NickName'));
  }
}
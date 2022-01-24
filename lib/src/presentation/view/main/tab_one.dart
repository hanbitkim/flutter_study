import 'package:artitecture/src/presentation/deep_link_manager.dart';
import 'package:flutter/material.dart';

class TabOne extends StatelessWidget {
  const TabOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () async {
      DeepLinkManager.sendDynamicLinkUri(Uri.parse("https://findpassword"));
    }, child: const Text('dynamicLink'));
  }
}
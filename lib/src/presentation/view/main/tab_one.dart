import 'package:artitecture/src/presentation/deep_link_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TabOne extends HookWidget {
  const TabOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {
      DeepLinkManager.sendDynamicLinkUri(Uri.parse("https://findpassword"));
    }, child: const Text('dynamicLink'));
  }
}
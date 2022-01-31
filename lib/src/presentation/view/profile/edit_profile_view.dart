import 'package:artitecture/src/core/utils/colors.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/main_controller.dart';
import 'package:artitecture/src/presentation/view/main/tab_one.dart';
import 'package:artitecture/src/presentation/view/main/tab_three.dart';
import 'package:artitecture/src/presentation/view/main/tab_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class EditProfilePage extends HookWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: const Text('Edit Profile'),
    );
  }
}
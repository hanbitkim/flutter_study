import 'package:artitecture/src/core/global.dart';
import 'package:artitecture/src/domain/entity/response/user.dart';
import 'package:artitecture/src/presentation/deep_link_manager.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  static CommunityController get to => Get.find();

  final Rxn<User?> userData = user;
}

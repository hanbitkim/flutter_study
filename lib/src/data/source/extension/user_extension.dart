import 'package:artitecture/src/data/source/extension/firebase_extension.dart';
import 'package:artitecture/src/domain/entity/response/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension UserExtension on DocumentSnapshot {
  User toUser() {
    return User(
      name: getSafety('name'),
      email: getSafety('email'),
      profileUrl: getSafety('profile_url'),
      isApproved: getSafety('is_approved')
    );
  }
}
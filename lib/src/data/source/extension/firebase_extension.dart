import 'package:artitecture/src/domain/entity/response/app_version.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/domain/entity/response/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseExtension on DocumentSnapshot {
  dynamic getSafety(String field) {
    try {
      return get(field);
    } on StateError catch (e) {
      return null;
    }
  }

  AppVersion toAppVersion() {
    return AppVersion(
        requiredVersion: get('required_version'),
        requiredChanges: get('required_changes'),
        latestVersion: get('latest_version'),
        latestChanges: get('latest_changes')
    );
  }

  User toUser(String? userId, List<Category> categories) {
    return User(
        id: userId,
        nickname: getSafety('nickname'),
        email: getSafety('email'),
        profileUrl: getSafety('profile_url'),
        isApproved: getSafety('is_approved'),
        categories: categories
    );
  }

  Category toCategory() {
    return Category(
        id: getSafety('category_id'),
        name: getSafety('category_name')
    );
  }
}
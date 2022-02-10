import 'package:artitecture/src/domain/entity/response/app_version.dart';
import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/domain/entity/response/author.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/domain/entity/response/comment.dart';
import 'package:artitecture/src/domain/entity/response/image.dart';
import 'package:artitecture/src/domain/entity/response/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

extension FirebaseExtension on DocumentSnapshot {
  dynamic getSafety(String field) {
    try {
      return get(field);
    } on StateError catch (e) {
      return null;
    }
  }

  DateTime parseTime(Timestamp? date) {
    if (date == null) {
      return DateTime.parse("1969-07-20 20:18:04Z");
    }
    return date.toDate();
  }

  AppVersion toAppVersion() {
    return AppVersion(
      requiredVersion: get('required_version'),
      requiredChanges: get('required_changes'),
      latestVersion: get('latest_version'),
      latestChanges: get('latest_changes'),
    );
  }

  User toUser() {
    final List<Category> categories = List.empty(growable: true);
    final categoriesData = getSafety('categories');
    Logger().d('category = ${categoriesData?.toString()}');
    if (categoriesData != null) {
      for (var element in List.from(categoriesData)) {
        Logger().d('category element = ${element.toString()}');
        categories.add(Category(id: element['id'] ?? '', name: element['name'] ?? ''));
      }
    }
    return User(
      id: id,
      nickname: getSafety('nickname'),
      email: getSafety('email'),
      profileUrl: getSafety('profile_url'),
      isApproved: getSafety('is_approved'),
      categories: categories,
    );
  }

  Category toCategory() {
    return Category(id: id, name: getSafety('category_name'));
  }

  Article toArticle(List<Image> images, Author author) {
    return Article(
        id: id,
        title: getSafety('title'),
        contents: getSafety('contents'),
        commentCount: getSafety('comment_count') ?? 0,
        likeCount: getSafety('like_count') ?? 0,
        isReported: getSafety('is_reported') ?? false,
        createdDate: parseTime(getSafety('created_date')),
        images: images,
        author: author,
        comments: List.empty());
  }

  Comment toComment(List<Image> images, Author author) {
    return Comment(
        id: id,
        contents: getSafety('contents'),
        images: images,
        likeCount: getSafety('like_count'),
        isReported: getSafety('is_reported'),
        createdDate: getSafety('created_date'),
        updatedDate: getSafety('updated_date'),
        author: author);
  }

  Author toAuthor() {
    return Author(
      id: getSafety('author_id') ?? '',
      nickname: getSafety('nickname') ?? '',
      profileUrl: getSafety('profile_url'),
    );
  }

  Image toImage() {
    return Image(
      id: id,
      thumbnailUrl: getSafety('thumbnail_url') ?? '',
      imageUrl: getSafety('image_url') ?? '',
    );
  }
}

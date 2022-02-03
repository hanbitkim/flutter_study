import 'package:artitecture/src/domain/entity/param/upload_article_param.dart';
import 'package:artitecture/src/domain/usecase/upload_article_usecase.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ArticleWriteController extends GetxController {
  ArticleWriteController(this._uploadArticleUseCase);

  static ArticleWriteController get to => Get.find();

  final UploadArticleUseCase _uploadArticleUseCase;
  final Rxn<String?> categoryId = Rxn();
  final Rxn<String?> title = Rxn();
  final Rxn<String?> contents = Rxn();
  final images = <String>[].obs;

  @override
  void onInit() async {
    await _retrieveLostData();
    super.onInit();
  }

  void setCategoryId(String? categoryId) {
    this.categoryId.value = categoryId;
  }

  void setTitle(String? title) {
    this.title.value = title;
  }

  void setContents(String? contents) {
    this.contents.value = contents;
  }

  void addImage(String? path) {
    if (path != null) {
      images.add(path);
    }
  }

  void removeImage(String? path) {
    images.remove(path);
  }

  void upload() async {
    final param = UploadArticleParam(categoryId.value, title.value, contents.value, images);
    final response = await _uploadArticleUseCase(param);
    if (response.isSuccess()) {
      Get.back();
    } else {
      Get.snackbar("게시글 작성에 실패했습니다", "네트워크 상태를 확인 후 다시 시도해주세요");
    }
  }

  Future<void> _retrieveLostData() async {
    final ImagePicker _picker = ImagePicker();
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        if (response.file != null) {
          images.add(response.file!.path);
        }
      }
    }
  }
}
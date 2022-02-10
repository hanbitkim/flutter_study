import 'package:artitecture/src/core/global.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/article_write_controller.dart';
import 'package:artitecture/src/presentation/util/dialog_helper.dart';
import 'package:artitecture/src/presentation/util/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ArticleWritePage extends HookWidget {
  const ArticleWritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ArticleWriteController _articleWriteController = Get.put(injector());
    final TextEditingController _titleController = useTextEditingController();
    final TextEditingController _contentsController = useTextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    useEffect(() {
      final subscription = _articleWriteController.isLoading.listen((value) {
        if (value) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
      });
      return subscription.cancel;
    }, [_articleWriteController]);

    return Scaffold(
        appBar: AppBar(title: const Text("게시글 작성"), actions: [
          TextButton(
              onPressed: () {
                DialogHelper.showImagePickerDialog(context, (path) {
                  _articleWriteController.addImage(path);
                });
              },
              child: const Text('사진추가', style: TextStyle(color: Colors.white))),
          TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  _articleWriteController.upload();
                }
              },
              child: const Text('등록', style: TextStyle(color: Colors.white)))
        ]),
        body: Obx(
          () => SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                      items: _getItems(),
                      onChanged: (value) => _articleWriteController.setCategoryId(value),
                      value: _articleWriteController.categoryId.value,
                      validator: (value) => value == null ? '카테고리를 선택해주세요' : null,
                      hint: const Text("카테고리를 선택해주세요")),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: '제목을 입력해주세요',
                    ),
                    onChanged: (value) => _articleWriteController.setTitle(value),
                    validator: (value) => value == null || value.trim().isEmpty ? '제목을 입력해주세요' : null,
                    maxLines: 1,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _contentsController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: '내용을 입력해주세요',
                      ),
                      onChanged: (value) => _articleWriteController.setContents(value),
                      validator: (value) => value == null || value.trim().isEmpty ? '내용을 입력해주세요' : null,
                    ),
                  ),
                  _articleWriteController.images.isNotEmpty
                      ? SizedBox(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _articleWriteController.images.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 100,
                                height: 100,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: WidgetHelper.getImageWidget(_articleWriteController.images[index], BoxFit.cover),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: ElevatedButton(
                                        child: const Icon(Icons.close),
                                        style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          fixedSize: const Size(30, 30),
                                        ),
                                        onPressed: () {
                                          _articleWriteController.removeImage(_articleWriteController.images[index]);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ));
  }

  List<DropdownMenuItem<String>>? _getItems() {
    return user.value?.categories.map((e) => DropdownMenuItem(child: Text(e.name), value: e.id)).toList();
  }
}

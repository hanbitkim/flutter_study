import 'package:artitecture/src/core/global.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/article_write_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class ArticleWritePage extends HookWidget {
  const ArticleWritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ArticleWriteController _articleWriteController = Get.put(injector());
    final TextEditingController _titleController = useTextEditingController();
    final TextEditingController _contentsController = useTextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("게시글 작성"),
        actions: [
          TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: const Text('등록', style: TextStyle(color: Colors.white))
          )
        ]
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButton<String>(
                items: getItems(),
                onChanged: (value) {
                  _articleWriteController.categoryId.value = value;
                },
                value: _articleWriteController.categoryId.value,
                hint: const Text("카테고리를 선택해주세요")
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '제목을 입력해주세요',
                ),
                onChanged: (value) {
                  _articleWriteController.title.value = value;
                },
                validator: (value) {
                  if (value == null || value.length < 3) {
                    return '제목을 3자 이상 입력해주세요';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentsController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: '내용을 입력해주세요',
                ),
                onChanged: (value) {
                  _articleWriteController.contents.value = value;
                },
                validator: (value) {
                  if (value == null || value.length < 10) {
                    return '내용을 10자 이상 입력해주세요';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      )
    );
  }

  List<DropdownMenuItem<String>>? getItems() {
    return user.value?.categories.map((e) => DropdownMenuItem(child: Text(e.name), value: e.id)).toList();
  }
}

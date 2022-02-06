import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleItemView extends StatelessWidget {
  final Article _article;

  const ArticleItemView(this._article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('제목 : '),
            Text(_article.title)
          ],
        ),
        Row(
          children: [
            const Text('내용 : '),
            Text(_article.title)
          ],
        ),

        Text(DateFormat.yMd().add_jm().format(_article.createdDate))
      ],
    );
  }
}

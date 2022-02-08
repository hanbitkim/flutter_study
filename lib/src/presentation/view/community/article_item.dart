import 'package:artitecture/src/core/utils/text_utils.dart';
import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/domain/entity/response/image.dart' as model;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleItemView extends StatelessWidget {
  final Article _article;

  const ArticleItemView(this._article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_article.title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )
              ),
              const SizedBox(
                height: 10,
              ),
              Text(_article.contents,
                  style: const TextStyle(
                      fontSize: 16
                  )
              ),
              _article.images.isNotEmpty
                  ? Column(children: [
                    const SizedBox(height: 14),
                    getImageView(_article.images)
                  ])
                  : Container()
              ,
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(_article.author.nickname),
                  const Spacer(),
                  Text(TextUtils.getCreatedBefore(_article.createdDate))
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              InkWell(
                child: Row(
                  children: const [
                    Icon(Icons.favorite_border),
                    SizedBox(width: 8),
                    Text('좋아요')
                  ],
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                child: Row(
                  children: [
                    const Icon(Icons.chat_bubble_outline),
                    const SizedBox(width: 8),
                    _article.commentCount == 0
                    ? const Text('댓글쓰기')
                    : Text('답변 ${_article.commentCount}')
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
  
  Widget getImageView(List<model.Image> images) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
              placeholder: (context, url) => const Icon(Icons.photo),
              errorWidget: (context, url, error) => const Icon(Icons.photo),
              fit: BoxFit.cover,
              imageUrl: images.first.imageUrl ?? ''
            )
          ),
        ),
        images.length > 1
            ? Text('+ ${images.length - 1}')
            : Container()
      ],
    );
  }
}

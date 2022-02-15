import 'package:artitecture/src/core/utils/text_utils.dart';
import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:artitecture/src/presentation/view/community/article_detail.dart';
import 'package:artitecture/src/presentation/view/photo/gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleItemView extends StatelessWidget {
  final Article _article;

  const ArticleItemView(this._article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        articleDetailRoute,
        arguments: ArticleDetailParams(article: _article),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _article.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _article.contents,
                  style: const TextStyle(fontSize: 16),
                ),
                if (_article.images.isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 14),
                      getImageViews(_article.images.map((e) => e.imageUrl).toList()),
                    ],
                  ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(_article.author.nickname),
                    const Spacer(),
                    Text(TextUtils.getCreatedBefore(_article.createdDate)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            child: Row(
              children: [
                InkWell(
                  child: Row(
                    children: const [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 8),
                      Text('좋아요'),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  child: Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline),
                      const SizedBox(width: 8),
                      _article.commentCount == 0 ? const Text('댓글쓰기') : Text('답변 ${_article.commentCount}'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getImageViews(List<String> images) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: images.length == 1
            ? _getImageView(images, 0)
            : images.length == 2
                ? Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: _getImageView(images, 0),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: _getImageView(images, 1),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: _getImageView(images, 0),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: _getImageView(images, 1)),
                            const SizedBox(height: 4),
                            Expanded(
                              child: images.length > 3
                                  ? Stack(
                                      children: [
                                        Positioned.fill(child: _getImageView(images, 2)),
                                        IgnorePointer(child: Container(color: Colors.black26)),
                                        IgnorePointer(
                                          child: Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '+ ${images.length - 3}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : _getImageView(images, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _getImageView(List<String> images, int index) {
    return InkWell(
      child: CachedNetworkImage(
        placeholder: (context, url) => _getImageHolder(Icons.photo),
        errorWidget: (context, url, error) => _getImageHolder(Icons.error),
        fit: BoxFit.cover,
        imageUrl: images[index],
      ),
      onTap: () => Get.toNamed(
        galleryRoute,
        arguments: GalleryParams(
          images: images,
          index: index,
        ),
      ),
    );
  }

  Widget _getImageHolder(IconData? iconData) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Icon(
        iconData,
        size: 50,
        color: Colors.grey,
      ),
    );
  }
}

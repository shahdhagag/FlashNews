import 'package:flutter/material.dart';

import '../../../models/news_response.dart';

class NewsTitleWidget extends StatelessWidget {
  const NewsTitleWidget({
    super.key,
    required this.article,
  });

  final Articles article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),
      child: Text(
        article.title ?? '',
        style: Theme.of(context).textTheme.labelMedium,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../models/news_response.dart';
import 'loading_widget.dart';

class NewsImage extends StatelessWidget {
  const NewsImage({
    super.key,
    required this.article,
    required this.isDark,
  });

  final Articles article;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: article.urlToImage ?? "",
        width: 345.w,
        height: 220.h,
        fit: BoxFit.cover,
        memCacheHeight: 600,
        placeholder: (context, url) => Container(
          width: 345.w,
          height: 220.h,
          color: isDark ? Colors.grey[900] : Colors.grey[200],
          child: const Center(child: LoadingWidget()),
        ),
        errorWidget: (context, url, error) => Container(
          width: 345.w,
          height: 220.h,
          color: isDark ? Colors.grey[900] : Colors.grey[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image,
                size: 40,
                color: isDark ? Colors.white24 : Colors.grey,
              ),
              Gap(5.h),
              Text(
                "Image unavailable",
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

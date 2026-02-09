import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/core/cubits/theme_cubit.dart';
import 'package:newsapp/core/utiles/app_colors.dart';
import 'package:newsapp/features/home/news/custom_bottom_sheet.dart' hide showBottomSheet;
import 'package:newsapp/features/home/widgets/loading_widget.dart';
import 'package:newsapp/models/news_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class CardNews extends StatelessWidget {
  const CardNews({super.key, required this.article});
  final Articles article;
  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeCubit>().isDarkMode();

    return GestureDetector(
      onTap: () => showArticleBottomSheet(context, article),
      child: Card(
        color: isDark ?AppColors.black:AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color:isDark? AppColors.whiteColor: Colors.black,
            width: 1,
          ),
        ),

        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Image section
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? "",
                  width: 345.w,
                  height: 220.h,
                  fit: BoxFit.cover,

                  // while loading
                  placeholder: (context, url) => SizedBox(
                    width: 345.w,
                    height: 220.h,
                    child: const Center(child:
                    LoadingWidget()),
                  ),

                  // if image fails
                  errorWidget: (context, url, error) => Container(
                    width: 345.w,
                    height: 220.h,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, size: 40),
                  ),
                )

              ),
              /// Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Text(
                  article.title ?? '',
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              /// Author and time
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160.w,
                      child: Text(
                        'By ${article.author ?? 'Unknown Author'}',
                        style: Theme.of(context).textTheme.labelSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Text(
                      //  article.publishedAt ?? '',
                      //timeago.format(DateTime.parse(article.publishedAt??'')),    //todo: using timeago package

                      timeAgoSinceDate(article.publishedAt ?? ''),
                      style: Theme.of(context).textTheme.labelSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String timeAgoSinceDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    Duration diff = DateTime.now().difference(date);

    if (diff.inDays >= 365) return "${(diff.inDays / 365).floor()} years ago";
    if (diff.inDays >= 30) return "${(diff.inDays / 30).floor()} months ago";
    if (diff.inDays >= 1) return "${diff.inDays} days ago";
    if (diff.inHours >= 1) return "${diff.inHours} hours ago";
    if (diff.inMinutes >= 1) return "${diff.inMinutes} minutes ago";
    return "just now";
  }
}

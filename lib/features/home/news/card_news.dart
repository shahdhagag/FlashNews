import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsApp/core/cubits/theme_cubit.dart';
import 'package:newsApp/core/utiles/app_colors.dart';
import 'package:newsApp/models/news_response.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/auther_Time_row.dart';
import '../widgets/news_iamge_cashed_network.dart';
import '../widgets/news_title_widget.dart';
import '../widgets/show_bottom_sheet.dart';

class CardNews extends StatelessWidget {
  const CardNews({super.key, required this.article, this.isLoading = false});

  final Articles article;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeCubit>().isDarkMode();

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () => showArticleBottomSheet(context, article),
        child: Card(
          color: isDark ? AppColors.black : AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isDark ? AppColors.whiteColor : Colors.black,
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
                NewsImage(article: article, isDark: isDark),

                /// Title
                NewsTitleWidget(article: article),

                /// Author and time
                Auther_TimeWidget(article: article),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

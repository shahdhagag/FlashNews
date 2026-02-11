import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsApp/core/cubits/theme_cubit.dart';
import 'package:newsApp/models/news_response.dart';
import '../news/custom_bottom_sheet.dart';

void showArticleBottomSheet(BuildContext context, Articles article) {
  final bool isDark = context.read<ThemeCubit>().isDarkMode();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ArticleBottomSheetWidget(
      article: article,
      isDark: isDark,
    ),
  );
}
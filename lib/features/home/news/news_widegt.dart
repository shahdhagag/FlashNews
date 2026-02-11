import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:newsApp/features/home/bloc/home_cubit.dart';
import 'package:newsApp/features/home/news/card_news.dart';

class NewsWidegt extends StatelessWidget {
  final String? searchQuery;
  const NewsWidegt({super.key, this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetNewsLoadingState) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }

        if (state is GetNewsErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        var bloc = context.watch<HomeCubit>();

        /// Check for empty news list during search
        if (state is GetNewsSuccessState && bloc.newsList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 80.sp, color: Colors.grey),
                Gap(16.h),
                Text("No results found for your search".tr()),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: bloc.newsList.length,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          itemBuilder: (context, index) {
            if (index >= bloc.newsList.length) return const SizedBox();
            return CardNews(article: bloc.newsList[index]);
          },
        );
      },
    );
  }
}

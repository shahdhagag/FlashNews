import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/api/api_manager.dart';
import 'package:newsapp/core/utiles/app_colors.dart';
import 'package:newsapp/features/home/news/news_widegt.dart';
import 'package:newsapp/features/home/source/source_tab.dart';
import 'package:newsapp/features/home/widgets/error_widget.dart';
import 'package:newsapp/features/home/widgets/loading_widget.dart';
import 'package:newsapp/models/source_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gap/gap.dart';

class SourceCategories extends StatefulWidget {
  final bool isDark;
  const SourceCategories({super.key, required this.isDark});

  @override
  State<SourceCategories> createState() => _SourceCategoriesState();
}

class _SourceCategoriesState extends State<SourceCategories> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: ApiManager(Dio()).getSource(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        } else if (snapshot.hasError || snapshot.data?.status != 'ok') {
          return MainErrorWidget(
            errorMsg: snapshot.data?.message ?? "Something went wrong.",
            onTryAgain: () => setState(() {}),
          );
        }

        var sourceList = snapshot.data?.sources ?? [];
        if (sourceList.isEmpty) return const Center(child: Text("No sources."));

        return DefaultTabController(
          length: sourceList.length,
          initialIndex: selectedIndex,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  pinned: false,
                  centerTitle: true,
                  title: Text(
                    "Home".tr(),
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      color: widget.isDark ? AppColors.whiteColor : AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  actions: const [
                    ImageIcon(AssetImage("assets/images/searchIcon.png")),
                    Gap(16),
                  ],
                  bottom: TabBar(
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicatorColor: widget.isDark ? AppColors.whiteColor : AppColors.black,
                    indicatorWeight: 3,
                    tabAlignment: TabAlignment.start,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    tabs: sourceList.map((source) {
                      return Tab(
                        child: SourceTab(
                          source: source,
                          isSelected: selectedIndex == sourceList.indexOf(source),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ];
            },
            body: NewsWidegt(
              key: ValueKey(sourceList[selectedIndex].id),
              sources: sourceList[selectedIndex],
            ),
          ),
        );
      },
    );
  }
}
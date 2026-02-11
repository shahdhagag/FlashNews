import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsApp/core/utiles/app_colors.dart';
import 'package:newsApp/features/home/bloc/home_cubit.dart';
import 'package:newsApp/features/home/news/news_widegt.dart';
import 'package:newsApp/features/home/source/source_tab.dart';
import 'package:newsApp/features/home/widgets/error_widget.dart';
import 'package:newsApp/features/home/widgets/loading_widget.dart';
import 'package:newsApp/models/category.dart';

import '../widgets/source_not_found_widget.dart';

class SourceCategories extends StatelessWidget {
  final bool isDark;
  final CategoryModel category;

  const SourceCategories({
    super.key,
    required this.isDark,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var bloc = context.read<HomeCubit>();

        if (state is GetSourceLoadingState) {
          return const LoadingWidget();
        }

        if (state is GetSourceErrorState) {
          return MainErrorWidget(
            errorMsg: state.errorMsg,
            onTryAgain: () => bloc.getSources(category.id),
          );
        }

        if (bloc.sourcesList.isEmpty) {
          return SourceNotFoudWidget(
            isDark: isDark,
            bloc: bloc,
            category: category,
          );
        }

        return DefaultTabController(
          length: bloc.sourcesList.length,
          initialIndex: bloc.selectedIndex,
          child: RefreshIndicator(
            onRefresh: () async => await bloc.getSources(category.id),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    pinned: false,
                    automaticallyImplyLeading: false,
                    toolbarHeight: 0,
                    bottom: TabBar(
                      isScrollable: true,
                      dividerColor: Colors.transparent,
                      indicatorColor: isDark
                          ? AppColors.whiteColor
                          : AppColors.black,
                      indicatorWeight: 3,
                      tabAlignment: TabAlignment.start,
                      onTap: (index) => bloc.changeSelectedTab(index),
                      tabs: bloc.sourcesList.map((source) {
                        return Tab(
                          child: SourceTab(
                            source: source,
                            isSelected:
                                bloc.selectedIndex ==
                                bloc.sourcesList.indexOf(source),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ];
              },
              body: NewsWidegt(
                key: ValueKey(bloc.sourcesList[bloc.selectedIndex].id),
              ),
            ),
          ),
        );
      },
    );
  }
}

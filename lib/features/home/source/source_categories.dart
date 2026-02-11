import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsApp/Di/di.dart';
import 'package:newsApp/core/network/internet_checker.dart';
import 'package:newsApp/core/utiles/app_colors.dart';
import 'package:newsApp/features/home/bloc/home_cubit.dart';
import 'package:newsApp/features/home/data/Repo/home_repo_local_impl.dart';
import 'package:newsApp/features/home/data/Repo/home_repo_remote_impl.dart';
import 'package:newsApp/features/home/news/news_widegt.dart';
import 'package:newsApp/features/home/source/source_tab.dart';
import 'package:newsApp/features/home/widgets/error_widget.dart';
import 'package:newsApp/features/home/widgets/loading_widget.dart';
import 'package:newsApp/models/category.dart';

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
    print(
      "InternetConnectivity().isConnected:${InternetConnectivity().isConnected}",
    );

    return BlocProvider<HomeCubit>(
      create: (context) => getIt<HomeCubit>()..getSources(category.id),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var bloc = context.watch<HomeCubit>();

          /// Show loading until sources arrive
          if (state is GetSourceLoadingState) {
            return const LoadingWidget();
          }

          /// Handle error
          if (state is GetSourceErrorState) {
            return MainErrorWidget(errorMsg: state.errorMsg, onTryAgain: () {});
          }

          /// Prevent empty list crash
          if (bloc.sourcesList.isEmpty) {
            return const Center(
              child: Text(
                "No Sources Found",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return DefaultTabController(
            length: bloc.sourcesList.length,
            initialIndex: bloc.selectedIndex,
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<HomeCubit>().getSources(category.id);
              },
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      floating: true,
                      // appears when you scroll up
                      snap: true,
                      // smooth snapping
                      pinned: false,
                      // disappears when scrolling down
                      automaticallyImplyLeading: false,
                      toolbarHeight: 0,
                      // remove full AppBar space
                      bottom: TabBar(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        indicatorColor: isDark
                            ? AppColors.whiteColor
                            : AppColors.black,
                        indicatorWeight: 3,
                        tabAlignment: TabAlignment.start,
                        onTap: (index) {
                          bloc.changeSelectedTab(index);
                        },
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:newsApp/features/home/bloc/home_cubit.dart';
import 'package:newsApp/features/home/news/card_news.dart';

class NewsWidegt extends StatelessWidget {
  const NewsWidegt({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetNewsLoadingState) {
          context.loaderOverlay.show();
        }

        if (state is GetNewsSuccessState || state is GetNewsErrorState) {
          context.loaderOverlay.hide();
        }

        if (state is GetNewsErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },

      builder: (context, state) {
        var bloc = context.watch<HomeCubit>();

        if (bloc.newsList.isEmpty && state is GetNewsSuccessState) {
          return const Center(child: Text("No articles available"));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await context.read<HomeCubit>().getNewsData();
          },
          child: ListView.builder(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(), // important for refresh
            ),
            itemCount: bloc.newsList.length,
            itemBuilder: (context, index) {
              return CardNews(article: bloc.newsList[index]);
            },
          ),
        );
      },
    );
  }
}

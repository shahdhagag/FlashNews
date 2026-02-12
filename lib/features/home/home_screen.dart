import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:newsApp/Di/di.dart';
import 'package:newsApp/core/cubits/theme_cubit.dart';
import 'package:newsApp/core/utiles/app_assets.dart';
import 'package:newsApp/core/utiles/app_colors.dart';
import 'package:newsApp/features/home/bloc/home_cubit.dart';
import 'package:newsApp/features/home/category_selector.dart';
import 'package:newsApp/features/home/source/source_categories.dart';
import 'package:newsApp/features/home/widgets/drawer_widget.dart';
import 'package:newsApp/features/home/widgets/search_text_field.dart';
import 'package:newsApp/models/category.dart';

import 'news/news_widegt.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  CategoryModel? selectedCategory;

  void goHome() {
    setState(() {
      selectedCategory = null;
      _isSearching = false;
      _searchController.clear();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeCubit>().isDarkMode();

    return BlocProvider<HomeCubit>(
      create: (context) => getIt<HomeCubit>(),
      child: LoaderOverlay(
        child: Scaffold(
          drawer: _buildDrawer(),
          appBar: _buildAppBar(isDark),
          body: _buildBody(isDark),
        ),
      ),
    );
  }


























  /// Extracted UI Components ////

  Widget? _buildDrawer() {
    if (_isSearching) return null;
    return Drawer(child: DrawerWidget(onGoHome: goHome));
  }

  PreferredSizeWidget _buildAppBar(bool isDark) {
    return AppBar(
      title: Builder(
        builder: (context) => _isSearching
            ? _buildSearchField(isDark)
            : _buildAppBarTitle(isDark),
      ),
      actions: [
        if (!_isSearching) _buildSearchAction(isDark),
        Gap(16.w),
      ],
    );
  }

  Widget _buildSearchField(bool isDark) {
    return SearchTextField(
      isDark: isDark,
      searchController: _searchController,
      onClose: () {
        setState(() {
          _isSearching = false;
          _searchController.clear();
        });
      },
    );
  }

  Widget _buildAppBarTitle(bool isDark) {
    return Text(
      selectedCategory?.title ?? "Home".tr(),
      style: GoogleFonts.inter(
        fontSize: 20.sp,
        color: isDark ? AppColors.whiteColor : AppColors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSearchAction(bool isDark) {
    return IconButton(
      icon: ImageIcon(
        AssetImage(AppAssets.searchIcon),
        color: isDark ? AppColors.whiteColor : AppColors.black,
        size: 24.sp,
      ),
      onPressed: () => setState(() => _isSearching = true),
    );
  }

  Widget _buildBody(bool isDark) {
    return Builder(
      builder: (context) {
        if (_isSearching) {
          return const NewsWidegt();
        }

        if (selectedCategory == null) {
          return CategorySelector(
            onCategorySelected: (category) => _onCategorySelected(context, category),
          );
        }

        return SourceCategories(isDark: isDark, category: selectedCategory!);
      },
    );
  }


  void _onCategorySelected(BuildContext context, CategoryModel category) {
    setState(() => selectedCategory = category);
    context.read<HomeCubit>().getSources(category.id);
  }

}



import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:newsapp/core/cubits/theme_cubit.dart';
import 'package:newsapp/core/utiles/app_colors.dart';
import 'package:newsapp/features/home/category_selector.dart';
import 'package:newsapp/features/home/source/source_categories.dart';
import 'package:newsapp/features/home/widgets/drawer_widget.dart';
import 'package:newsapp/models/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeCubit>().isDarkMode();

    return LoaderOverlay(
      child: Scaffold(
        drawer: Drawer(child: DrawerWidget( onGoHome: goHome, )),
        appBar: AppBar(
          title: Text(
            //name of the category selected
            selectedCategory?.title ?? "Home".tr(),

            style: GoogleFonts.inter(
              fontSize: 20.sp,
              color: isDark ? AppColors.whiteColor : AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            ImageIcon(AssetImage("assets/images/searchIcon.png")),
            Gap(16.w),
          ],
        ),

        body: selectedCategory == null
            ? CategorySelector(
          onCategorySelected: (category) {
            setState(() {
              selectedCategory = category; // now it switches to sources
            });
          },
        )
            : SourceCategories(isDark: isDark, category: selectedCategory!,),
       ),
    );
  }
  CategoryModel?selectedCategory;

  void goHome() {
    setState(() {
      selectedCategory = null; /// this will show the CategorySelector again
    });
  }

}

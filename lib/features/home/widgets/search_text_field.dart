import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utiles/app_assets.dart';
import '../../../core/utiles/app_colors.dart';
import '../bloc/home_cubit.dart';

class SearchTextField extends StatelessWidget {
  final bool isDark;
  final TextEditingController searchController;
  final VoidCallback onClose;

  const SearchTextField({
    super.key,
    required this.isDark,
    required this.searchController,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: isDark ? AppColors.black : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.whiteColor : AppColors.black,
          width: 1,
        ),
      ),
      child: TextField(
        controller: searchController,
        autofocus: true,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
          hintText: "Search".tr(),

          /// Prefix Icon
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.w),
            child: ImageIcon(
              AssetImage(AppAssets.searchIcon),
              color: isDark ? Colors.white : Colors.black,
              size: 22.sp,
            ),
          ),

          /// Close Icon
          suffixIcon: IconButton(
            icon: Icon(
              Icons.close,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: onClose,
          ),

          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          hintStyle: TextStyle(
            fontSize: 16.sp,
            color: isDark ? Colors.white54 : Colors.black54,
          ),
        ),

        /// Search Logic
        onChanged: (query) {
          if (query.length > 2) {
            context.read<HomeCubit>().searchNews(query);
          }
        },

        onSubmitted: (query) {
          context.read<HomeCubit>().searchNews(query);
        },
      ),
    );
  }
}

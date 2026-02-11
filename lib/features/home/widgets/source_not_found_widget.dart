
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utiles/app_colors.dart';
import '../../../models/category.dart';
import '../bloc/home_cubit.dart';

class SourceNotFoudWidget extends StatelessWidget {
  const SourceNotFoudWidget({
    super.key,
    required this.isDark,
    required this.bloc,
    required this.category,
  });

  final bool isDark;
  final HomeCubit bloc;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.source_outlined,
            size: 80.sp,
            color: isDark ? Colors.white24 : Colors.black12,
          ),
          Gap(16.h),
          Text(
            "No Sources Found".tr(),
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.whiteColor : AppColors.black,
            ),
          ),
          Gap(8.h),
          Text(
            "Check your connection or try again later.".tr(),
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: isDark ? Colors.white54 : Colors.black54,
            ),
          ),
          Gap(24.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? AppColors.whiteColor : AppColors.black,
              foregroundColor: isDark ? AppColors.black : AppColors.whiteColor,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
            ),
            onPressed: () => bloc.getSources(category.id),
            child: Text("Try Again".tr()),
          ),
        ],
      ),
    );
  }
}

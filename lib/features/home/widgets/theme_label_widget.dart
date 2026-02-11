import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/utiles/app_assets.dart';
import '../../../core/utiles/app_colors.dart';

class ThemeLabel extends StatelessWidget {
  const ThemeLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          ImageIcon(
            const AssetImage(AppAssets.themeIcon),
            color: AppColors.whiteColor,
          ),
          Gap(8.w),
          Text(
            'theme'.tr(),
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}

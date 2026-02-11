import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsApp/core/utiles/app_assets.dart';
import 'package:newsApp/core/utiles/app_colors.dart';
import 'package:newsApp/features/home/widgets/theme_drop_down.dart';
import 'package:newsApp/features/home/widgets/theme_label_widget.dart';

import 'custom_divider.dart';
import 'lang_drop_down.dart';
import 'language_label_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.onGoHome});

  final VoidCallback onGoHome;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF171717),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            /// Drawer Header
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.whiteColor),
              child: Center(
                child: Text(
                  'news_app'.tr(),
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            /// Go To Home
            ListTile(
              leading: ImageIcon(
                const AssetImage(AppAssets.homeIcon),
                color: AppColors.whiteColor,
              ),
              title: Text(
                'go_home'.tr(),
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              onTap: () {
                Navigator.pop(context);
                /// go to category selector view
                onGoHome();

              },
            ),
            CustomDivider(),


            /// Theme Section
            ThemeLabel(),
            ThemeDropDown(),

            SizedBox(height: 16.h),
            CustomDivider(),

            /// Language Section
            Language_label(),
            LanguageDropDown(),
          ],
        ),
      ),
    );
  }
}



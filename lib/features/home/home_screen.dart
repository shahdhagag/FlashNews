import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/cubits/theme_cubit.dart';
import 'package:newsapp/features/home/source/source_categories.dart';
import 'package:newsapp/features/home/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeCubit>().isDarkMode();

    return Scaffold(
      drawer: Drawer(child: DrawerWidget()),

      body: SourceCategories(isDark: isDark),
    );
  }
}

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     bool isDark = context.watch<ThemeCubit>().isDarkMode();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Home".tr(),
//           style: GoogleFonts.inter(
//             fontSize: 20,
//             color: isDark ? AppColors.whiteColor : AppColors.black,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         actions: [
//           ImageIcon(AssetImage("assets/images/searchIcon.png")),
//           Gap(16),
//         ],
//       ),
//       drawer: Drawer(child: DrawerWidget()),
//       body:
//       //CategorySelector(),
//       SourceCategories()
//     );
//   }
// }

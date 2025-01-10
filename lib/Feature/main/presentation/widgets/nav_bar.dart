import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:up_todo/Feature/Home/presentation/screens/home_screen.dart';
import 'package:up_todo/Feature/Profile/presentation/screens/profile_screen.dart';
import 'package:up_todo/Feature/main/presentation/widgets/bottom_sheet.dart';

class PresBottomnav extends StatefulWidget {
  const PresBottomnav({super.key});

  @override
  State<PresBottomnav> createState() => _PresBottomnavState();
}

class _PresBottomnavState extends State<PresBottomnav> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void _showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: const Color(0xff363636),
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => AddTaskBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);

    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: PersistentTabView(
              context,
              controller: _controller,
              screens: const [
                HomeScreen(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                ProfileScreen(),
              ],
              items: [
                PersistentBottomNavBarItem(
                  icon: const Icon(CupertinoIcons.home),
                  title: "Index",
                  textStyle: TextStyle(
                    fontSize: 12.sp,
                    height: 1.5.h,
                  ),
                  activeColorPrimary: Colors.white,
                  inactiveColorPrimary: Colors.white.withOpacity(0.60),
                ),
                PersistentBottomNavBarItem(
                  icon: const Icon(CupertinoIcons.calendar),
                  title: "Calendar",
                  textStyle: TextStyle(
                    fontSize: 12.sp,
                    height: 1.5.h,
                  ),
                  activeColorPrimary: Colors.white,
                  inactiveColorPrimary: Colors.white.withOpacity(0.60),
                ),
                PersistentBottomNavBarItem(
                  icon: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                  activeColorPrimary: const Color(0xff8687E7),
                  inactiveColorPrimary: const Color(0xff8687E7),
                  onPressed: (context) {
                    _showBottomSheet();
                  },
                ),
                PersistentBottomNavBarItem(
                  icon: const Icon(CupertinoIcons.timer),
                  title: "Focus",
                  textStyle: TextStyle(
                    fontSize: 12.sp,
                    height: 1.5.h,
                  ),
                  activeColorPrimary: Colors.white,
                  inactiveColorPrimary: Colors.white.withOpacity(0.60),
                ),
                PersistentBottomNavBarItem(
                  icon: const Icon(CupertinoIcons.profile_circled),
                  title: "Profile",
                  textStyle: TextStyle(
                    fontSize: 12.sp,
                    height: 1.5.h,
                  ),
                  activeColorPrimary: Colors.white,
                  inactiveColorPrimary: Colors.white.withOpacity(0.60),
                ),
              ],
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: false,
              stateManagement: true,
              hideNavigationBarWhenKeyboardAppears: true,
              backgroundColor: const Color(0xff363636),
              navBarHeight: 80.0,
              isVisible: true,
              padding: const EdgeInsets.only(top: 8.0),
              animationSettings: const NavBarAnimationSettings(),
              confineToSafeArea: true,
              navBarStyle: NavBarStyle.style15,
            ),
          ),
        ],
      ),
    );
  }
}

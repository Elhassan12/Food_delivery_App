import 'package:ecommerce_app/auth/sign_up_page/sign_up_page.dart';
import 'package:ecommerce_app/pages/account/account_page.dart';
import 'package:ecommerce_app/pages/history_screen/history_screen.dart';
import 'package:ecommerce_app/pages/home_page/main_food_page.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index =0;
  late PersistentTabController _controller;

  List<Widget> pages=[
    MainFoodPage(),
    Container(child: Center(child: Text('Scecond Page')),),
    Container(child: Center(child: Text('Third Page')),),
    Container(child: Center(child: Text('Fourth Page')),),
  ];

  List<BottomNavigationBarItem> navItems=[
    BottomNavigationBarItem(icon:Icon(Icons.home_outlined),label: "Home"),
    BottomNavigationBarItem(icon:Icon(Icons.archive_outlined),label: "History"),
    BottomNavigationBarItem(icon:Icon(Icons.shopping_cart_outlined),label: "Cart"),
    BottomNavigationBarItem(icon:Icon(Icons.person),label: "me"),
  ];

  void onTapNav(int ind)
  {
    setState(() {
      index=ind;
    });
  }
  @override
  void initState()
  {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);

  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: pages[index],
  //     bottomNavigationBar: BottomNavigationBar(
  //       items: navItems,
  //       selectedItemColor: AppColors.mainColor,
  //       unselectedItemColor: Colors.amberAccent,
  //       showSelectedLabels: false,
  //       showUnselectedLabels: false,
  //       onTap:onTapNav,
  //       currentIndex: index,
  //     ),
  //   );
  // }
  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
     SignUpScreen(),
      HistoryScreen(),
      Account(),
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.archive_outlined),
        title: ("Archive"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart_outlined),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Me"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }



  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }



}

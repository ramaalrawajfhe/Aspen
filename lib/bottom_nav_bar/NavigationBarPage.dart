import 'package:aspen/bottom_nav_bar/bttom_nav_bar_screen.dart';
import 'package:aspen/screens/explore/explore_tab.dart';
import 'package:aspen/utils/ui/search_widget.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavigationBarPage extends StatefulWidget{
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPage();
}
class _NavigationBarPage extends State<NavigationBarPage> {
   int index = 0;
   final List<TabModel> _tabs=[
     TabModel(view:const ExploreTab()),
     TabModel(view:Container()),
     TabModel(view:Container()),
     TabModel(view:Container()
     )
   ];

   @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: _persistentTabBar()
     );
   }
   Widget _persistentTabBar() {
     return PersistentTabView(
       context,
       screens: _tabs.map((e) => e.view).toList(),
       navBarHeight: 100,
       confineInSafeArea: true,
       navBarStyle: NavBarStyle.style6,
       items:[
         persistentBottomNavBarItem(
             icon: const Icon(Icons.home),
             activeColorPrimary:
             index == 0 ? const Color(0xFF2196F3) : const Color(0x61000000)),
         persistentBottomNavBarItem(
             icon: const Icon(Icons.airplane_ticket),
             activeColorPrimary:
             index == 1 ? const Color(0xFF2196F3) : const Color(0x61000000)),
         persistentBottomNavBarItem(
             icon: const Icon(Icons.favorite),
             activeColorPrimary:
             index == 2 ? const Color(0xFF2196F3) : const Color(0x61000000)),
         persistentBottomNavBarItem(
             icon: const Icon(Icons.person),
             activeColorPrimary:
             index == 3 ? const Color(0xFF2196F3) : const Color(0x61000000)),
       ],
       popActionScreens: PopActionScreensType.all,
       popAllScreensOnTapOfSelectedTab: true,
       handleAndroidBackButtonPress: true,
       resizeToAvoidBottomInset: true,
       onItemSelected: (value) {
         index = value;
         if(mounted) setState(() {});
       },
       stateManagement: true,
       hideNavigationBarWhenKeyboardShows: true,
       popAllScreensOnTapAnyTabs: false,
     );
   }
}
class TabModel {
  Widget ? icon;
  Widget view;
  TabModel({required this.view, this.icon});
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_app/constants/app_colors.dart';
import 'package:test_task_app/constants/app_string.dart';
import 'package:test_task_app/injection_container.dart';
import 'package:test_task_app/screens/home/fragments/characters_data_inherited.dart';
import 'package:test_task_app/screens/home/fragments/home/home_page.dart';
import 'package:test_task_app/screens/home/fragments/home/home_vm.dart';
import 'package:test_task_app/screens/home/fragments/list/list_page.dart';
import 'package:test_task_app/screens/home/fragments/list/list_vm.dart';

class BottomTabBarPage extends StatefulWidget {
  final int? initialTabIndex;
  const BottomTabBarPage({super.key, this.initialTabIndex});

  @override
  State<BottomTabBarPage> createState() => _BottomTabBarPageState();
}

class _BottomTabBarPageState extends State<BottomTabBarPage> with SingleTickerProviderStateMixin {
  late int _currentPageIndex;
  late TabController _tabController;
  late List<Widget> _tabs;
  late int characterIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = widget.initialTabIndex ?? 0;
    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: _currentPageIndex,
    );

    characterIndex = 0;
    _tabs = _getPages();
  }

  @override
  Widget build(BuildContext context) {
    return CharactersData(
      indexContainer: {'index': characterIndex},
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: _tabs,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          selectedItemColor: AppColors.blue100,
          currentIndex: _currentPageIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppString.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: AppString.list,
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
      _tabController.animateTo(index);
    });
  }

  List<Widget> _getPages() {
    return [
      ChangeNotifierProvider(
        create: (context) => serviceLocator.get<HomeVM>(),
        child: HomePage(tabController: _tabController),
      ),
      ChangeNotifierProvider(
        create: (context) => serviceLocator.get<ListVM>(),
        child: ListPage(tabController: _tabController),
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

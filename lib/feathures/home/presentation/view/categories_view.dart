import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/home/presentation/widget/dashboard_list.dart';

//experiment with this later,
//https://medium.com/@sksnehalkale27/hide-or-show-app-bar-and-bottom-navigation-bar-while-scrolling-in-flutter-405d23fc92dc

class CategoryView extends ConsumerStatefulWidget {
  final int initialTabIndex;

  const CategoryView({super.key, required this.initialTabIndex});

  @override
  CategoryScreenState createState() => CategoryScreenState();
}

class CategoryScreenState extends ConsumerState<CategoryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabTitles = [
    'Gainers',
    'Loosers',
    'Turnover',
    'Volume',
    'Transaction',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        title: Text(
          tabTitles[_tabController.index],
          //  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          physics: const BouncingScrollPhysics(),
          isScrollable: true,
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          tabs: [
            Tab(
              child: Row(
                children: [
                  const Icon(Icons.rocket_launch_outlined),
                  const SizedBox(width: 8),
                  Text(tabTitles[0]),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  const Icon(Icons.downhill_skiing_outlined),
                  const SizedBox(width: 8),
                  Text(tabTitles[1]),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  const Icon(Icons.money_outlined),
                  const SizedBox(width: 8),
                  Text(tabTitles[2]),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  const Icon(Icons.volume_down_outlined),
                  const SizedBox(width: 8),
                  Text(tabTitles[3]),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  const Icon(Icons.money_off_outlined),
                  const SizedBox(width: 8),
                  Text(tabTitles[4]),
                ],
              ),
            ),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DashboardList(listName: "Top Gainers", nameLength: 35),
          DashboardList(listName: "Top Loosers", nameLength: 35),
          DashboardList(listName: "Top Turnover", nameLength: 35),
          DashboardList(listName: "Top Volume", nameLength: 35),
          DashboardList(listName: "Top Transaction", nameLength: 35),
        ],
      ),
    );
  }
}

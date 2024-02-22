import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/home/presentation/widget/worldmarket_list.dart';

//experiment with this later,
//https://medium.com/@sksnehalkale27/hide-or-show-app-bar-and-bottom-navigation-bar-while-scrolling-in-flutter-405d23fc92dc

class WorldMarketsView extends ConsumerStatefulWidget {
  final int initialTabIndex;

  const WorldMarketsView({super.key, required this.initialTabIndex});

  @override
  WorldScreenState createState() => WorldScreenState();
}

class WorldScreenState extends ConsumerState<WorldMarketsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabTitles = [
    'American Market',
    'Europe Market',
    'Asian Market',
    'Forex Market',
    'Crypto Market',
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
        // centerTitle: true,
        // elevation: 0,
        // automaticallyImplyLeading: true,
        // backgroundColor: AppColors.primaryColor,
        // iconTheme: const IconThemeData(color: Colors.black),
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          tabs: [
            Tab(
              child: Row(
                children: [
                  Text(tabTitles[0]),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  Text(tabTitles[1]),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  Text(tabTitles[2]),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  Text(tabTitles[3]),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
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
          WorldMarketList(listName: "American Market"),
          WorldMarketList(listName: "Europe Market"),
          WorldMarketList(listName: "Asian Market"),
          WorldMarketList(listName: "Forex Market"),
          WorldMarketList(listName: "Crypto Market"),
        ],
      ),
    );
  }
}

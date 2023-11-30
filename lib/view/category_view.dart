// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:paisa/app/common/dashboard_list.dart';
import 'package:paisa/app/common/drawer_common.dart';
import 'package:paisa/model/asset_model.dart';
import 'package:paisa/utils/colors_utils.dart';

class CategoryView extends StatefulWidget {
  final BuildContext context;
  final List<Asset> assetList;
  final List<Asset>? gainerList;
  final List<Asset>? looserList;
  final List<Asset>? turnoverList;
  final List<Asset>? volumeList;
  final dynamic firstitem;
  final dynamic seconditem;
  final dynamic thirditem;
  final dynamic arrow;
  final dynamic utils;
  final dynamic type;
  final int initialTabIndex;

  const CategoryView({
    super.key,
    required this.context,
    required this.firstitem,
    required this.seconditem,
    required this.thirditem,
    required this.assetList,
    this.gainerList,
    this.looserList,
    this.turnoverList,
    this.volumeList,
    this.arrow,
    this.utils,
    this.type,
    this.initialTabIndex = 0,
  });

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.initialTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top Category',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: MyColors.btnColor,
        iconTheme: const IconThemeData(color: Colors.black),
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
          tabs: const [
            Tab(text: 'Gainer'),
            Tab(text: 'Looser'),
            Tab(text: 'Turnover'),
            Tab(text: 'Volume'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Content for 'Top Gainer' tab
          DashboardList(
            context: context,
            assetList: const [],
            firstitem: widget.firstitem,
            seconditem: widget.seconditem,
            thirditem: widget.thirditem,
            trendingList: widget.gainerList,
            utils: widget.utils,
            type: widget.type,
          ),
          // Content for 'Top Looser' tab
          DashboardList(
            context: context,
            assetList: const [],
            firstitem: widget.firstitem,
            seconditem: widget.seconditem,
            thirditem: widget.thirditem,
            trendingList: widget.looserList,
            utils: widget.utils,
            type: widget.type,
          ),
          // Content for 'Top Turnover' tab
          DashboardList(
            context: context,
            assetList: widget.assetList,
            firstitem: widget.firstitem,
            seconditem: widget.seconditem,
            thirditem: widget.thirditem,
            trendingList: widget.turnoverList,
            type: widget.type,
          ),
          // Content for 'Top Volume' tab
          DashboardList(
            context: context,
            assetList: widget.assetList,
            firstitem: widget.firstitem,
            seconditem: widget.seconditem,
            thirditem: widget.thirditem,
            trendingList: widget.volumeList,
            type: widget.type,
          ),
        ],
      ),
      drawer: const CommonDrawer(),
    );
  }
}

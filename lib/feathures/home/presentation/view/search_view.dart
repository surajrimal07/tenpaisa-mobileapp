// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/loading_indicator.dart';
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';
import 'package:paisa/feathures/home/domain/entity/metals_entity.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/commodity_view_model.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/metals_viewmodel.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/stock_view_model.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends ConsumerState<SearchView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 12, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchController = ref.watch(searchControllerProvider);
    final color = AppTheme.isDarkMode(context)
        ? AppColors.greyPrimaryColor
        : AppColors.darktextColor;
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? Container(
                width: double.infinity,
                height: 39,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: SearchStrings.search,
                      hintStyle: TextStyle(fontSize: 14),
                      border: InputBorder.none),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              )
            : Row(
                children: [
                  SizedBox(width: Sizes.dynamicWidth(35)),
                  const Text('Assets'),
                ],
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                searchController.clear();
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
        bottom: _buildTabBar(),
      ),
      body: _buildTabBarView(searchController),
    );
  }

  PreferredSizeWidget _buildTabBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight - 14),
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        isScrollable: true,
        controller: _tabController,
        indicatorWeight: 2,
        tabs: _buildTabList(),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
      ),
    );
  }

  List<Widget> _buildTabList() {
    return SearchStrings.searchtabs.map((title) => Tab(text: title)).toList();
  }

  Widget _buildTabBarView(searchController) {
    return TabBarView(
      controller: _tabController,
      children: _buildTabViewList(searchController),
    );
  }

  List<Widget> _buildTabViewList(searchController) {
    final stockViewModel = ref.watch(stockViewModelProvider.notifier).state;
    final commodityViewModel =
        ref.watch(commodityViewModelProvider.notifier).state;
    final metalsViewModel = ref.watch(metalsViewModelProvider.notifier).state;

    return [
      _buildStockListView(stockViewModel.stocks,
          ref.watch(stockViewModelProvider), searchController),
      _buildCommodityListView(commodityViewModel.commodity,
          ref.watch(commodityViewModelProvider), searchController),
      _buildMetalsListView(metalsViewModel.metals,
          ref.watch(metalsViewModelProvider), searchController),
      for (var sector in SearchStrings.sectors)
        _buildStockListView(stockViewModel.stocks.shortBySector(sector),
            ref.watch(stockViewModelProvider), searchController),
      for (var category in SearchStrings.categories)
        _buildStockListView(stockViewModel.stocks.shortByCategories(category),
            ref.watch(stockViewModelProvider), searchController),
    ];
  }

  Widget _buildCommodityListView(
      List<CommodityEntity> commodities, statecommodity, searchController) {
    final filteredCommodities = commodities
        .where((commodity) => commodity.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();

    return statecommodity.isLoading
        ? const Center(
            child: LoadingIndicatorWidget(
              size: 40,
              showText: true,
              text: LoadingText.loading,
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: filteredCommodities.length,
            itemExtent: 75,
            cacheExtent: 2000,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 0,
                    ),
                    title: Text(
                      filteredCommodities[index].name,
                      style: GoogleFonts.poppins(),
                    ),
                    subtitle: Text(
                      filteredCommodities[index].category,
                      style: GoogleFonts.poppins(),
                    ),
                    trailing: Text(
                      'Rs ${filteredCommodities[index].ltp.toString()}',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColors.primaryColor,
                    height: 0.3,
                    thickness: 0.3,
                  ),
                ],
              );
            },
          );
  }

  Widget _buildMetalsListView(
      List<MetalsEnity> metals, statemetals, searchController) {
    final filteredMetals = metals
        .where((metal) => metal.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();

    return statemetals.isLoading
        ? const Center(
            child: LoadingIndicatorWidget(
              size: 40,
              showText: true,
              text: LoadingText.loading,
            ),
          )
        : ListView.builder(
            cacheExtent: 2000,
            padding: const EdgeInsets.all(0),
            itemCount: filteredMetals.length,
            itemExtent: 73,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 0,
                    ),
                    title: Text(
                      filteredMetals[index].name,
                      style: GoogleFonts.poppins(),
                    ),
                    subtitle: Text(
                      filteredMetals[index].category,
                      style: GoogleFonts.poppins(),
                    ),
                    trailing: Text(
                      'Rs ${filteredMetals[index].ltp.toString()}',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColors.primaryColor,
                    height: 0.3,
                    thickness: 0.3,
                  ),
                ],
              );
            },
          );
  }

  String shortenName(String name) {
    if (name.length <= 25) {
      return name;
    } else {
      return '${name.substring(0, 25)}...';
    }
  }

  Widget _buildStockListView(
      List<StockEntity> stocks, stateasset, searchController) {
    final filteredStocks = stocks
        .where((stock) =>
            stock.name
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            stock.symbol
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
        .toList();

    return stateasset.isLoading
        ? const Center(
            child: LoadingIndicatorWidget(
              size: 40,
              showText: true,
              text: LoadingText.loading,
            ),
          )
        : ListView.builder(
            itemCount: filteredStocks.length,
            cacheExtent: 2000,
            itemExtent: 75,
            itemBuilder: (context, index) {
              return _buildStockListItem(filteredStocks[index]);
            },
          );
  }

  Widget _buildStockListItem(StockEntity stock) {
    return Column(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                shortenName(stock.name),
                style: GoogleFonts.poppins(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Rs ${stock.ltp}',
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stock.sector,
                style: GoogleFonts.poppins(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildArrowAndPercentage(
                      stock.percentChange, stock.pointChange),
                ],
              ),
            ],
          ),
          onTap: () {
            ref.read(navigationServiceProvider).routeTo(
              '/assetview',
              arguments: {'stockEntity': stock},
            );
          },
        ),
        const Divider(
          color: AppColors.primaryColor,
          height: 0.3,
          thickness: 0.3,
        ),
      ],
    );
  }

  Widget _buildArrowAndPercentage(dynamic percentChange, pointChange) {
    IconData arrowIcon = Icons.arrow_upward;
    Color arrowColor = Colors.green;

    if (percentChange < 0) {
      arrowIcon = Icons.arrow_downward;
      arrowColor = Colors.red;
    }

    return Row(
      children: [
        Icon(
          arrowIcon,
          color: arrowColor,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          '${percentChange.toString()}%',
          style: GoogleFonts.poppins(
            color: arrowColor,
            fontSize: 15,
          ),
        ),
        Text(
          ' (${pointChange.toStringAsFixed(1)})',
          style: GoogleFonts.poppins(
            color: arrowColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

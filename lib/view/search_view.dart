import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../model/asset_model.dart';
import '../services/asset_services.dart';
import '../view/asset_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  int indexBottomBar = 1;
  int currentPageIndex = 0;
  //final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController _searchController = TextEditingController();
  //final _currentPageNotifier = ValueNotifier<int>(0);

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<List<Asset>> fetchData() async {
    try {
      List<Map<String, dynamic>> fetchedSymbolMaps =
          await AssetService.getassets("allwithdata");

      List<Asset> fetchedSymbols = fetchedSymbolMaps
          .map((map) => Asset(
                symbol: map['symbol'],
                name: map['name'],
                category: map['category'],
                sector: map['sector'],
                eps: map['eps'],
                bookvalue: map['bookvalue'],
                pe: map['pe'],
                ltp: map['ltp'] is double ? map['ltp'].toString() : map['ltp'],
                percentchange: map['percentchange'],
                totaltradedquantity: map['totaltradedquantity'],
                previousclose: map['previousclose'],
              ))
          .toList();

      fetchedSymbols.sort((a, b) => a.name.compareTo(b.name));

      return fetchedSymbols;
    } catch (error) {
      CustomToast.showToast("asset data error");
      rethrow;
    }
  }

  Future<List<Asset>> fetchCommodityData() async {
    try {
      List<Map<String, dynamic>> fetchedCommodityMaps =
          await AssetService.getcommodity();

      List<Asset> fetchedCommodities = fetchedCommodityMaps
          .map((map) => Asset(
                symbol: map['symbol'] ?? '',
                name: map['name'] ?? '',
                category: map['category'],
                sector: map['category'],
                eps: map['eps'],
                bookvalue: map['bookvalue'],
                pe: map['pe'],
                percentchange: map['percentchange'],
                ltp: (map['ltp'] is int) ? map['ltp'].toString() : map['ltp'],
                totaltradedquantity: map['totaltradedquantity'],
                previousclose: map['previousclose'],
              ))
          .toList();

      fetchedCommodities.sort((a, b) => a.name.compareTo(b.name));

      return fetchedCommodities;
    } catch (error) {
      CustomToast.showToast("commodity data error");
      rethrow;
    }
  }

  void _onAssetTapped(Asset asset, comopage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AssetView(assetData: asset, fromCommodityPage: comopage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        backgroundColor: MyColors.btnColor,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              _searchController.clear();
              setState(() {});
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Stocks'),
            Tab(text: 'Commodities'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Asset data
          FutureBuilder<List<Asset>>(
            future: fetchData(),
            builder: (context, assetSnapshot) {
              if (assetSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitCircle(
                    color: MyColors.btnColor,
                    size: 25.0,
                  ),
                );
              } else if (assetSnapshot.hasError) {
                return Center(
                  child: Text('Error: ${assetSnapshot.error}'),
                );
              } else if (assetSnapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: assetSnapshot.data!.length,
                  itemBuilder: (context, index) {
                    String name = assetSnapshot.data![index].name;
                    String sector = assetSnapshot.data![index].sector ?? '';
                    String ltp = assetSnapshot.data![index].ltp ?? '';

                    bool matchesSearch = name
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase()) ||
                        assetSnapshot.data![index].symbol
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase());

                    return matchesSearch
                        ? Column(
                            children: [
                              ListTile(
                                title: Text(
                                  name,
                                  style: GoogleFonts.poppins(),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sector,
                                          style: GoogleFonts.poppins(),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Rs $ltp',
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ],
                                    ),
                                    _buildArrowAndPercentage(assetSnapshot
                                        .data![index].percentchange),
                                  ],
                                ),
                                onTap: () {
                                  _onAssetTapped(
                                      assetSnapshot.data![index], false);
                                },
                              ),
                              const Divider(
                                color: MyColors.btnColor,
                                height: 0.3,
                                thickness: 0.3,
                              ),
                            ],
                          )
                        : Container();
                  },
                );
              } else {
                return Container();
              }
            },
          ),

          // Commodity data
          FutureBuilder<List<Asset>>(
            future: fetchCommodityData(),
            builder: (context, commoditySnapshot) {
              if (commoditySnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: SpinKitCircle(
                    color: MyColors.btnColor,
                    size: 50.0,
                  ),
                );
              } else if (commoditySnapshot.hasError) {
                return Center(
                  child: Text('Error: ${commoditySnapshot.error}'),
                );
              } else if (commoditySnapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: commoditySnapshot.data!.length,
                  itemBuilder: (context, index) {
                    String name = commoditySnapshot.data![index].name;
                    String sector = commoditySnapshot.data![index].sector ?? '';
                    String ltp = commoditySnapshot.data![index].ltp ?? '';

                    bool matchesSearch = name
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase()) ||
                        commoditySnapshot.data![index].symbol
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase());

                    return matchesSearch
                        ? Column(
                            children: [
                              ListTile(
                                title: Text(
                                  name,
                                  style: GoogleFonts.poppins(),
                                ),
                                subtitle: Text(
                                  sector,
                                  style: GoogleFonts.poppins(),
                                ),
                                trailing: Text(
                                  'Rs $ltp',
                                  style: GoogleFonts.poppins(),
                                ),
                                onTap: () {
                                  _onAssetTapped(
                                      commoditySnapshot.data![index], true);
                                },
                              ),
                              const Divider(
                                color: MyColors.btnColor,
                                height: 0.3,
                                thickness: 0.3,
                              ),
                            ],
                          )
                        : Container();
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: MyColors.btnColor,
        currentIndex: indexBottomBar,
        onTap: (i) {
          if (i == 1) {
            setState(() => indexBottomBar = i);
          } else if (i == 0) {
            Navigator.pushNamed(context, AppRoute.dashboardRoute);
          } else if (i == 4) {
            Navigator.pushNamed(context, AppRoute.profileRoute);
          } else if (i == 1) {
            Navigator.pushNamed(context, AppRoute.searchRoute);
          } else if (i == 3) {
            Navigator.pushNamed(context, AppRoute.walletRoute);
          } else if (i == 2) {
            Navigator.pushNamed(context, AppRoute.portRoute);
          } else {
            setState(() => indexBottomBar = i);
          }
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.home),
            title: const Text("Home"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.global_search),
            title: const Text("Search"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.document),
            title: const Text("Portfolio"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.wallet_1),
            title: const Text("Wallet"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.profile_circle),
            title: const Text("Profile"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
        ],
      ),
    );
  }
}

Widget _buildArrowAndPercentage(dynamic percentChange) {
  double change = double.tryParse(percentChange.toString()) ?? 0.0;

  IconData arrowIcon = Icons.arrow_upward;
  Color arrowColor = Colors.green;

  if (change < 0) {
    arrowIcon = Icons.arrow_downward;
    arrowColor = Colors.red;
  }

  String formattedChange = change.toStringAsFixed(1);

  return Row(
    children: [
      Icon(
        arrowIcon,
        color: arrowColor,
        size: 16,
      ),
      const SizedBox(width: 4),
      Text(
        '$formattedChange%',
        style: GoogleFonts.poppins(
          color: arrowColor,
          fontSize: 13,
        ),
      ),
    ],
  );
}

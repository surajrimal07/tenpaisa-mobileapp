import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:paisa/app/routes/approutes.dart';
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

class _SearchScreenState extends State<SearchView> {
  int indexBottomBar = 1;
  int currentPageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  List<Asset> symbols = [];
  List<dynamic> commodityData = []; // for commodity
  final TextEditingController _searchController = TextEditingController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchCommodityData(); //fetch commodity data from this
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.btnColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: MyColors.btnColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  Future<void> fetchData() async {
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
                ltp: map['ltp'] is double
                    ? map['ltp'].toString()
                    : map['ltp'], //map['ltp'],
                percentchange: map['percentchange'],
                totaltradedquantity: map['totaltradedquantity'],
                previousclose: map['previousclose'],
              ))
          .toList();

      fetchedSymbols.sort((a, b) => a.name.compareTo(b.name));

      setState(() {
        symbols = fetchedSymbols;
      });
    } catch (error) {
      print('Error fetching symbols: $error');
    }
  }

  Future<void> fetchCommodityData() async {
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

      setState(() {
        commodityData = fetchedCommodities;
      });
    } catch (error) {
      print('Error fetching commodity data: $error');
    }
  }

  void _onAssetTapped(Asset asset) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssetView(assetData: asset),
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
              hintText: 'Search Assets',
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
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
                _currentPageNotifier.value = index;
              });
            },
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: symbols.length,
                itemBuilder: (context, index) {
                  bool matchesSearch = symbols[index]
                          .name
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()) ||
                      symbols[index]
                          .symbol
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase());

                  return matchesSearch
                      ? ListTile(
                          title: Text(
                            symbols[index].name,
                            style: GoogleFonts.poppins(),
                          ),
                          subtitle: Text(
                            symbols[index].sector ?? "",
                            style: GoogleFonts.poppins(),
                          ),
                          trailing: Text(
                            'Rs ${symbols[index].ltp ?? ''}',
                            style: GoogleFonts.poppins(),
                          ),
                          onTap: () {
                            _onAssetTapped(symbols[index]);
                          },
                        )
                      : Container();
                },
              ),
              // Commodity data page
              // ListView.builder(
              //   padding: const EdgeInsets.all(16),
              //   itemCount: commodityData.length,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       title: Text(
              //         commodityData[index].name,
              //         style: GoogleFonts.poppins(),
              //       ),
              //       subtitle: Text(
              //         commodityData[index].sector ?? "",
              //         style: GoogleFonts.poppins(),
              //       ),
              //       trailing: Text(
              //         'Rs ${commodityData[index].ltp ?? ''}',
              //         style: GoogleFonts.poppins(),
              //       ),
              //       onTap: () {
              //         // Handle commodity item tap
              //         // ...
              //       },
              //     );
              //   },
              // ),
              // Inside the itemBuilder for commodityData
              ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: commodityData.length,
                itemBuilder: (context, index) {
                  bool matchesSearch = commodityData[index]
                          .name
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()) ||
                      commodityData[index]
                          .symbol
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase());

                  return matchesSearch
                      ? ListTile(
                          title: Text(
                            commodityData[index].name,
                            style: GoogleFonts.poppins(),
                          ),
                          subtitle: Text(
                            commodityData[index].sector ?? "",
                            style: GoogleFonts.poppins(),
                          ),
                          trailing: Text(
                            'Rs ${commodityData[index].ltp ?? ''}',
                            style: GoogleFonts.poppins(),
                          ),
                          onTap: () {
                            // Handle commodity item tap
                            // ...
                          },
                        )
                      : Container();
                },
              ),
            ],
          ),
          Positioned(
            bottom: 10.0,
            left: 0.0,
            right: 0.0,
            child: CirclePageIndicator(
              dotColor: Colors.grey,
              selectedDotColor: MyColors.btnColor,
              itemCount: 2,
              currentPageNotifier: _currentPageNotifier,
            ),
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

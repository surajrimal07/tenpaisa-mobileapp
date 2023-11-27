import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:paisa/app/common/asset_list.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/data/portfolio_data.dart';
import 'package:paisa/model/asset_model.dart';
import 'package:paisa/services/user_services.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../services/asset_services.dart';
import '../utils/icons_utils.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _MainPageState();
}

class TrendingData {
  final List<Asset> topFive;
  final List<Asset> bottomFive;
  TrendingData(this.topFive, this.bottomFive);
}

class TurnoverData {
  final List<Asset> turnoverData;
  TurnoverData(this.turnoverData);
}

class VolumeData {
  final List<Asset> volumeData;
  VolumeData(this.volumeData);
}

class CommoData {
  final List<Asset> commoData;
  CommoData(this.commoData);
}

class MetalData {
  final List<Asset> metalData;
  MetalData(this.metalData);
}

Future<TrendingData> fetchTrendingData() async {
  try {
    List<Map<String, dynamic>> fetchedTrendingMaps =
        await AssetService.gettrending();

    List<Asset> fetchedTrending = fetchedTrendingMaps
        .map((map) => Asset(
              symbol: map['symbol'] ?? '',
              name: map['name'] ?? '',
              percentchange: (map['percentageChange'] ?? 0).toString(),
              ltp: (map['ltp'] ?? 0.0).toString(),
            ))
        .toList();

    List<Asset> topFive = fetchedTrending.take(4).toList();

    List<Asset> bottomFive = fetchedTrending
        .skip(fetchedTrending.length - 5)
        .toList()
        .reversed
        .toList();

    return TrendingData(topFive, bottomFive);
  } catch (error) {
    CustomToast.showToast("Trending data error");
    rethrow;
  }
}

Future<TurnoverData> fetchTurnoverData() async {
  try {
    List<Map<String, dynamic>> fetchedTurnoverMaps =
        await AssetService.getturnover();

    List<Asset> fetchedTurnover = fetchedTurnoverMaps
        .map((map) => Asset(
              symbol: map['symbol'] ?? '',
              name: map['name'] ?? '',
              turnover: (map['turnover'] ?? 0.0).toStringAsFixed(0) ?? "",
              ltp: (map['ltp'] ?? 0.0).toString(),
            ))
        .toList();

    List<Asset> topFourTurnover = fetchedTurnover.take(4).toList();

    return TurnoverData(topFourTurnover);
  } catch (error) {
    CustomToast.showToast("Turnover data error");
    rethrow;
  }
}

Future<VolumeData> fetchVolumeData() async {
  try {
    List<Map<String, dynamic>> fetchedVolumeMaps =
        await AssetService.getvolume();

    List<Asset> fetchedVolume = fetchedVolumeMaps
        .map((map) => Asset(
              symbol: map['symbol'] ?? '',
              name: map['name'] ?? '',
              turnover: (map['turnover'] ?? 0.0).toString(),
              ltp: (map['ltp'] ?? 0.0).toString(),
            ))
        .toList();

    List<Asset> topFourVolume = fetchedVolume.take(4).toList();

    return VolumeData(topFourVolume);
  } catch (error) {
    CustomToast.showToast("Volume data error");
    rethrow;
  }
}

Future<CommoData> commData() async {
  try {
    List<Map<String, dynamic>> fetchedTurnoverMaps =
        await AssetService.getcommodity();

    List<Asset> fetchedCommodities = fetchedTurnoverMaps
        .map((map) => Asset(
              symbol: map['name'] ?? '', //no symbol in commodity
              name: map['name'] ?? '',
              category: map['category'],
              unit: map['unit'],
              ltp: (map['ltp'] is int) ? map['ltp'].toString() : map['ltp'],
            ))
        .toList();

    fetchedCommodities.sort((a, b) => a.name.compareTo(b.name));

    return CommoData(fetchedCommodities);
  } catch (error) {
    CustomToast.showToast("Commodity data error");
    rethrow;
  }
}

Future<MetalData> metaData() async {
  try {
    List<Map<String, dynamic>> fetchedTurnoverMaps =
        await AssetService.getMetal();

    List<Asset> fetchedCommodities = fetchedTurnoverMaps
        .map((map) => Asset(
              symbol: map['name'] ?? '', //no symbol in commodity
              name: map['name'] ?? '',
              sector: map['sector'] ?? '',
              category: map['category'],
              unit: map['unit'],
              ltp: (map['ltp'] is int) ? map['ltp'].toString() : map['ltp'],
            ))
        .toList();

    fetchedCommodities.sort((a, b) => a.name.compareTo(b.name));

    return MetalData(fetchedCommodities);
  } catch (error) {
    CustomToast.showToast("Metal data error");
    rethrow;
  }
}

class _MainPageState extends State<DashboardView> {
  int indexBottomBar = 0;
  String currentName = "";
  String currentPass = "";
  String currentEmail = "";
  String currentPhone = "";
  String currentDP = "assets/images/content/default.png";
  final ScrollController _scrollController = ScrollController();
  Color scaffoldBackgroundColor = MyColors.btnColor;
  List<Asset> fetchedSymbols = [];
  final _currentPageNotifier = ValueNotifier<int>(0); //pageview
  final PageController _pageController = PageController(); //pageview
  final _currentPageNotifier1 = ValueNotifier<int>(0); //pageview
  final PageController _pageController1 = PageController(); //pageview
  final _currentPageNotifier2 = ValueNotifier<int>(0); //pageview
  final PageController _pageController2 = PageController(); //pageview

  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TrendingData trendingData = TrendingData([], []);
  TurnoverData turnoverData = TurnoverData([]);
  VolumeData volumeData = VolumeData([]);
  CommoData commoData = CommoData([]);
  MetalData metalData = MetalData([]);

  @override
  void initState() {
    super.initState();
    _loadUserData();
    fetchData();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.btnColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: MyColors.btnColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  // Fetch trending, turnover data
  Future<void> fetchData() async {
    try {
      TrendingData dataa = await fetchTrendingData();
      TurnoverData tdata = await fetchTurnoverData();
      VolumeData vdata = await fetchVolumeData();
      CommoData cdata = await commData();
      MetalData mdata = await metaData();
      List<Asset> symbols = await fetchDatas();
      setState(() {
        trendingData = dataa;
        fetchedSymbols = symbols;
        turnoverData = tdata;
        volumeData = vdata;
        commoData = cdata;
        metalData = mdata;
      });
    } catch (error) {
      CustomToast.showToast("Error occured fetching data");
    }
  }

  Future<List<Asset>> fetchDatas() async {
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

  String getAssetProperty(
      String symbol, List<Asset> assetList, String property) {
    Asset? asset = assetList.firstWhere(
      (element) => element.symbol == symbol,
      orElse: () => Asset(symbol: symbol, name: 'Unknown'),
    );

    switch (property) {
      case 'name':
        List<String> words = asset.name.split(' ');
        return words.length > 2 ? words.sublist(0, 2).join(' ') : asset.name;
      case 'category':
        return asset.category ?? "No Category";
      case 'sector':
        return asset.sector ?? "No Sector";
      case 'eps':
        return asset.eps ?? "0.0";
      case 'bookvalue':
        return asset.bookvalue ?? "0.0";
      case 'pe':
        return asset.pe ?? "";
      case 'percentchange':
        return asset.percentchange ?? "0.0";
      case 'ltp':
        return asset.ltp ?? "0.0";
      case 'unit':
        return asset.unit ?? "0.0";
      case 'totaltradedquantity':
        return asset.totaltradedquantity ?? "0.0";
      case 'previousclose':
        return asset.previousclose ?? "0.0";
      case 'turnover':
        return asset.turnover ?? "0.0";
      default:
        return 'Unknown';
    }
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic>? userData = await UserService.fetchUserData();

    if (userData != null) {
      setState(() {
        currentName = userData['name'];
        currentEmail = userData['email'];
        currentPass = userData['pass'];
        currentPhone = userData['phone'];
        currentDP = userData['dp'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                child: Column(
                  children: [
                    _header(),
                    _card(),
                    _portfolio(),
                    _watchlist(),
                    _trending(),
                    _turnover(),
                    _commodities(),
                    _mySummary()
                  ],
                ),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    margin: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(color: MyColors.btnColor),
                    accountName: Text(currentName),
                    accountEmail: Text(currentEmail),
                    currentAccountPictureSize: const Size(60, 60),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage(currentDP),
                    ),
                  ),
                  ListTile(
                    title: const Text('My Profile'),
                    leading: const Icon(CupertinoIcons.person),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.profileRoute);
                    },
                  ),
                  const ListTile(
                    title: Text('Themes'),
                    leading: Icon(CupertinoIcons.color_filter),
                  ),
                  const ListTile(
                    title: Text('Fonts'),
                    leading: Icon(Icons.font_download_outlined),
                  ),
                  const ListTile(
                    title: Text('Favorites'),
                    leading: Icon(CupertinoIcons.heart),
                  ),
                  const ListTile(
                    title: Text('Settings'),
                    leading: Icon(CupertinoIcons.settings),
                  ),
                  const ListTile(
                    title: Text('Exit'),
                    leading: Icon(Icons.exit_to_app),
                  )
                ],
              ),
            ),
            bottomNavigationBar: SalomonBottomBar(
              backgroundColor: MyColors.btnColor,
              margin: const EdgeInsets.all(6),
              //curve: Curves.bounceIn,
              currentIndex: indexBottomBar,
              onTap: (i) {
                if (i == 4) {
                  Navigator.pushNamed(context, AppRoute.profileRoute);
                } else if (i == 2) {
                  Navigator.pushNamed(context, AppRoute.portRoute);
                } else if (i == 1) {
                  Navigator.pushNamed(context, AppRoute.searchRoute);
                } else if (i == 3) {
                  Navigator.pushNamed(context, AppRoute.walletRoute);
                } else {
                  setState(() => indexBottomBar = i);
                }
              },
              items: [
                /// Home
                SalomonBottomBarItem(
                  icon: const Icon(Iconsax.home),
                  title: const Text("Home"),
                  selectedColor: Colors.white,
                  unselectedColor: Colors.white70,
                ),

                /// Search
                SalomonBottomBarItem(
                  icon: const Icon(Iconsax.global_search),
                  title: const Text("Search"),
                  selectedColor: Colors.white,
                  unselectedColor: Colors.white70,
                ),

                /// Likes
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

                /// Profile
                SalomonBottomBarItem(
                  icon: const Icon(Iconsax.profile_circle),
                  title: const Text("Profile"),
                  selectedColor: Colors.white,
                  unselectedColor: Colors.white70,
                ),
              ],
            )));
  }

//
  Container _trending() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black,
          width: 0.1,
        ),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentPageNotifier.value == 0 ? 'Top Gainers' : 'Top Loosers',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: GoogleFonts.poppins(
                    color: MyColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 300,
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPageNotifier.value = index;
                });
              },
              children: [
                //   AssetList(
                //   assetList: const [],
                //   firstitem: "name",
                //   seconditem: "ltp",
                //   thirditem: "percentchange",
                //   trendingList: trendingData.topFive,
                // ),
                // AssetList(
                //   assetList: const [],
                //   firstitem: "name",
                //   seconditem: "ltp",
                //   thirditem: "percentchange",
                //   trendingList: trendingData.bottomFive,
                // ),

                _buildGainersPage(trendingData.topFive),
                _buildLoosersPage(trendingData.bottomFive),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: CirclePageIndicator(
              dotColor: Colors.grey,
              selectedDotColor: MyColors.btnColor,
              itemCount: 2,
              currentPageNotifier: _currentPageNotifier,
              size: 8.0,
            ),
          ),
        ],
      ),
    );
  }
//

  Widget _buildGainersPage(List<Asset> topFive) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: topFive.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(Iconss.equityIcon),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topFive[index].symbol,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        getAssetProperty(
                            topFive[index].symbol, fetchedSymbols, 'name'),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Rs ${topFive[index].ltp}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  _buildArrowAndPercentage(topFive[index].percentchange),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //
  Widget _buildLoosersPage(List<Asset> bottomFive) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bottomFive.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(Iconss.equityIcon),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bottomFive[index].symbol,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        getAssetProperty(
                            bottomFive[index].symbol, fetchedSymbols, 'name'),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Rs ${bottomFive[index].ltp}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  _buildArrowAndPercentage(bottomFive[index].percentchange),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _turnover() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black,
          width: 0.1,
        ),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentPageNotifier1.value == 0
                    ? 'Top Turnover'
                    : 'Top Volume',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: GoogleFonts.poppins(
                    color: MyColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 300,
            child: PageView(
              controller: _pageController1,
              onPageChanged: (int index) {
                setState(() {
                  _currentPageNotifier1.value = index;
                });
              },
              children: [
                AssetList(
                  assetList: turnoverData.turnoverData,
                  firstitem: "name",
                  seconditem: "ltp",
                  thirditem: "turnover",
                ),
                AssetList(
                  assetList: volumeData.volumeData,
                  firstitem: "name",
                  seconditem: "ltp",
                  thirditem: "turnover",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: CirclePageIndicator(
              dotColor: Colors.grey,
              selectedDotColor: MyColors.btnColor,
              itemCount: 2,
              currentPageNotifier: _currentPageNotifier1,
              size: 8.0,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildTurnoverPage() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount:
  //         turnoverData.turnoverData.length, // Use the length of turnoverData
  //     itemBuilder: (context, index) => InkWell(
  //       onTap: () {},
  //       child: Container(
  //         padding: const EdgeInsets.all(10),
  //         margin: const EdgeInsets.only(top: 12),
  //         decoration: BoxDecoration(
  //           color: Colors.black.withOpacity(0.04),
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Row(
  //               children: [
  //                 const CircleAvatar(
  //                   radius: 20,
  //                   backgroundImage: AssetImage(Iconss.equityIcon),
  //                 ),
  //                 const SizedBox(width: 8),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       turnoverData.turnoverData[index].symbol,
  //                       style: GoogleFonts.poppins(
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                     Text(
  //                       (() {
  //                         List<String> words =
  //                             turnoverData.turnoverData[index].name.split(' ');
  //                         return words.length > 2
  //                             ? words.sublist(0, 2).join(' ')
  //                             : turnoverData.turnoverData[index].name;
  //                       })(),
  //                       style: GoogleFonts.poppins(
  //                         fontSize: 13,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Text(
  //                   'Rs ${turnoverData.turnoverData[index].ltp}',
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 Text(
  //                   turnoverData.turnoverData[index].turnover ?? "",
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildVolumePage() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount:
  //         turnoverData.turnoverData.length, // Use the length of turnoverData
  //     itemBuilder: (context, index) => InkWell(
  //       onTap: () {},
  //       child: Container(
  //         padding: const EdgeInsets.all(10),
  //         margin: const EdgeInsets.only(top: 12),
  //         decoration: BoxDecoration(
  //           color: Colors.black.withOpacity(0.04),
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Row(
  //               children: [
  //                 const CircleAvatar(
  //                   radius: 20,
  //                   backgroundImage: AssetImage(Iconss.equityIcon),
  //                 ),
  //                 const SizedBox(width: 8),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       volumeData.volumeData[index].symbol,
  //                       style: GoogleFonts.poppins(
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                     Text(
  //                       (() {
  //                         List<String> words =
  //                             volumeData.volumeData[index].name.split(' ');
  //                         return words.length > 2
  //                             ? words.sublist(0, 2).join(' ')
  //                             : volumeData.volumeData[index].name;
  //                       })(),
  //                       style: GoogleFonts.poppins(
  //                         fontSize: 13,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Text(
  //                   'Rs ${volumeData.volumeData[index].ltp}',
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 Text(
  //                   volumeData.volumeData[index].turnover ?? "",
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Container _watchlist() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Colors.black, width: 0.1), // Adjust width as needed
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Watchlist',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: GoogleFonts.poppins(
                    color: MyColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stockPortfolio.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(Iconss.equityIcon),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${stockPortfolio[index].symbol}',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${stockPortfolio[index].name}',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${stockPortfolio[index].price}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${stockPortfolio[index].change}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _commodities() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Colors.black, width: 0.1), // Adjust width as needed
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentPageNotifier2.value == 0 ? 'Commodities' : 'Top Metals',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: GoogleFonts.poppins(
                    color: MyColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 300,
            child: PageView(
              controller: _pageController2,
              onPageChanged: (int index) {
                setState(() {
                  _currentPageNotifier2.value = index;
                });
              },
              children: [
                AssetList(
                  assetList: commoData.commoData,
                  firstitem: "category",
                  seconditem: "ltp",
                  thirditem: "unit",
                ),
                AssetList(
                  assetList: metalData.metalData,
                  firstitem: "category",
                  seconditem: "ltp",
                  thirditem: "unit",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: CirclePageIndicator(
              dotColor: Colors.grey,
              selectedDotColor: MyColors.btnColor,
              itemCount: 2,
              currentPageNotifier: _currentPageNotifier1,
              size: 8.0,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCommoPage() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: commoData.commoData.length,
  //     itemBuilder: (context, index) => InkWell(
  //       onTap: () {},
  //       child: Container(
  //         padding: const EdgeInsets.all(10),
  //         margin: const EdgeInsets.only(top: 12),
  //         decoration: BoxDecoration(
  //           color: Colors.black.withOpacity(0.04),
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Row(
  //               children: [
  //                 const CircleAvatar(
  //                   radius: 20,
  //                   backgroundImage: AssetImage(Iconss.equityIcon),
  //                 ),
  //                 const SizedBox(width: 8),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       commoData.commoData[index].name,
  //                       style: GoogleFonts.poppins(
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                     Text(
  //                       commoData.commoData[index].category ?? "Empty",
  //                       style: GoogleFonts.poppins(
  //                         fontSize: 13,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Text(
  //                   commoData.commoData[index].ltp ?? "",
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 Text(
  //                   commoData.commoData[index].unit ?? "",
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.w400,
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

// Widget _buildCommoPage() {
//   return AssetList(
//     assetList: commoData.commoData,
//     firstitem: commoData.commoData[index].category,
//   );
// }

  // Widget _buildMetalPage() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: metalData.metalData.length,
  //     itemBuilder: (context, index) => InkWell(
  //       onTap: () {},
  //       child: Container(
  //         padding: const EdgeInsets.all(10),
  //         margin: const EdgeInsets.only(top: 12),
  //         decoration: BoxDecoration(
  //           color: Colors.black.withOpacity(0.04),
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Row(
  //               children: [
  //                 const CircleAvatar(
  //                   radius: 20,
  //                   backgroundImage: AssetImage(Iconss.equityIcon),
  //                 ),
  //                 const SizedBox(width: 8),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       metalData.metalData[index].name,
  //                       style: GoogleFonts.poppins(
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                     Text(
  //                       metalData.metalData[index].category ?? "Empty",
  //                       style: GoogleFonts.poppins(
  //                         fontSize: 13,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Text(
  //                   metalData.metalData[index].ltp ?? "",
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 Text(
  //                   metalData.metalData[index].unit ?? "",
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.w400,
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Container _portfolio() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Portfolio',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: GoogleFonts.poppins(
                      color: MyColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          SizedBox(
            height: 125,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: stockPortfolio.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.assetRoute);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 10),
                  height: 125,
                  width: 150,
                  decoration: BoxDecoration(
                      color: HexColor('${stockPortfolio[index].color}')
                          .withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(Iconss.equityIcon),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${stockPortfolio[index].symbol}',
                                style: GoogleFonts.poppins(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${stockPortfolio[index].name}',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 9),
                      Text(
                        '${stockPortfolio[index].price}',
                        style: GoogleFonts.poppins(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.arrow_up_1,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${stockPortfolio[index].change}',
                            style: GoogleFonts.poppins(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _mySummary() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Colors.black, width: 0.1), // Adjust width as needed
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Summary',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Asset',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Rs 100,000',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Holding Asset',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Rs 50,000',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _card() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: MyColors.btnColor, // Set to your desired navy blue color
        //borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3, // Allocate 3/4 of the space for the portfolio details
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Portfolio',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Rs 112,550.00',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Iconsax.arrow_up_1,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: '+4.5% this week',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3, // Allocate 1/4 of the space for the line chart
            child: SizedBox(
              height: 75, // Set your desired height for the chart
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 1),
                        const FlSpot(1, 3),
                        const FlSpot(2, 2),
                        const FlSpot(3, 4),
                        const FlSpot(4, 2),
                        const FlSpot(5, 5),
                      ],
                      isCurved: true,
                      colors: [MyColors.btnColor],
                      barWidth: 1,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        gradientFrom: const Offset(0, 0),
                        gradientTo: const Offset(0, 1),
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.5),
                        ],
                      ),
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
                swapAnimationDuration: const Duration(milliseconds: 250),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _header() {
    return Container(
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          color: MyColors.btnColor, // Set to your desired navy blue color
        ),
        child: Builder(
          builder: (BuildContext context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        if (_scaffoldKey.currentState != null) {
                          _scaffoldKey.currentState!.openDrawer();
                        }
                        // Add functionality for the hamburger menu button
                      },
                      icon: const Icon(Iconsax.menu_1),
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoute.profileRoute);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  Colors.white, // Set the color of the circle
                            ),
                            padding: const EdgeInsets.all(1.2),
                            child: CircleAvatar(
                                radius: 18,
                                backgroundImage: AssetImage(currentDP)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          currentName.split(' ')[0],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.newsRoute);
                      },
                      padding: const EdgeInsets.all(0),
                      minWidth: 0,
                      child: const Icon(
                        Iconsax.book4,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.notiRoute);
                      },
                      padding: const EdgeInsets.all(0),
                      minWidth: 0,
                      child: const Icon(
                        Iconsax.notification,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.searchRoute);
                      },
                      padding: const EdgeInsets.all(0),
                      minWidth: 0,
                      child: const Icon(
                        Iconsax.search_normal,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ));
  }

  Future<bool> _onBackPressed() async {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }

  Widget _buildArrowAndPercentage(String? percentChange) {
    double change = double.tryParse(percentChange ?? '0.0') ?? 0.0;

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
}

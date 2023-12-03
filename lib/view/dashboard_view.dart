import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:paisa/app/common/dashboard_list.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/data/portfolio_data.dart';
import 'package:paisa/model/asset_model.dart';
import 'package:paisa/services/portfolio_services.dart';
import 'package:paisa/services/user_services.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:paisa/view/category_view.dart';
import 'package:paisa/view/portfoliodetail_view.dart';

import '../app/common/drawer_common.dart';
import '../app/common/navbar_common.dart';
import '../services/asset_services.dart';
import '../utils/icons_utils.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _MainPageState();
}

class _MainPageState extends State<DashboardView> {
  int indexBottomBar = 0;
  String currentName = "";
  String currentEmail = "";
  String currentPhone = "";
  int currentPort = 0;

  String currentDP = Iconss.defaultdb;
  final ScrollController _scrollController = ScrollController();

  List<Asset> fetchedSymbols = [];
  List<Map<String, dynamic>> portfolioData = [];

  final List<PageController> _pageControllers = [
    PageController(),
    PageController(),
    PageController(),
  ];

  final List<ValueNotifier<int>> _currentPageNotifiers = [
    ValueNotifier<int>(0),
    ValueNotifier<int>(0),
    ValueNotifier<int>(0),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TrendingData trendingData = TrendingData([], []);
  TurnoverData turnoverData = TurnoverData([]);
  VolumeData volumeData = VolumeData([]);
  CommodityData commodityData = CommodityData([]);
  MetalsData metalData = MetalsData([]);

  @override
  void initState() {
    super.initState();
    fetchData();
    _loadPortfolioData();
  }

  Future<void> _handleRefresh() async {
    fetchData();
    _loadPortfolioData();
  }

  Future<void> fetchData() async {
    try {
      Map<String, dynamic>? userData = await UserService.fetchUserData();
      TrendingData dataa = await TrendingData.getTrendingData();
      TurnoverData tdata = await TurnoverData.getTurnoverData();
      VolumeData vdata = await VolumeData.getVolumeData();
      List<Asset> cdata = await CommodityData.getCommodityData();
      List<Asset> mdata = await MetalsData.getMetalsData();
      List<Asset> symbols = await AssetData.getAssetData();

      if (userData != null) {
        setState(() {
          currentName = userData['name'];
          currentEmail = userData['email'];
          currentPhone = userData['phone'];
          currentDP = userData['dp'];
          currentPort = userData['defaultport'];
        });
      }

      setState(() {
        trendingData = dataa;
        fetchedSymbols = symbols;
        turnoverData = tdata;
        volumeData = vdata;
        commodityData = CommodityData(cdata);
        metalData = MetalsData(mdata);
      });
    } catch (error) {
      CustomToast.showToast("Error occured fetching data");
    }
  }

  _loadPortfolioData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      List<Map<String, dynamic>> data = await PortfolioService.getPortfolio();

      List<Map<String, dynamic>> filteredPortfolio =
          data.where((portfolio) => portfolio['id'] == currentPort).toList();

      setState(() {
        portfolioData = filteredPortfolio;
      });
    } catch (error) {
      print("--------We got a portfolio errror--------");
    }
  }

  void _gotocategory(
      List<Asset> assetList, first, second, third, utils, type, initial) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryView(
          context: context,
          assetList: assetList,
          firstitem: first,
          seconditem: second,
          thirditem: third,
          gainerList: trendingData.topFive,
          looserList: trendingData.bottomFive,
          turnoverList: turnoverData.turnoverData,
          volumeList: volumeData.volumeData,
          utils: utils,
          type: type,
          initialTabIndex: initial,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: SafeArea(
              child: SingleChildScrollView(
            //physics: const BouncingScrollPhysics(),
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
          )),
        ),
        drawer: const CommonDrawer(),
        bottomNavigationBar: CommonBottomNavigationBar(
          currentIndex: indexBottomBar,
          onTap: (index) {
            if (index == 4) {
              Navigator.pushNamed(context, AppRoute.profileRoute);
            } else if (index == 2) {
              Navigator.pushNamed(context, AppRoute.portRoute);
            } else if (index == 1) {
              Navigator.pushNamed(context, AppRoute.searchRoute);
            } else if (index == 3) {
              Navigator.pushNamed(context, AppRoute.wishlistRoute);
            } else {
              setState(() => indexBottomBar = index);
            }
          },
        ));
  }

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
                _currentPageNotifiers[0].value == 0
                    ? 'Top Gainers'
                    : 'Top Loosers',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  _gotocategory(const [],
                      "name",
                      "ltp",
                      "percentchange",
                      "percentchange",
                      false,
                      _currentPageNotifiers[0].value == 0 ? 0 : 1);
                },
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
              controller: _pageControllers[0],
              onPageChanged: (int index) {
                setState(() {
                  _currentPageNotifiers[0].value = index;
                });
              },
              children: [
                DashboardList(
                  context: context,
                  assetList: const [],
                  firstitem: "name",
                  seconditem: "ltp",
                  thirditem: "percentchange",
                  trendingList: trendingData.topFive,
                  utils: "percentchange",
                  type: false,
                ),
                DashboardList(
                  context: context,
                  assetList: const [],
                  firstitem: "name",
                  seconditem: "ltp",
                  thirditem: "percentchange",
                  trendingList: trendingData.bottomFive,
                  utils: "percentchange",
                  type: false,
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
              currentPageNotifier: _currentPageNotifiers[0],
              size: 8.0,
            ),
          ),
        ],
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
                _currentPageNotifiers[1].value == 0
                    ? 'Top Turnover'
                    : 'Top Volume',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  _gotocategory(
                      _currentPageNotifiers[1].value == 0
                          ? turnoverData.turnoverData
                          : volumeData.volumeData,
                      "name",
                      "ltp",
                      "turnover",
                      "", //uttils
                      false,
                      _currentPageNotifiers[1].value == 0 ? 2 : 3);
                },
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
              controller: _pageControllers[1],
              onPageChanged: (int index) {
                setState(() {
                  _currentPageNotifiers[1].value = index;
                });
              },
              children: [
                DashboardList(
                  context: context,
                  assetList: turnoverData.turnoverData,
                  firstitem: "name",
                  seconditem: "ltp",
                  thirditem: "turnover",
                  type: false,
                ),
                DashboardList(
                  context: context,
                  assetList: volumeData.volumeData,
                  firstitem: "name",
                  seconditem: "ltp",
                  thirditem: "turnover",
                  type: false,
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
              currentPageNotifier: _currentPageNotifiers[1],
              size: 8.0,
            ),
          ),
        ],
      ),
    );
  }

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
        border: Border.all(color: Colors.black, width: 0.1),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentPageNotifiers[2].value == 0
                    ? 'Commodities'
                    : 'Top Metals',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // MaterialButton(
              //   onPressed: () {},
              //   child: Text(
              //     'View All',
              //     style: GoogleFonts.poppins(
              //       color: MyColors.primaryColor,
              //       fontSize: 14,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // )
            ],
          ),
          SizedBox(
            height: 300,
            child: PageView(
              controller: _pageControllers[2],
              onPageChanged: (int index) {
                setState(() {
                  _currentPageNotifiers[2].value = index;
                });
              },
              children: [
                DashboardList(
                  context: context,
                  assetList: commodityData.commodityData,
                  firstitem: "category",
                  seconditem: "ltp",
                  thirditem: "unit",
                  type: true,
                ),
                DashboardList(
                  context: context,
                  assetList: metalData.metalData,
                  firstitem: "category",
                  seconditem: "ltp",
                  thirditem: "unit",
                  type: true,
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
              currentPageNotifier: _currentPageNotifiers[2],
              size: 8.0,
            ),
          ),
        ],
      ),
    );
  }

  Container _portfolio() {
    List<Map<String, dynamic>> stocks = portfolioData.isNotEmpty
        ? (portfolioData[0]['stocks'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
        : [];

    Future<String> fetchMissingData(String symbol, String property) async {
      List<Asset> assetList = await AssetData.getAssetData();

      Asset? asset = assetList.firstWhere(
        (element) => element.symbol == symbol,
        orElse: () => Asset(symbol: symbol, name: 'Unknown'),
      );

      switch (property) {
        case 'name':
          String companyName = asset.name.split(' ').take(2).join(' ');
          return companyName.length > 8
              ? '${companyName.substring(0, 6)}..'
              : companyName;
        case 'ltp':
          return asset.ltp ?? "0.0";
        case 'percentchange':
          String percentChange = asset.percentchange ?? "0.0";
          return '${double.parse(percentChange).toStringAsFixed(1)}%';
        default:
          return 'Unknown';
      }
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
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
                portfolioData.isNotEmpty
                    ? 'My Portfolio ${portfolioData[0]['name']}'
                    : 'My Portfolio',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PortfoliodetailView(
                        portfolioId: currentPort.toString(),
                      ),
                    ),
                  );
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.poppins(
                    color: MyColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          if (stocks.isEmpty || portfolioData.isEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logos/empty.png',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    portfolioData.isEmpty
                        ? 'Please create a new portfolio'
                        : stocks.isEmpty
                            ? 'Empty Portfolio, try adding stock to the portfolio'
                            : '',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          if (stocks.isNotEmpty && portfolioData.isNotEmpty)
            SizedBox(
              height: 125,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: stocks.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    // Handle stock item tap if needed
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 10),
                    height: 125,
                    width: 150,
                    decoration: BoxDecoration(
                      color: MyColors.btnColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
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
                                  '${stocks[index]['symbol']}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                FutureBuilder<String>(
                                  future: fetchMissingData(
                                      stocks[index]['symbol'], 'name'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const SizedBox(
                                        width: 10,
                                        child: LinearProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      final companyName =
                                          snapshot.data ?? 'Unknown';
                                      return Text(
                                        companyName,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 9),
                        FutureBuilder<String>(
                          future:
                              fetchMissingData(stocks[index]['symbol'], 'ltp'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox(
                                width: 10,
                                child: LinearProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final ltp = snapshot.data ?? '0.0';
                              return Text(
                                'Rs $ltp',
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 5),
                        FutureBuilder<String>(
                          future: fetchMissingData(
                              stocks[index]['symbol'], 'percentchange'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox(
                                width: 10,
                                child: LinearProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final percentChange = snapshot.data;
                              return Text(
                                '$percentChange',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
    num totalPortfolioValue = 0;
    for (var portfolio in portfolioData) {
      totalPortfolioValue += portfolio['portfoliovalue'] ?? 0;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: MyColors.btnColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
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
                    totalPortfolioValue != 0
                        ? 'Rs ${totalPortfolioValue.toString()}'
                        : 'Add Assets',
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
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Icon(
                              portfolioData.isNotEmpty
                                  ? portfolioData.first['stocks']
                                              .first['netgainloss'] >
                                          0
                                      ? Iconsax.arrow_up_1
                                      : Iconsax.arrow_down_2
                                  : Iconsax.empty_wallet_add,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextSpan(
                          text:
                              'Rs ${portfolioData.isNotEmpty ? portfolioData.first['stocks'].first['netgainloss'].toStringAsFixed(0) : '0'}',
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
            flex: 3,
            child: SizedBox(
              height: 75,
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
          color: MyColors.btnColor,
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
                              color: Colors.white,
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
}

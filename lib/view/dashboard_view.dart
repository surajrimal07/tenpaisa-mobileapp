import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/data/portfolio_data.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _MainPageState();
}

class _MainPageState extends State<DashboardView> {
  int indexBottomBar = 0;
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          MyColors.btnColor, // Status bar color set to a dark blue shade
      statusBarIconBrightness:
          Brightness.light, // Adjust status bar icon colors
      systemNavigationBarColor:
          MyColors.btnColor, // Navigation bar color set to the same blue shade
      systemNavigationBarIconBrightness:
          Brightness.light, // Adjust navigation bar icon colors
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _header(),
                    _card(),
                    _menu(),
                    _portfolio(),
                    _watchlist(),
                  ],
                ),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                children: const [
                  UserAccountsDrawerHeader(
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(color: MyColors.btnColor),
                    accountName: Text('Suraj Rimal'),
                    accountEmail: Text('test@test.com'),
                    currentAccountPictureSize: Size(60, 60),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/content/user1.jpg'),
                    ),
                  ),
                  ListTile(
                    title: Text('My Profile'),
                    leading: Icon(CupertinoIcons.person),
                  ),
                  ListTile(
                    title: Text('Themes'),
                    leading: Icon(CupertinoIcons.color_filter),
                  ),
                  ListTile(
                    title: Text('Fonts'),
                    leading: Icon(Icons.font_download_outlined),
                  ),
                  ListTile(
                    title: Text('Favorites'),
                    leading: Icon(CupertinoIcons.heart),
                  ),
                  ListTile(
                    title: Text('Settings'),
                    leading: Icon(CupertinoIcons.settings),
                  ),
                  ListTile(
                    title: Text('Exit'),
                    leading: Icon(Icons.exit_to_app),
                  )
                ],
              ),
            ),
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: indexBottomBar,
              onTap: (i) {
                if (i == 4) {
                  // Index of the Profile icon
                  Navigator.pushNamed(context, AppRoute.profileRoute);
                } else {
                  setState(() => indexBottomBar = i);
                }
              },

              // currentIndex: indexBottomBar,
              // onTap: (i) => setState(() => indexBottomBar = i),
              items: [
                /// Home
                SalomonBottomBarItem(
                  icon: const Icon(Iconsax.home),
                  title: const Text("Home"),
                  selectedColor: MyColors.btnColor,
                ),

                /// Search
                SalomonBottomBarItem(
                  icon: const Icon(Iconsax.global_search),
                  title: const Text("Search"),
                  selectedColor: MyColors.btnColor,
                ),

                /// Likes
                SalomonBottomBarItem(
                  icon: const Icon(Iconsax.document),
                  title: const Text("Portfolio"),
                  selectedColor: MyColors.btnColor,
                ),

                SalomonBottomBarItem(
                  icon: const Icon(Iconsax.wallet_1),
                  title: const Text("Wallet"),
                  selectedColor: MyColors.btnColor,
                ),

                /// Profile
                SalomonBottomBarItem(
                  icon: const Icon(Iconsax.profile_circle),
                  title: const Text("Profile"),
                  selectedColor: MyColors.btnColor,
                ),
              ],
            )));
  }

  Container _watchlist() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Watchlist',
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stockPortfolio.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage('${stockPortfolio[index].iconUrl}'),
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
                                  fontSize: 13, fontWeight: FontWeight.w400),
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
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
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
          )
        ],
      ),
    );
  }

  Container _portfolio() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Portfolio',
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
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(12),
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
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                '${stockPortfolio[index].iconUrl}'),
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

  Padding _menu() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      child: Container(
        decoration: const BoxDecoration(
          color: MyColors.btnColor, // Set to your desired navy blue color
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(14),
            bottomRight: Radius.circular(14),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                color: Colors.white,
                elevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                height: 40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                  side: const BorderSide(color: MyColors.primaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.sell_outlined,
                      size: 22,
                      color: MyColors.btnColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Buy',
                      style: GoogleFonts.poppins(
                        color: MyColors.btnColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 28,
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                color: Colors.white,
                elevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                height: 40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                  side: const BorderSide(color: MyColors.primaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.sell_outlined,
                      size: 22,
                      color: MyColors.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Sell',
                      style: GoogleFonts.poppins(
                        color: MyColors.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
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
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white, // Set the color of the circle
                          ),
                          padding: const EdgeInsets.all(1.2),
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                AssetImage('assets/images/content/user1.jpg'),
                          ),
                        ),
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
                          'Suraj',
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
                        Iconsax.notification,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {},
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
}

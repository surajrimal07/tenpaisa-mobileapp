import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
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

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //statusBarColor: Colors.transparent,
      statusBarColor: MyColors.btnColor, // Set status bar color to transparent
      statusBarIconBrightness:
          Brightness.light, // Adjust the status bar icons' color
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
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
            // bottomNavigationBar: SnakeNavigationBar.color(
            //   behaviour: SnakeBarBehaviour.floating,
            //   snakeShape: SnakeShape.indicator,
            //   shape:
            //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            //   padding: const EdgeInsets.all(8),
            //   currentIndex: indexBottomBar,
            //   backgroundColor: const Color.fromARGB(156, 45, 51, 85),
            //   selectedItemColor: Colors.white,
            //   unselectedItemColor: Colors.white,
            //   height: 52,
            //   showSelectedLabels: true,
            //   showUnselectedLabels: true,
            //   snakeViewColor: MyColors.primaryColor,
            //   onTap: (index) => setState(() => indexBottomBar = index),
            //   items: const [
            //     BottomNavigationBarItem(
            //         icon: Icon(Iconsax.home),
            //         activeIcon: Icon(Iconsax.home5),
            //         label: 'home'),
            //     BottomNavigationBarItem(
            //         icon: Icon(Iconsax.document),
            //         activeIcon: Icon(Iconsax.document5),
            //         label: 'history'),
            //     BottomNavigationBarItem(
            //         icon: Icon(Iconsax.global_search),
            //         activeIcon: Icon(Iconsax.global_search5),
            //         label: 'search'),
            //     BottomNavigationBarItem(
            //         icon: Icon(Iconsax.wallet_1),
            //         activeIcon: Icon(Iconsax.wallet),
            //         label: 'Wallet'),
            //     BottomNavigationBarItem(
            //         icon: Icon(Iconsax.profile_add),
            //         activeIcon: Icon(Iconsax.profile_add5),
            //         label: 'user')
            //   ],
            // ),

            bottomNavigationBar: SalomonBottomBar(
              currentIndex: indexBottomBar,
              onTap: (i) => setState(() => indexBottomBar = i),
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
                  width: 200,
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
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: MaterialButton(
              onPressed: () {},
              color: Colors.white,
              elevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
              height: 45,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                  side: const BorderSide(color: MyColors.primaryColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sell_outlined,
                    color: MyColors.btnColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Buy',
                    style: GoogleFonts.poppins(
                        color: MyColors.btnColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 18,
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () {},
              color: Colors.white,
              elevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
              height: 45,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                  side: const BorderSide(color: MyColors.primaryColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sell_outlined,
                    color: MyColors.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Sell',
                    style: GoogleFonts.poppins(
                        color: MyColors.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _card() {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.centerLeft,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'My Portfolio',
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
            Text(
              '\$112,550.00',
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w700),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: '\$110,000.52',
                  style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                TextSpan(
                  text: ' +15',
                  style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ]),
            )
          ]),
        ));
  }

  // Container _header() {
  //   return Container(
  //     padding: const EdgeInsets.all(0),
  //     child: Row(
  //       children: [
  //         IconButton(
  //           splashColor: Colors.transparent,
  //           highlightColor: Colors.transparent,
  //           onPressed: () {
  //             // Add functionality for the hamburger menu button
  //           },
  //           icon: const Icon(Iconsax.menu_1),
  //           color: Colors.black,
  //         ),

  //         const CircleAvatar(
  //           radius: 22,
  //           backgroundImage: AssetImage('assets/images/content/user1.jpg'),
  //         ),
  //         const SizedBox(width: 4),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Hello, welcome',
  //               style: GoogleFonts.poppins(
  //                   fontSize: 13, fontWeight: FontWeight.w400),
  //             ),
  //             Text(
  //               'Suraj',
  //               style: GoogleFonts.poppins(
  //                   fontSize: 15, fontWeight: FontWeight.w600),
  //             ),
  //           ],
  //         ),
  //         const Spacer(),
  //         //const SizedBox(width: 0),
  //         MaterialButton(
  //           onPressed: () {},
  //           padding: const EdgeInsets.all(6),
  //           shape: const CircleBorder(side: BorderSide(color: Colors.black12)),
  //           child: const Icon(Iconsax.notification),
  //         ),
  //         MaterialButton(
  //           onPressed: () {},
  //           padding: const EdgeInsets.all(6),
  //           shape: const CircleBorder(side: BorderSide(color: Colors.black12)),
  //           child: const Icon(Iconsax.search_normal),
  //         )
  //       ],
  //     ),
  //   );
  // }
//}

  // Container _header() {
  //   return Container(
  //     padding: const EdgeInsets.all(0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         IconButton(
  //           splashColor: Colors.transparent,
  //           highlightColor: Colors.transparent,
  //           onPressed: () {
  //             // Add functionality for the hamburger menu button
  //           },
  //           icon: const Icon(Iconsax.menu_1),
  //           color: Colors.black,
  //         ),
  //         const SizedBox(
  //             width:
  //                 0), // Add spacing between the hamburger menu and the CircleAvatar
  //         const CircleAvatar(
  //           radius: 22,
  //           backgroundImage: AssetImage('assets/images/content/user1.jpg'),
  //         ),
  //         const SizedBox(width: 4),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Hello,',
  //               style: GoogleFonts.poppins(
  //                 fontSize: 13,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //             Text(
  //               'Suraj',
  //               style: GoogleFonts.poppins(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ],
  //         ),

  //         MaterialButton(
  //           onPressed: () {},
  //           padding: const EdgeInsets.all(6),
  //           shape: const CircleBorder(side: BorderSide(color: Colors.black12)),
  //           child: const Icon(Iconsax.notification),
  //         ),

  //         MaterialButton(
  //           onPressed: () {},
  //           padding: const EdgeInsets.all(6),
  //           shape: const CircleBorder(side: BorderSide(color: Colors.black12)),
  //           child: const Icon(Iconsax.search_normal),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Container _header() {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  // Add functionality for the hamburger menu button
                },
                icon: const Icon(Iconsax.menu_1),
                color: Colors.black,
              ),
              const SizedBox(width: 4),
              const CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/images/content/user1.jpg'),
              ),
              const SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Suraj',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 40),
          MaterialButton(
            onPressed: () {},
            padding: const EdgeInsets.all(6),
            shape: const CircleBorder(side: BorderSide(color: Colors.black12)),
            child: const Icon(Iconsax.notification),
          ),
          const SizedBox(width: 0), // Reduced SizedBox width
          MaterialButton(
            onPressed: () {},
            padding: const EdgeInsets.all(6),
            shape: const CircleBorder(side: BorderSide(color: Colors.black12)),
            child: const Icon(Iconsax.search_normal),
          ),
        ],
      ),
    );
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

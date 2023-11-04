import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/data/portfolio_data.dart';
import 'package:paisa/utils/colors_utils.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _MainPageState();
}

class _MainPageState extends State<DashboardView> {
  int indexBottomBar = 0;
  DateTime? currentBackPressTime;

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
          bottomNavigationBar: SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.floating,
            snakeShape: SnakeShape.circle,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            padding: const EdgeInsets.all(16),
            currentIndex: indexBottomBar,
            backgroundColor: MyColors.secondaryColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            height: 72,
            snakeViewColor: MyColors.primaryColor,
            onTap: (index) => setState(() => indexBottomBar = index),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.home),
                  activeIcon: Icon(Iconsax.home5),
                  label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.document),
                  activeIcon: Icon(Iconsax.document5),
                  label: 'transaction'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.transaction_minus),
                  activeIcon: Icon(Iconsax.transaction_minus5),
                  label: 'buy/sell'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.clock),
                  activeIcon: Icon(Iconsax.clock5),
                  label: 'clock'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.profile_add),
                  activeIcon: Icon(Iconsax.profile_add5),
                  label: 'user')
            ],
          ),
        ));
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
                          radius: 24,
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
                                  fontSize: 16, fontWeight: FontWeight.w600),
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
            height: 142,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: stockPortfolio.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(right: 10),
                  height: 142,
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
                            radius: 24,
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
                                    fontSize: 16, fontWeight: FontWeight.w600),
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
                      const SizedBox(height: 12),
                      Text(
                        '${stockPortfolio[index].price}',
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
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
              color: MyColors.primaryColor,
              elevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
              height: 58,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.arrow_down_2,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Withdraw',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () {},
              color: Colors.white,
              elevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
              height: 58,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                  side: const BorderSide(color: MyColors.primaryColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.arrow_down_2,
                    color: MyColors.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Deposit',
                    style: GoogleFonts.poppins(
                        color: MyColors.primaryColor,
                        fontSize: 16,
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
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        Text(
          'Availble Balance',
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        Text(
          '\$112,550.00',
          style: GoogleFonts.poppins(fontSize: 34, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
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
              text: '+15',
              style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          ]),
        )
      ]),
    );
  }

  Container _header() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/images/content/user1.jpg'),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Good Morning',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                'Suraj Rimal',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Spacer(),
          MaterialButton(
            onPressed: () {},
            padding: const EdgeInsets.all(14),
            shape: const CircleBorder(side: BorderSide(color: Colors.black12)),
            child: const Icon(Iconsax.notification),
          )
        ],
      ),
    );
  }
//}

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

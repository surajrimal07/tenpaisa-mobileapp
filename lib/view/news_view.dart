import 'dart:convert';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:paisa/utils/serverconfig_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int indexBottomBar = 0;
  List<dynamic> newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
    WebView.platform = SurfaceAndroidWebView();
  }

  Future<void> fetchNews() async {
    var url = Uri.parse('${ServerConfig.SERVER_ADDRESS}${ServerConfig.NEWS}');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          newsList = json.decode(response.body);
        });
      } else {
        CustomToast.showToast("Failed to load news");
      }
    } catch (error) {
      CustomToast.showToast('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial News'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: fetchNews,
        child: ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            final url = newsList[index]['link'];
            return Column(
              children: [
                const SizedBox(height: 4),
                const SizedBox(height: 4),
                AnyLinkPreview(
                  urlLaunchMode: LaunchMode.inAppBrowserView,
                  displayDirection: UIDirection.uiDirectionHorizontal,
                  link: url,
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: indexBottomBar,
        onTap: (i) {
          if (i == 0) {
            if (indexBottomBar != 0) {
              Navigator.pushReplacementNamed(context, AppRoute.newsRoute);
              setState(() => indexBottomBar = 0);
            }
          } else if (i == 1) {
            Navigator.pushReplacementNamed(context, AppRoute.notiRoute);
            setState(() => indexBottomBar = 1);
          } else {
            setState(() => indexBottomBar = i);
          }
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.paperclip_2),
            title: const Text("News"),
            selectedColor: MyColors.btnColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.notification),
            title: const Text("Notification"),
            selectedColor: MyColors.btnColor,
          ),
        ],
      ),
    );
  }
}

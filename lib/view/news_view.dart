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
  List<dynamic> newsList = []; // Store the fetched news

  @override
  void initState() {
    super.initState();
    // Fetch news data when the widget initializes
    fetchNews();
    WebView.platform = SurfaceAndroidWebView();
  }

  Future<void> fetchNews() async {
    var url = Uri.parse(
        '${ServerConfig.serverAddress}/news'); // Replace with your API endpoint

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          newsList = json.decode(response.body);
        });
      } else {
        CustomToast.showToast("Failed to load news");
        //print('Failed to load news');
      }
    } catch (error) {
      CustomToast.showToast('Error fetching data: $error');
      //print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: fetchNews,
        child: ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            //final imgURL = newsList[index]['img_url'];
            final url = newsList[index]['link'];
            return Column(
              //elevation: 3,
              //margin:
              //   const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              //child: ListTile(
              children: [
                const SizedBox(height: 4),
                const SizedBox(height: 4),

                AnyLinkPreview(
                  urlLaunchMode: LaunchMode.inAppBrowserView,
                  displayDirection: UIDirection.uiDirectionHorizontal,
                  link: url,
                ),

                // GestureDetector(
                //   onTap: () {
                //     _openNewsInWebView(
                //         newsList[index]['link'], newsList[index]['title']);
                //     //_launchURL(url);
                //   },

                // ),
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
            //if (indexBottomBar != 1) {
            Navigator.pushReplacementNamed(context, AppRoute.notiRoute);
            setState(() => indexBottomBar = 1);
            //}
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

//   void _openNewsInWebView(String url, String title) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => NewsWebView(url: url, title: title),
//       ),
//     );
//   }
// }

// class NewsWebView extends StatelessWidget {
//   final String url;
//   final String title;

//   const NewsWebView({super.key, required this.url, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: MyColors.btnColor,
//       ),
//       body: WebView(
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//  }
}

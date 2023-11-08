// import 'dart:convert';

// import 'package:any_link_preview/any_link_preview.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:iconsax/iconsax.dart';
// import 'package:paisa/app/routes/approutes.dart';
// import 'package:paisa/utils/colors_utils.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class NotificationView extends StatefulWidget {
//   const NotificationView({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _NotificationViewState createState() => _NotificationViewState();
// }

// class _NotificationViewState extends State<NotificationView> {
//   int indexBottomBar = 1;
//   List<dynamic> newsList = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchNews();
//   }

//   Future<void> fetchNews() async {
//     var url = Uri.parse('http://192.168.101.6:5000/news');

//     try {
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         setState(() {
//           newsList = json.decode(response.body);
//         });
//       } else {
//         print('Failed to load news');
//       }
//     } catch (error) {
//       print('Error fetching data: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notifications'),
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: RefreshIndicator(
//         onRefresh: fetchNews,
//         child: ListView.builder(
//           itemCount: newsList.length,
//           itemBuilder: (context, index) {
//             final url3 = newsList[index]['link'];
//             return Column(
//               children: [
//                 const SizedBox(height: 7),
//                 GestureDetector(
//                   child: AnyLinkPreview(
//                     urlLaunchMode: LaunchMode.inAppBrowserView,
//                     displayDirection: UIDirection.uiDirectionHorizontal,
//                     link: url3,
//                   ),
//                   // onTap: () {
//                   //   _openinWebView(
//                   //       newsList[index]['link'], newsList[index]['title']);
//                   //   //_openInWebView(newsList[index]['link'], newsList[index]['title']);
//                   // }
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//       bottomNavigationBar: SalomonBottomBar(
//         currentIndex: indexBottomBar,
//         onTap: (i) {
//           if (i == 0) {
//             if (indexBottomBar != 0) {
//               Navigator.pushNamed(context, AppRoute.notiRoute);
//             }
//           } else if (i == 1) {
//             if (indexBottomBar != 1) {
//               Navigator.pushNamed(context, AppRoute.dashboardRoute);
//             }
//           } else {
//             setState(() => indexBottomBar = i);
//           }
//         },
//         items: [
//           SalomonBottomBarItem(
//             icon: const Icon(Iconsax.paperclip_2),
//             title: const Text("News"),
//             selectedColor: MyColors.btnColor,
//           ),
//           SalomonBottomBarItem(
//             icon: const Icon(Iconsax.notification),
//             title: const Text("Notification"),
//             selectedColor: MyColors.btnColor,
//           ),
//         ],
//       ),
//     );
//   }

//   void _openinWebView(String url, String title) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => NotiWebView(url: url, title: title),
//       ),
//     );
//   }
// }

// class NotiWebView extends StatelessWidget {
//   final String url;
//   final String title;

//   const NotiWebView({super.key, required this.url, required this.title});

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
//   }
// }
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  int indexBottomBar = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const Center(
        child: Text(
          'Under Development',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: indexBottomBar,
        onTap: (i) {
          if (i == 0) {
            //if (indexBottomBar != 0) {
            Navigator.pushReplacementNamed(context, AppRoute.newsRoute);
            //}
          } else if (i == 1) {
            if (indexBottomBar != 1) {
              Navigator.pushReplacementNamed(context, AppRoute.notiRoute);
            }
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

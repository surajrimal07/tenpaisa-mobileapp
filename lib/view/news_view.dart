import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:paisa/services/news_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  NewsViewState createState() => NewsViewState();
}

class NewsViewState extends State<NewsView> {
  late Future<List<dynamic>> newsFuture;

  @override
  void initState() {
    super.initState();
    newsFuture = News.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial News'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          SharedPreferences prefs;
          return SharedPreferences.getInstance().then((value) {
            prefs = value;
            prefs.remove('news_cache');
          }).then((_) {
            setState(() {
              newsFuture = News.fetchNews();
            });
          });
        },
        child: FutureBuilder(
          future: newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<dynamic> newsList = snapshot.data as List<dynamic>;
              return ListView.builder(
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
              );
            }
          },
        ),
      ),
    );
  }
}

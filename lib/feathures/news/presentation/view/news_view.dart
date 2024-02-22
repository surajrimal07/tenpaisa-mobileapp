import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/news/presentation/viewmodel/news_viewmodel.dart';
import 'package:paisa/feathures/splash/presentation/viewmodel/notification_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends ConsumerWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsViewModel = ref.watch(newsViewModelProvider);
    final scrollController = ref.watch(scrollControllerProvider);
    final notificationViewModel = ref.read(notificationViewModelProvider);
    notificationViewModel.clearUnreadNews();
    final connectivity = ref.watch(connectivityStatusProvider);

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    };

    return NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            if (scrollController.position.extentAfter == 0) {
              ref.read(newsViewModelProvider.notifier).getNews();
            }
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
              centerTitle: false,
              title: const Text(
                'Financial News',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    ref.read(newsViewModelProvider.notifier).resetState();
                  },
                  icon: const Icon(Icons.refresh),
                  color: Colors.white,
                ),
              ],
              backgroundColor: Theme.of(context).primaryColor,
              iconTheme: const IconThemeData(color: Colors.white)),
          body: connectivity == ConnectivityStatus.isDisconnected
              ? const Scaffold(
                  body: Center(
                    child: Text(
                      'No Internet Connection',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                )
              : RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: () async {
                    await ref.read(newsViewModelProvider.notifier).resetState();
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: newsViewModel.news.length,
                          itemExtent: 132,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final news = newsViewModel.news[index].link;

                            return Column(
                              children: [
                                AnyLinkPreview(
                                  removeElevation: true,
                                  errorBody:
                                      "We are unable to fetch the news body",
                                  headers: headers,
                                  errorTitle: "Unable to fetch the news title",
                                  errorImage: NewsStrings.defaultImage,
                                  cache: const Duration(days: 7),
                                  bodyMaxLines: 3,
                                  urlLaunchMode: LaunchMode.inAppBrowserView,
                                  displayDirection:
                                      UIDirection.uiDirectionHorizontal,
                                  link: news,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      if (newsViewModel.isLoading)
                        const CircularProgressIndicator(
                            color: AppColors.primaryColor),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
        ));
  }
}

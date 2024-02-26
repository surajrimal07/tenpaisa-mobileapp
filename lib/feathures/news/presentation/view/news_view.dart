import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/headers_constants.dart';
import 'package:paisa/config/themes/app_text_styles.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/animated_page_transition.dart';
import 'package:paisa/feathures/home/presentation/view/webview_view.dart';
import 'package:paisa/feathures/news/presentation/viewmodel/news_viewmodel.dart';
import 'package:paisa/feathures/splash/presentation/viewmodel/notification_view_model.dart';

class NewsView extends ConsumerWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsViewModel = ref.watch(newsViewModelProvider);
    final scrollController = ref.watch(scrollControllerProvider);
    final notificationViewModel = ref.read(notificationViewModelProvider);
    notificationViewModel.clearUnreadNews();
    final connectivity = ref.watch(connectivityStatusProvider);

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
            title: const Text(
              'Financial News',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ref.read(newsViewModelProvider.notifier).resetState();
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
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
                                  onTap: () {
                                    animatednavigateTo(
                                        context,
                                        WebViewPage(
                                          url: news,
                                          name: "Financial News",
                                        ));
                                  },
                                  titleStyle: AppTextStyles.itemtext1,
                                  backgroundColor: AppTheme.isDarkMode(context)
                                      ? AppColors.greyPrimaryColor
                                      : AppColors.darktextColor,
                                  removeElevation: false,
                                  errorBody:
                                      "We are unable to fetch the news body",
                                  headers: headers,
                                  errorTitle: "Unable to fetch the news title",
                                  errorImage: NewsStrings.defaultImage,
                                  cache: const Duration(days: 7),
                                  bodyMaxLines: 3,
                                  // urlLaunchMode: LaunchMode.inAppBrowserView,
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
                        const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
        ));
  }
}

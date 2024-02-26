import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/config/router/approutes.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/common/animated_page_transition.dart';
import 'package:paisa/feathures/common/image_loader.dart';
import 'package:paisa/feathures/home/presentation/view/home_view.dart';
import 'package:paisa/feathures/home/presentation/view/notification_view.dart';
import 'package:paisa/feathures/home/presentation/view/search_view.dart';
import 'package:paisa/feathures/news/presentation/view/news_view.dart';
import 'package:paisa/feathures/splash/presentation/viewmodel/notification_view_model.dart';

class Header extends ConsumerWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authEntityProvider);
    final unreadNewsCount = ref.watch(unreadNewsCountProvider);
    final unreadNotificationCount = ref.watch(unreadNotificationsCountProvider);

    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: AppTheme.isDarkMode(context)
            ? AppColors.greyPrimaryColor
            : AppColors.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  if (scaffoldKey.currentState != null) {
                    scaffoldKey.currentState!.openDrawer();
                  }
                },
                icon: const Icon(Iconsax.menu_1),
                color: Colors.white,
              ),
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
                      child: buildCircularImage(
                        auth.picture!,
                        36,
                        36,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DashboardStrings.helloText,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    ref
                        .watch(authEntityProvider.select((it) => it.name))
                        .split(' ')[0],
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
                    animatednavigateTo(context, const NewsView());
                  },
                  padding: const EdgeInsets.all(0),
                  minWidth: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Iconsax.book4,
                        size: 22,
                        color: Colors.white,
                      ),
                      if (unreadNewsCount > 0)
                        Positioned(
                          left: 18,
                          top: 0,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  )),
              MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    animatednavigateTo(context, const NotificationView());
                  },
                  padding: const EdgeInsets.all(0),
                  minWidth: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Iconsax.notification,
                        size: 22,
                        color: Colors.white,
                      ),
                      if (unreadNotificationCount > 0)
                        Positioned(
                          left: 17,
                          top: 0,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  )),
              MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  animatednavigateTo(context, const SearchView());
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
      ),
    );
  }
}

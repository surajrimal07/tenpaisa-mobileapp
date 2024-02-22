import 'package:flutter/material.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/common/animated_page_transition.dart';
import 'package:paisa/feathures/home/presentation/view/webview_view.dart';

class DataSourceDialog extends StatelessWidget {
  const DataSourceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Data Source",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.normal,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Author is not responsible for the accuracy of the data. Please refer to the official source for accurate data."),
          SizedBox(height: Sizes.dynamicHeight(1)),
          GestureDetector(
            onTap: () async {
              animatednavigateTo(
                  context,
                  const WebViewPage(
                    url: UrlStrings.nrbSite1,
                    name: "NRB",
                  ));
            },
            child: const Text(
              "Nepal Rastra Bank (NRB)",
              style: TextStyle(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

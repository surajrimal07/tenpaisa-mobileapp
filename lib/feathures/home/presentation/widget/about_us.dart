import 'package:flutter/material.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/common/animated_page_transition.dart';
import 'package:paisa/feathures/home/presentation/view/webview_view.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('About Us'),
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '10Paisa is an AI-powered stock market analysis and decision support application made as a university assignment.',
                style: TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              _buildClickableText(
                context,
                icon: Icons.person,
                label: 'Author:',
                text: UrlStrings.authorName,
                onPressed: () => _launchEmail(UrlStrings.authorEmail),
              ),
              _buildClickableText(
                context,
                icon: Icons.phone,
                label: 'Contact Number:',
                text: UrlStrings.authorPhone,
                onPressed: () => _makePhoneCall(UrlStrings.authorPhone),
              ),
              _buildClickableText(
                context,
                icon: Icons.email,
                label: 'Facebook:',
                text: UrlStrings.authorFacebook,
                onPressed: () => _launchURL(UrlStrings.authorFacebook, context),
              ),
              _buildClickableText(
                context,
                icon: Icons.email,
                label: 'Email:',
                text: UrlStrings.authorEmail,
                onPressed: () => _launchEmail(UrlStrings.authorEmail),
              ),
              const SizedBox(height: 5),
              _buildClickableText(
                context,
                icon: Icons.location_on,
                label: 'Location:',
                text: UrlStrings.authorLocation,
                onPressed: () => _launchURL(UrlStrings.googleMap, context),
              ),
              _buildClickableText(
                context,
                icon: Icons.code,
                label: 'GitHub:',
                text: UrlStrings.authorGithub,
                onPressed: () => _launchURL(UrlStrings.authorGithub, context),
              ),
              _buildClickableText(
                context,
                icon: Icons.web,
                label: 'Try web app at:',
                text: UrlStrings.tenpaisaurl,
                onPressed: () => _launchURL(UrlStrings.tenpaisaurl, context),
              ),
              const SizedBox(height: 5),
              _buildClickableText(
                context,
                icon: Icons.cloud,
                label: 'Backend hosted by: Google\n',
                text: 'Cloud',
                onPressed: () => _launchURL(UrlStrings.backendUrl, context),
              ),
              _buildClickableText(
                context,
                icon: Icons.school,
                label: 'Made for:',
                text: 'Softwarica College\n of IT and Ecommerce',
                onPressed: () => _launchURL(UrlStrings.madefor, context),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget _buildClickableText(BuildContext context,
      {required IconData icon,
      required String label,
      required String text,
      required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: GestureDetector(
              onTap: onPressed,
              child: Text(
                '$label $text',
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchURL(String url, context) async {
    animatednavigateTo(
        context,
        WebViewPage(
          url: url,
          name: "10Paisa Web App",
        ));
  }

  // Widget _buildText(BuildContext context,
  //     {required IconData icon, required String label, required String text}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 4.0),
  //     child: Row(
  //       children: [
  //         Icon(
  //           icon,
  //           size: 20,
  //           color: Theme.of(context).primaryColor,
  //         ),
  //         const SizedBox(width: 5),
  //         Text(
  //           '$label $text',
  //           style: const TextStyle(fontSize: 15),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

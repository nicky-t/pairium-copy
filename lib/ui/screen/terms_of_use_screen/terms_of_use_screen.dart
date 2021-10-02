import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const TermsOfUseScreen(),
    );
  }

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const policyUrl = 'https://pairium.web.app';

    return Scaffold(
      appBar: AppBar(
        title: Text('アプリ情報',
            style: theme.textTheme.headline6
                ?.copyWith(fontFamily: IFonts().kCabin)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 52),
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  image: DecorationImage(
                      image: AssetImage('assets/icons/icon-prod.png')),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              kAppName,
              style: theme.textTheme.headline5
                  ?.copyWith(fontFamily: IFonts().kAppTitle, fontSize: 26),
            ),
            Text(
              _packageInfo.version,
              style: theme.textTheme.bodyText2,
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _launchUrl(policyUrl),
              child: const Text(
                '規約とプライバシーポリシー',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw UnimplementedError('Could not launch $url');
    }
  }
}

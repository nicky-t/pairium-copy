// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class EnvironmentConfirmScreen extends StatefulWidget {
  @override
  _EnvironmentConfirmScreenState createState() =>
      _EnvironmentConfirmScreenState();
}

class _EnvironmentConfirmScreenState extends State<EnvironmentConfirmScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    _initPackageInfo();
    super.initState();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('開発環境確認画面'),
      ),
      body: Column(
        children: [
          _infoTile('Build Mode', kReleaseMode ? 'Release' : 'Debug'),
          _infoTile('App name', _packageInfo.appName),
          _infoTile('Package name', _packageInfo.packageName),
          _infoTile('App version', _packageInfo.version),
          _infoTile('Build number', _packageInfo.buildNumber),
          // FirestoreEnvironmentConfirm(),
        ],
      ),
    );
  }
}

// class FirestoreEnvironmentConfirm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('test').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return const CircularProgressIndicator();
//           case ConnectionState.active:
//             return Text('環境: ${snapshot.data?.docs[0].get('name')}');
//           case ConnectionState.done:
//           case ConnectionState.none:
//         }
//         return Container();
//       },
//     );
//   }
// }

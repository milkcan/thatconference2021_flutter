import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tabletop_scanner/main.dart';
import 'package:tabletop_scanner/screens/games.dart';
import 'package:tabletop_scanner/screens/users.dart';
import 'package:tabletop_scanner/utilities/interactions.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

const textstyleMenuTitle =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white);

class _MenuScreenState extends State<MenuScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 120,
            child: DrawerHeader(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: textstyleMenuTitle,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Column(children: [
              ListTile(
                title: const Text('Rentals'),
                onTap: () => openScreen(MyHomePage(), context),
              ),
              ListTile(
                title: const Text('Games'),
                onTap: () => openScreen(GamesScreen(), context),
              ),
              ListTile(
                title: const Text('Users'),
                onTap: () => openScreen(UsersScreen(), context),
              ),
            ])),
          ),
          Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: <Widget>[
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('v' + _packageInfo.version),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

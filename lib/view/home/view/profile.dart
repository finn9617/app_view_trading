import 'package:app_view_trading/view/home/view/google_sigin.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: '0',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();

    googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      setState(() {});
    });
  }

  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        '308049859709-qd7hu9emhofrucldtboqfuciuq2im6gj.apps.googleusercontent.com',
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  Future<void> handleSignIn() async {
    try {
      GoogleSignInAccount? user = await googleSignIn.signIn();
      print(user);
      Navigator.pop(context);
    } catch (error) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInDemo(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.network(
                      "https://picsum.photos/200",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Nguyễn Văn A",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Loadding(context);
                handleSignIn();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Image.asset("assets/ic_google.png", width: 30, height: 30),
                    const Text(
                      "Login with Google",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Colors.white, width: 1),
                  top: BorderSide(color: Colors.white, width: 1),
                )),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "About",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )),
            Container(
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Colors.white, width: 1),
                )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        Loadding(context);
                        await googleSignIn.signOut();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                "Version: ${packageInfo.version}",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> Loadding(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => const Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}

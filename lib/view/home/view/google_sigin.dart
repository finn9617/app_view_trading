// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:app_view_trading/view/home/service/authentication.dart';
import 'package:app_view_trading/view/home/view/about.dart';
import 'package:app_view_trading/view/home/view/user_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// The SignInDemo app.
class SignInDemo extends StatefulWidget {
  ///
  const SignInDemo({super.key});

  @override
  State createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  UserApp? currentUser;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: '0',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  Future<void> initUser() async {
    String? email = await storage.read(key: "email");
    String? displayName = await storage.read(key: "displayName");
    String? photoURL = await storage.read(key: "photoURL");
    setState(() {
      if ((displayName ?? "").isNotEmpty) {
        currentUser =
            UserApp(email: email, displayName: displayName, photoURL: photoURL);
      }
    });
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

  Widget _buildBody() {
    final UserApp? user = currentUser;
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            if (user != null)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 80.0),
                    user.photoURL != null
                        ? ClipOval(
                            child: Material(
                              color: Colors.white.withOpacity(0.3),
                              child: Image.network(
                                user.photoURL!,
                                fit: BoxFit.fitHeight,
                                errorBuilder: (context, _, __) {
                                  return ClipOval(
                                    child: Material(
                                      color: Colors.white.withOpacity(0.3),
                                      child: const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : ClipOval(
                            child: Material(
                              color: Colors.white.withOpacity(0.3),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Hello',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      user.displayName ?? "",
                      style: const TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '( ${user.email} )',
                      style: const TextStyle(
                        fontSize: 20,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'You are now signed in using your Google account. To sign out of your account click the "Sign Out" button below.',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          letterSpacing: 0.2),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const About()),
                        );
                      },
                      child: Container(
                          width: 200,
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await Authentication.signOut(context: context);
                        setState(() {
                          currentUser = null;
                        });
                      },
                      child: const Text('SIGN OUT'),
                    ),
                  ],
                ),
              ),
            if (user == null)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const Spacer(),
                    const Text(
                      "Log in to receive the latest news notifications from us",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            Loadding(context);
                            final account =
                                await Authentication.signInWithGoogle(
                                    context: context);
                            Navigator.pop(context);
                            currentUser = UserApp(
                                displayName: account?.displayName,
                                email: account?.email,
                                photoURL: account?.photoURL);
                            storage.write(
                                key: "email", value: account?.email.toString());
                            storage.write(
                                key: "displayName",
                                value: account?.displayName.toString());
                            storage.write(
                                key: "photoURL",
                                value: account?.photoURL.toString());
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Image.asset("assets/ic_google.png",
                                    width: 30, height: 30),
                                const Text(
                                  "Login with Google",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const About()),
                        );
                      },
                      child: Container(
                          width: 200,
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
                    ),
                  ],
                ),
              ),
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

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}

class UserApp {
  UserApp({this.email, this.displayName, this.photoURL});

  final String? email;
  final String? displayName;
  final String? photoURL;
}

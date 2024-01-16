import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orgasync/src/fetaures/auth/auth.dart';
import 'package:orgasync/src/utils/extensions/page_function.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage_client.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    log("🚀 SplashScreen", name: "SplashScreen");
    try {
      Future.delayed(const Duration(seconds: 1), () {
        ref.read(storageProvider).read("token").then((value) {
          if (value != null) {
            log(value);
            ref.read(refreshNotifier.notifier).refresh().then((success) {
              if (success) {
                nextPageRemoveAll(context, "/");
              } else {
                nextPageRemoveAll(context, "/login");
              }
            });
          } else {
            nextPageRemoveAll(context, "/login");
          }
        });
      });
    } catch (e) {
      log(e.toString(), error: e, name: "SplashScreen");
      nextPageRemoveAll(context, "/login");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 20,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage("assets/images/app_logo.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

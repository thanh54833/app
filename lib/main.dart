import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main.dart';

export 'package:flutter_module/src/entry_point/home/home_entry_point.dart';

///_____________________________________________________________________________
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await ScreenUtil.ensureScreenSize();
  HttpOverrides.global = OmicallHttpOverrides();

  return HomeEntryPoint().main();
}

class OmicallHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) {
        return true;
      };
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) =>
          true;
  }
}

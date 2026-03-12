import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_links/app_links.dart';
import 'app/app.dart';
import 'app/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: DigitalCassetteApp()));
}

void initDeepLinks(AppLinks appLinks, routerRef) {
  appLinks.uriLinkStream.listen((uri) {
    // digitalcassette://unlock/ABC123
    if (uri.scheme == 'digitalcassette' && uri.host == 'unlock') {
      final code = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      if (code != null) {
        routerRef.go('/unlock/$code');
      }
    }
  });
}

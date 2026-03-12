import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_links/app_links.dart';
import '../core/theme/app_theme.dart';
import 'router.dart';

class DigitalCassetteApp extends ConsumerStatefulWidget {
  const DigitalCassetteApp({super.key});

  @override
  ConsumerState<DigitalCassetteApp> createState() => _DigitalCassetteAppState();
}

class _DigitalCassetteAppState extends ConsumerState<DigitalCassetteApp> {
  final _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  void _initDeepLinks() {
    _appLinks.uriLinkStream.listen((uri) {
      // Handle: digitalcassette://unlock/ABC123
      if (uri.scheme == 'digitalcassette' && uri.host == 'unlock') {
        final segments = uri.pathSegments;
        final code = segments.isNotEmpty ? segments.first : null;
        if (code != null) {
          ref.read(routerProvider).go('/unlock/$code');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Digital Cassette',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}

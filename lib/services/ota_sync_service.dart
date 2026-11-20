import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// Service responsible for Dynamic Asset & Data Synchronization (OTA Content Update).
/// Silently checks remote GitHub repository for updated JSON files and UI assets.
class OtaSyncService {
  // Remote manifest URL hosted on GitHub raw content
  static const String manifestUrl =
      'https://raw.githubusercontent.com/ryk3r-t/vietschool-app/main/ota/manifest.json';

  /// Runs silently in background on app startup
  static Future<void> syncContent() async {
    try {
      final docDir = await getApplicationDocumentsDirectory();
      final otaDir = Directory('${docDir.path}/ota');
      if (!await otaDir.exists()) {
        await otaDir.create(recursive: true);
      }

      final localManifestFile = File('${otaDir.path}/manifest.json');

      // 1. Fetch remote manifest
      final response = await http
          .get(Uri.parse(manifestUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        debugPrint('[OTA] Remote manifest returned ${response.statusCode}');
        return;
      }

      final remoteManifest =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final int remoteVersion = remoteManifest['version'] ?? 0;

      // 2. Read local manifest version
      int localVersion = 0;
      if (await localManifestFile.exists()) {
        try {
          final localData = jsonDecode(await localManifestFile.readAsString());
          localVersion = localData['version'] ?? 0;
        } catch (_) {}
      }

      debugPrint('[OTA] Local version: $localVersion, Remote version: $remoteVersion');

      if (remoteVersion <= localVersion) {
        debugPrint('[OTA] Content is already up to date.');
        return;
      }

      // 3. Download updated data files (JSONs)
      final List dataFiles = remoteManifest['data_files'] ?? [];
      for (final item in dataFiles) {
        final String name = item['name'];
        final String url = item['url'];
        try {
          final fileRes = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
          if (fileRes.statusCode == 200) {
            final target = File('${otaDir.path}/$name');
            await target.writeAsBytes(fileRes.bodyBytes);
            debugPrint('[OTA] Successfully synced: $name');
          }
        } catch (e) {
          debugPrint('[OTA] Failed downloading $name: $e');
        }
      }

      // 4. Download updated assets (Images/Icons)
      final List assets = remoteManifest['assets'] ?? [];
      final assetsDir = Directory('${otaDir.path}/assets');
      if (!await assetsDir.exists()) {
        await assetsDir.create(recursive: true);
      }

      for (final item in assets) {
        final String name = item['name'];
        final String url = item['url'];
        try {
          final assetRes = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
          if (assetRes.statusCode == 200) {
            final target = File('${assetsDir.path}/$name');
            await target.writeAsBytes(assetRes.bodyBytes);
            debugPrint('[OTA] Successfully synced asset: $name');
          }
        } catch (e) {
          debugPrint('[OTA] Failed downloading asset $name: $e');
        }
      }

      // 5. Update local manifest
      await localManifestFile.writeAsString(jsonEncode(remoteManifest));
      debugPrint('[OTA] Synchronization completed! Updated to version $remoteVersion');
    } catch (e) {
      debugPrint('[OTA] Background sync error: $e');
    }
  }

  /// Get local cached JSON data, returns null if not available
  static Future<Map<String, dynamic>?> getLocalJson(String filename) async {
    try {
      final docDir = await getApplicationDocumentsDirectory();
      final file = File('${docDir.path}/ota/$filename');
      if (await file.exists()) {
        final content = await file.readAsString();
        return jsonDecode(content) as Map<String, dynamic>;
      }
    } catch (e) {
      debugPrint('[OTA] Error reading local JSON $filename: $e');
    }
    return null;
  }

  /// Get local cached asset file, returns null if not available
  static Future<File?> getLocalAsset(String assetName) async {
    try {
      final docDir = await getApplicationDocumentsDirectory();
      final file = File('${docDir.path}/ota/assets/$assetName');
      if (await file.exists()) {
        return file;
      }
    } catch (e) {
      debugPrint('[OTA] Error reading asset $assetName: $e');
    }
    return null;
  }
}

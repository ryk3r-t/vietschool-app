import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common.dart';
import 'services/ota_sync_service.dart';
import 'screens/home_screen.dart';
import 'screens/public_service_screen.dart';
import 'screens/elearning_screen.dart';
import 'screens/quick_exercise_screen.dart';
import 'screens/functions_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Trigger silent OTA content & asset synchronization in background
  OtaSyncService.syncContent();
  runApp(const VietSchoolApp());
}

class VietSchoolApp extends StatelessWidget {
  const VietSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VietSchool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: kTeal, useMaterial3: true, scaffoldBackgroundColor: kBg),
      home: const SplashScreen(),
    );
  }
}

/// Splash screen showing the logo.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainMenu()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset('logo.jpg', width: 160),
          const SizedBox(height: 16),
          const Text('VietSchool', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kTealDark)),
        ]),
      ),
    );
  }
}

/// Main menu with the 5-tab bottom navigation.
class MainMenu extends StatefulWidget {
  const MainMenu({super.key});
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _index = 0;

  static const _tabs = [
    (Icons.home_outlined, 'Trang chủ'),
    (Icons.account_balance_outlined, 'Dịch vụ công'),
    (Icons.menu_book_outlined, 'Elearning'),
    (Icons.edit_note, 'Bài tập nhanh'),
    (Icons.grid_view, 'Chức năng'),
  ];

  static const _pages = [
    HomeScreen(),
    PublicServiceScreen(),
    ElearningScreen(),
    QuickExerciseScreen(),
    FunctionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: IndexedStack(index: _index, children: _pages),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE5E5E5))),
          ),
          padding: EdgeInsets.only(top: 6, bottom: 6 + MediaQuery.of(context).padding.bottom),
          child: Row(
            children: List.generate(_tabs.length, (i) {
              final selected = i == _index;
              final color = selected ? kNavSelected : kNavIdle;
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _index = i),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      width: 52,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selected ? const Color(0xFFE2F4F6) : null,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(_tabs[i].$1, color: color, size: 30),
                    ),
                    const SizedBox(height: 2),
                    Text(_tabs[i].$2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.5, color: color)),
                  ]),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

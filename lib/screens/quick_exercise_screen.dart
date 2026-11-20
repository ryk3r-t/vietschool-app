import 'package:flutter/material.dart';
import '../common.dart';

/// Tab 4 – Bài tập nhanh (quick exercises).
class QuickExerciseScreen extends StatelessWidget {
  const QuickExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBg,
      child: Column(children: [
        Container(
          color: kTeal,
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 20, 16, 24),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Chào buổi sáng 👋',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0.3)),
                SizedBox(height: 8),
                Text('Có 0 bài đang diễn ra, 0 bài sắp đến hạn!',
                    style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
              ]),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.sync_rounded, color: Colors.white, size: 22)
              ),
            ),
          ]),
        ),
        Expanded(
          child: Stack(children: [
            Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))
                    ]
                  ),
                  child: const Text('?', style: TextStyle(fontSize: 64, fontWeight: FontWeight.w900, color: Color(0xFFD1D5DB), height: 1)),
                ),
                const SizedBox(height: 24),
                const Text('Bạn chưa tham gia nhóm nào',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF9CA3AF))),
              ]),
            ),
            const Positioned(right: 0, top: 0, bottom: 0, child: Center(child: SideTab())),
          ]),
        ),
      ]),
    );
  }
}
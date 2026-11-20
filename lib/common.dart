import 'package:flutter/material.dart';

/// Shared colors.
const kTeal = Color(0xFF4BBCC4);
const kTealDark = Color(0xFF1E8C9A);
const kNavSelected = Color(0xFF3AAFB9);
const kNavIdle = Color(0xFF3A4556);
const kBg = Color(0xFFF0F1F4);
const kBgTeal = Color(0xFFE8F1F3);

/// Teal top bar with back arrow, avatar, student name and class
/// (used by "Dịch vụ công" and "Chức năng").
class StudentAppBar extends StatelessWidget {
  final String name;
  final String className;
  const StudentAppBar({super.key, this.name = 'TRẦN NG...NH QUÂN', this.className = '12A13'});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kTeal,
      padding: EdgeInsets.fromLTRB(8, MediaQuery.of(context).padding.top + 10, 16, 14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 6),
        const CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, color: Colors.grey, size: 26),
        ),
        const SizedBox(width: 14),
        Flexible(
          child: Text(name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 24),
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(className, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ),
      ]),
    );
  }
}

/// Small half-circle tab on the right edge with a "<" chevron.
class SideTab extends StatelessWidget {
  const SideTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(25)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: const Icon(Icons.chevron_left, color: kTealDark, size: 32),
    );
  }
}

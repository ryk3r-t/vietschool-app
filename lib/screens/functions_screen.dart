import 'package:flutter/material.dart';
import '../common.dart';
import 'conduct_screen.dart';
import 'grades_screen.dart';
import 'timetable_screen.dart';
import 'teaching_assignment_screen.dart';
import 'teaching_schedule_screen.dart';
import 'boarding_meal_screen.dart';
import 'attendance_screen.dart';
import 'update_info_screen.dart';
import 'academic_transcript_screen.dart';
import 'exam_subjects_screen.dart';
import 'edit_favorites_screen.dart'; // Đã thêm màn hình chỉnh sửa yêu thích

/// Tab 5 – Chức năng (features grid).
class FunctionsScreen extends StatelessWidget {
  // Callback để gọi hàm chuyển tab từ màn hình cha khi nhấn "Học online"
  final VoidCallback? onSwitchToElearning;

  const FunctionsScreen({super.key, this.onSwitchToElearning});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7F9), // Nền xám xanh sáng, hiện đại
      child: Column(children: [
        const StudentAppBar(),
        Expanded(
          child: Stack(children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              children: [
                _Section(
                  title: 'Yêu thích',
                  icon: Icons.favorite_rounded,
                  iconColor: const Color(0xFFF472B6), // Màu hồng pastel
                  favorite: true,
                  onSwitchToElearning: onSwitchToElearning,
                  items: const [
                    _Item('Xem điểm', Icons.manage_search_rounded, Color(0xFF3B82F6)),
                    _Item('Xem TKB', Icons.calendar_month_rounded, Color(0xFF0EA5E9)),
                  ],
                ),
                _Section(
                  title: 'Học tập',
                  icon: Icons.school_rounded,
                  iconColor: const Color(0xFF6366F1), // Indigo nhạt
                  onSwitchToElearning: onSwitchToElearning,
                  items: const [
                    _Item('Xem điểm', Icons.manage_search_rounded, Color(0xFF3B82F6)),
                    _Item('Hạnh kiểm', Icons.workspace_premium_rounded, Color(0xFF10B981)),
                    _Item('Xem học bạ', Icons.menu_book_rounded, Color(0xFF059669)),
                    _Item('Chọn môn TN', Icons.fact_check_rounded, Color(0xFF0D9488)),
                  ],
                ),
                _Section(
                  title: 'Lịch',
                  icon: Icons.event_note_rounded,
                  iconColor: const Color(0xFFEF4444), // Đỏ pastel
                  onSwitchToElearning: onSwitchToElearning,
                  items: const [
                    _Item('Xem PC dạy', Icons.event_available_rounded, Color(0xFF0EA5E9)),
                    _Item('Xem báo giảng', Icons.event_note_rounded, Color(0xFF0EA5E9)),
                    _Item('Xem TKB', Icons.calendar_month_rounded, Color(0xFF0EA5E9)),
                  ],
                ),
                _Section(
                  title: 'Bán trú',
                  icon: Icons.apartment_rounded,
                  iconColor: const Color(0xFFF59E0B), // Cam pastel
                  onSwitchToElearning: onSwitchToElearning,
                  items: const [_Item('Suất ăn bán trú', Icons.rice_bowl_rounded, Color(0xFFEF4444))],
                ),
                _Section(
                  title: 'Online',
                  icon: Icons.devices_rounded,
                  iconColor: const Color(0xFF14B8A6), // Teal
                  onSwitchToElearning: onSwitchToElearning,
                  items: const [_Item('Học online', Icons.important_devices_rounded, Color(0xFF2563EB))],
                ),
                _Section(
                  title: 'Khác',
                  icon: Icons.grid_view_rounded,
                  iconColor: const Color(0xFFA855F7), // Tím pastel
                  onSwitchToElearning: onSwitchToElearning,
                  items: const [
                    _Item('Điểm danh', Icons.face_retouching_natural_rounded, Color(0xFF0EA5E9)),
                    _Item('Cập nhật TT', Icons.badge_rounded, Color(0xFFEF4444)),
                    _Item('Bài tập nhanh', Icons.calculate_rounded, Color(0xFF2563EB)),
                  ],
                ),
              ],
            ),
            const Positioned(right: 0, top: 360, child: SideTab()),
          ]),
        ),
      ]),
    );
  }
}

class _Item {
  final String label;
  final IconData icon;
  final Color color;
  const _Item(this.label, this.icon, this.color);
}

class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<_Item> items;
  final bool favorite;
  final VoidCallback? onSwitchToElearning;

  const _Section({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.items,
    this.favorite = false,
    this.onSwitchToElearning,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(20), // Bo góc mềm mại
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 4))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1F2937))),
          ),
          // Nếu là phần Yêu thích thì hiện icon chỉnh sửa có thể bấm được
          if (favorite) 
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const EditFavoritesScreen()));
              },
              child: Container(
                padding: const EdgeInsets.all(4), // Tăng vùng bấm để dễ thao tác
                child: const Icon(Icons.tune_rounded, color: Color(0xFF9CA3AF), size: 22),
              ),
            ),
        ]),
        const SizedBox(height: 20),
        LayoutBuilder(builder: (context, c) {
          final w = c.maxWidth / 3;
          return Wrap(
            runSpacing: 16,
            children: items
                .map((it) => SizedBox(
                      width: w,
                      child: _Tile(
                        item: it,
                        favorite: favorite,
                        onSwitchToElearning: onSwitchToElearning,
                      ),
                    ))
                .toList(),
          );
        }),
      ]),
    );
  }
}

class _Tile extends StatelessWidget {
  final _Item item;
  final bool favorite;
  final VoidCallback? onSwitchToElearning;

  const _Tile({required this.item, required this.favorite, this.onSwitchToElearning});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashColor: item.color.withOpacity(0.1),
      highlightColor: Colors.transparent,
      onTap: () {
        if (item.label == 'Hạnh kiểm') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ConductScreen()));
        } else if (item.label == 'Xem điểm') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const GradesScreen()));
        } else if (item.label == 'Xem TKB') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const TimetableScreen()));
        } else if (item.label == 'Xem PC dạy') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const TeachingAssignmentScreen()));
        } else if (item.label == 'Xem báo giảng') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const TeachingScheduleScreen()));
        } else if (item.label == 'Suất ăn bán trú') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const BoardingMealScreen()));
        } else if (item.label == 'Điểm danh') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AttendanceScreen()));
        } else if (item.label == 'Cập nhật TT') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const UpdateInfoScreen()));
        } else if (item.label == 'Xem học bạ') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AcademicTranscriptScreen()));
        } else if (item.label == 'Chọn môn TN' || item.label == 'Chọn môn thi TN') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ExamSubjectsScreen()));
        } else if (item.label == 'Học online') {
          if (onSwitchToElearning != null) onSwitchToElearning!();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(
                  title: Text(item.label),
                  backgroundColor: const Color(0xFF45B0A8),
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Chức năng "${item.label}"\nđang được cập nhật.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
      child: Column(children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: favorite ? const Color(0xFFFFF1F2) : const Color(0xFFF0F9FF), // Tách màu nền tùy loại
            borderRadius: BorderRadius.circular(16),
            // Đổ bóng siêu nhẹ thay cho viền cứng
            boxShadow: [
              BoxShadow(color: item.color.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4))
            ]
          ),
          child: Icon(item.icon, color: item.color, size: 28),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(item.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF4B5563), height: 1.2)),
        ),
      ]),
    );
  }
}
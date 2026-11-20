import 'package:flutter/material.dart';
import '../common.dart';

/// Tab 3 – Elearning ("Học Online").
class ElearningScreen extends StatefulWidget {
  const ElearningScreen({super.key});
  @override
  State<ElearningScreen> createState() => _ElearningScreenState();
}

// Model dữ liệu cho bài học (Dựa theo video thực tế)
class _Lesson {
  final String title, subject, className, range, teacher;
  final bool isEnded; // Kiểm tra xem bài học đã kết thúc chưa
  
  const _Lesson({
    required this.title,
    required this.subject,
    required this.className,
    required this.range,
    required this.teacher,
    this.isEnded = false,
  });
}

class _ElearningScreenState extends State<ElearningScreen> {
  int _filterIndex = 0;

  // Danh sách bộ lọc và màu sắc tương ứng
  static const _filters = [
    ('Tất cả', Color(0xFF1E6FD9)),
    ('Diễn ra', Color(0xFF0F766E)), // Teal
    ('Sắp tới', Color(0xFF10B981)), // Green
    ('Ngày mai', Color(0xFF10B981)), // Green
    ('Kết thúc', Color(0xFFDC2626)), // Red
  ];

  // Danh sách dữ liệu mẫu trích xuất từ video
  final List<_Lesson> _lessons = const [
    _Lesson(
      title: 'Đọc hiểu truyện và viết đoạn nghị luận (Chưa tạo đề)',
      subject: 'Ngữ văn',
      className: '12A13',
      range: '25/09 19:48 → 17/10 19:23',
      teacher: 'Trương Thị Hiếu',
    ),
    _Lesson(
      title: 'kiểm tra giữa kỳ 1 (Chưa tạo đề)',
      subject: 'GDQP',
      className: '12A13',
      range: '05/10 14:23 → 23/10 14:23',
      teacher: 'Huỳnh Văn Thà',
    ),
    _Lesson(
      title: 'Tri thức Ngữ văn bài 1 (Chưa tạo đề)',
      subject: 'Ngữ văn',
      className: '12A13',
      range: '25/09 19:23 → 31/10 19:23',
      teacher: 'Trương Thị Hiếu',
    ),
    _Lesson(
      title: 'SỰ CHUYỂN THỂ (Chưa tạo đề)',
      subject: 'Vật lí',
      className: '12A13',
      range: '25/09 17:56 → 25/05 17:56',
      teacher: 'Lê Thị Trúc Lâm',
    ),
    _Lesson(
      title: 'BÀI 2. NỘI NĂNG (Chưa tạo đề)',
      subject: 'Vật lí',
      className: '12A13',
      range: '25/09 18:10 → 25/05 18:10',
      teacher: 'Lê Thị Trúc Lâm',
    ),
    // Các bài đã kết thúc (màu đỏ)
    _Lesson(
      title: 'LUYỆN TẬP BÀI 1 - LIÊN HỢP QUỐC (Chưa tạo đề)',
      subject: 'Lịch sử',
      className: '12A13',
      range: '24/09 10:35 → 03/10 11:00',
      teacher: 'Huỳnh Thị Hà',
      isEnded: true,
    ),
    _Lesson(
      title: 'LUYỆN TẬP BÀI 2 - TTTG TRONG CHIẾN TRANH LẠNH (Chưa tạo đề)',
      subject: 'Lịch sử',
      className: '12A13',
      range: '24/09 10:32 → 03/10 11:00',
      teacher: 'Huỳnh Thị Hà',
      isEnded: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7F9), // Nền xám xanh nhạt, sang trọng
      child: Column(children: [
        // 1. App Bar
        Container(
          color: kTeal,
          padding: EdgeInsets.fromLTRB(8, MediaQuery.of(context).padding.top + 8, 8, 12),
          child: Row(children: [
            IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 4),
            const Expanded(
              child: Text(
                'Học Online - T.N.M.QUÂN',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            ),
          ]),
        ),

        // 2. Chọn khoảng thời gian & Nút làm mới
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))
                  ],
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.chevron_left_rounded, color: Color(0xFF6B7280), size: 28),
                  ),
                  const Expanded(
                    child: Text(
                      'Trong 30 ngày',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF374151)),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.chevron_right_rounded, color: Color(0xFF6B7280), size: 28),
                  ),
                ]),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))
                ],
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.refresh_rounded, color: Color(0xFF6B7280), size: 24),
              ),
            ),
          ]),
        ),

        // 3. Bộ lọc (Radio style)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 16, // Khoảng cách ngang giữa các item
            runSpacing: 12, // Khoảng cách dọc khi rớt dòng
            children: List.generate(_filters.length, (i) {
              final isSelected = i == _filterIndex;
              final color = _filters[i].$2;
              return GestureDetector(
                onTap: () => setState(() => _filterIndex = i),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Vẽ nút Radio custom
                    Container(
                      width: 20,
                      height: 20,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: isSelected ? color : Colors.grey.shade400, width: 2),
                      ),
                      child: isSelected
                          ? Container(
                              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _filters[i].$1,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? color : const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),

        // 4. Thanh tìm kiếm
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: TextField(
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Tìm theo môn, giáo viên, bài học',
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
              prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF9CA3AF), size: 22),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kTeal),
              ),
            ),
          ),
        ),

        // 5. Danh sách bài học
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            itemCount: _lessons.length,
            itemBuilder: (_, i) => _LessonCard(lesson: _lessons[i]),
          ),
        ),
      ]),
    );
  }
}

class _LessonCard extends StatelessWidget {
  final _Lesson lesson;
  const _LessonCard({required this.lesson});

  @override
  Widget build(BuildContext context) {
    // Định nghĩa màu sắc theo trạng thái (Đang diễn ra vs Đã kết thúc)
    final Color titleColor = lesson.isEnded ? const Color(0xFFB91C1C) : const Color(0xFF0F766E); // Đỏ sậm hoặc Teal
    final Color statusColor = lesson.isEnded ? const Color(0xFF6B7280) : const Color(0xFF0F766E);
    const Color grayText = Color(0xFF6B7280);
    const TextStyle detailStyle = TextStyle(fontSize: 13, color: grayText);
    
    // Icon kim cương nhỏ làm dải phân cách
    const Widget diamondSeparator = Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Icon(Icons.diamond, size: 8, color: Color(0xFFF59E0B)),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Hàng 1: Tiêu đề + Trạng thái
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                lesson.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: titleColor, height: 1.3),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              lesson.isEnded ? 'Đã kết thúc' : 'Đang diễn ra',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: statusColor),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Hàng 2: Môn học - Lớp - Thời gian
        Row(
          children: [
            SizedBox(
              width: 80, // Cố định chiều rộng cho tên môn học để thẳng hàng
              child: Text(lesson.subject, style: detailStyle),
            ),
            Text(lesson.className, style: detailStyle),
            diamondSeparator,
            Expanded(
              child: Text(lesson.range, style: detailStyle, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Hàng 3: Loại - Giáo viên - Checkbox
        Row(
          children: [
            const Icon(Icons.description_outlined, size: 16, color: grayText),
            const SizedBox(width: 6),
            const Text('Bài học', style: detailStyle),
            diamondSeparator,
            Expanded(
              child: Text(lesson.teacher, style: detailStyle, overflow: TextOverflow.ellipsis),
            ),
            // Vòng tròn nhỏ ở góc dưới bên phải
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
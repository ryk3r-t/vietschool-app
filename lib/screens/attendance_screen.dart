import 'package:flutter/material.dart';

// Lớp chứa dữ liệu cho từng mục chức năng
class _AttendanceFeature {
  final String title;
  final IconData icon;
  final Color iconColor;

  _AttendanceFeature(this.title, this.icon, this.iconColor);
}

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF45B0A8); // Màu xanh chủ đạo của AppBar
    const Color backgroundColor = Color(0xFFF4F6F8); // Màu nền xám nhạt

    // Danh sách các chức năng (Sử dụng icon gần giống nhất với hình)
    final List<_AttendanceFeature> features = [
      _AttendanceFeature('Điểm danh\ncá nhân', Icons.document_scanner_outlined, const Color(0xFF1E88E5)),
      _AttendanceFeature('Đăng ký\ngương mặt', Icons.assignment_ind_outlined, const Color(0xFF424242)),
      _AttendanceFeature('Lịch sử\nđiểm danh', Icons.manage_search_outlined, const Color(0xFF00695C)),
      _AttendanceFeature('Xem ảnh\nđăng ký', Icons.image_search_outlined, const Color(0xFF424242)),
      _AttendanceFeature('Thông báo\nđiểm danh', Icons.mark_chat_unread_outlined, const Color(0xFF0288D1)),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'VietSchool - T.N.M.Q...', // Tiêu đề bị cắt ngắn giống trong hình
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Xử lý khi bấm nút hướng dẫn
            },
            child: const Text(
              'HƯỚNG DẪN',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Để container ôm vừa nội dung
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Icon mũ cử nhân + Chữ "Học sinh"
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    Icon(Icons.school, color: Colors.grey.shade700, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'Học sinh',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),

              // Grid chứa các nút chức năng
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Chia làm 4 cột giống như trong hình ảnh
                    final double itemWidth = constraints.maxWidth / 4;
                    
                    return Wrap(
                      runSpacing: 20.0, // Khoảng cách giữa các hàng
                      children: features.map((feature) {
                        return SizedBox(
                          width: itemWidth,
                          child: _buildFeatureItem(feature),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Widget vẽ từng mục chức năng
  Widget _buildFeatureItem(_AttendanceFeature feature) {
    return InkWell(
      onTap: () {
        // Xử lý sự kiện khi bấm vào từng mục cụ thể
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon (Thay vì ảnh, ta dùng Icon Material được bọc trong Container để có thiết kế phẳng)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // Tạo hiệu ứng bóng mờ rất nhẹ để icon nổi bật hơn 1 chút (tuỳ chọn)
            ),
            child: Icon(
              feature.icon,
              color: feature.iconColor,
              size: 32,
            ),
          ),
          const SizedBox(height: 8),
          // Tên chức năng
          Text(
            feature.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF555555),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

// Class chứa dữ liệu mẫu
class _AssignmentData {
  final String subject;
  final String className;
  final String teacher;

  _AssignmentData(this.subject, this.className, this.teacher);
}

class TeachingAssignmentScreen extends StatelessWidget {
  const TeachingAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF45B0A8); // Màu xanh chủ đạo

    // Dữ liệu mẫu trích xuất từ hình ảnh
    final List<_AssignmentData> data = [
      _AssignmentData('GV Chủ nhiệm', '12A13', 'Trương Thị Hiếu'),
      _AssignmentData('Toán', '12A13', 'Quách Huỳnh Hạnh'),
      _AssignmentData('Vật lí', '12A13', 'Lê Thị Trúc Lâm'),
      _AssignmentData('GDQP', '12A13', 'Huỳnh Văn Thà'),
      _AssignmentData('Ngữ văn', '12A13', 'Trương Thị Hiếu'),
      _AssignmentData('Lịch Sử', '12A13', 'Huỳnh Thị Hà'),
      _AssignmentData('Địa Lí', '12A13', 'Lê Thị Loan'),
      _AssignmentData('Ngoại ngữ', '12A13', 'Đinh Thị Thùy Anh'),
      _AssignmentData('Tin học', '12A13', 'Nguyễn Anh Tuấn'),
      _AssignmentData('GDTC', '12A13', 'Huỳnh Văn Thà'),
      _AssignmentData('GDKTPL', '12A13', 'Nguyễn Thị Hương'),
      _AssignmentData('Toán', '12T14', 'Nguyễn Thị Phương Thanh'),
      _AssignmentData('Âm nhạc', 'NHẠC 1_A12_A13', 'Vũ Nguyệt Anh'),
      _AssignmentData('Địa Lí', 'ĐỊA 1_A5_A13', 'Lê Thị Loan'),
    ];

    // Kích thước các cột
    const double subjectWidth = 110.0;
    const double classWidth = 120.0;
    const double teacherWidth = 220.0;
    const double cellHeight = 55.0;
    const double headerHeight = 50.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Phân công dạy - T.N.M.QUÂN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ),
      body: Column(
        children: [
          // Banner thông báo phía trên
          Container(
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F8F5), // Màu nền xanh nhạt
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.verified, color: Color(0xFF009688), size: 20), // Icon tích xanh
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Giáo viên có biểu tượng này là người phụ trách chính.',
                    style: TextStyle(color: Color(0xFF00796B), fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          // Phần bảng biểu
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Colors.grey.shade300, width: 1),
                      top: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // === CỘT TRÁI CỐ ĐỊNH (Môn) ===
                      Column(
                        children: [
                          _buildHeaderCell('Môn', width: subjectWidth, height: headerHeight, bgColor: primaryColor),
                          ...data.asMap().entries.map((entry) {
                            final int index = entry.key;
                            final isEven = index % 2 != 0; // Đảo lại so với index để khớp màu xen kẽ
                            return _buildTextCell(entry.value.subject, width: subjectWidth, height: cellHeight, isEven: isEven);
                          }),
                        ],
                      ),

                      // === CỘT PHẢI CÓ THỂ CUỘN NGANG (Lớp, HK1, HK2) ===
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Dòng tiêu đề
                              Row(
                                children: [
                                  _buildHeaderCell('Lớp', width: classWidth, height: headerHeight, bgColor: primaryColor),
                                  _buildHeaderCell('Học kỳ 1', width: teacherWidth, height: headerHeight, bgColor: primaryColor),
                                  _buildHeaderCell('Học kỳ 2', width: teacherWidth, height: headerHeight, bgColor: primaryColor),
                                ],
                              ),
                              // Các dòng dữ liệu
                              ...data.asMap().entries.map((entry) {
                                final int index = entry.key;
                                final isEven = index % 2 != 0;
                                final item = entry.value;
                                return Row(
                                  children: [
                                    _buildTextCell(item.className, width: classWidth, height: cellHeight, isEven: isEven),
                                    _buildTeacherCell(item.teacher, width: teacherWidth, height: cellHeight, isEven: isEven),
                                    _buildTeacherCell(item.teacher, width: teacherWidth, height: cellHeight, isEven: isEven),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget tạo ô tiêu đề
  Widget _buildHeaderCell(String text, {required double width, required double height, required Color bgColor}) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          right: BorderSide(color: Colors.grey.shade300, width: 1),
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Widget tạo ô chữ thường (cho cột Môn và Lớp)
  Widget _buildTextCell(String text, {required double width, required double height, required bool isEven}) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isEven ? const Color(0xFFF5F6F9) : Colors.white,
        border: Border(
          right: BorderSide(color: Colors.grey.shade300, width: 1),
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Color(0xFF333333), fontSize: 13),
      ),
    );
  }

  // Widget tạo ô giáo viên có bọc khung màu xanh nhạt (Pill)
  Widget _buildTeacherCell(String teacherName, {required double width, required double height, required bool isEven}) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isEven ? const Color(0xFFF5F6F9) : Colors.white,
        border: Border(
          right: BorderSide(color: Colors.grey.shade300, width: 1),
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFE0F2F1), // Màu nền pill
          borderRadius: BorderRadius.circular(20), // Bo tròn thành dạng pill
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Để khung co lại vừa đủ với chữ
          children: [
            Text(
              teacherName,
              style: const TextStyle(color: Color(0xFF00897B), fontSize: 13, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.verified, color: Color(0xFF00897B), size: 14),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class BoardingMealScreen extends StatefulWidget {
  const BoardingMealScreen({super.key});

  @override
  State<BoardingMealScreen> createState() => _BoardingMealScreenState();
}

class _BoardingMealScreenState extends State<BoardingMealScreen> {
  // Biến lưu trạng thái tab đang chọn (true = TKB suất ăn, false = Đăng ký suất ăn)
  bool isTkbSelected = true;
  
  // Biến lưu ngày hiện tại (thời gian thực)
  DateTime selectedDate = DateTime.now();

  // Hàm chuyển đổi DateTime sang chuỗi định dạng DD/MM/YYYY
  String get formattedDate {
    final day = selectedDate.day.toString().padLeft(2, '0');
    final month = selectedDate.month.toString().padLeft(2, '0');
    final year = selectedDate.year.toString();
    return '$day/$month/$year';
  }

  // Hàm hiển thị DatePicker khi người dùng bấm vào ô ngày tháng
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF246B73), // Màu chủ đạo của lịch
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF45B0A8); // Màu xanh AppBar
    const Color darkTealColor = Color(0xFF246B73); // Màu nút chọn tab
    const Color backgroundColor = Color(0xFFEFF3F5); // Màu nền xám/xanh nhạt

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'VietSchool - T.N.M.QUÂN',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Khối 1: Header chứa 2 nút tab và ô chọn ngày tháng
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                // Hàng nút Tab (TKB suất ăn / Đăng ký suất ăn)
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isTkbSelected = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isTkbSelected ? darkTealColor : const Color(0xFFF2F4F5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'TKB suất ăn',
                            style: TextStyle(
                              color: isTkbSelected ? Colors.white : Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isTkbSelected = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isTkbSelected ? darkTealColor : const Color(0xFFF2F4F5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Đăng ký suất ăn',
                            style: TextStyle(
                              color: !isTkbSelected ? Colors.white : Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Ô chọn ngày tháng
                InkWell(
                  onTap: () => _selectDate(context),
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formattedDate, // Ngày hiển thị theo thời gian thực
                          style: const TextStyle(fontSize: 15, color: Color(0xFF333333)),
                        ),
                        Icon(Icons.calendar_month, color: Colors.grey.shade500, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Khối 2: Khung trắng lớn chứa nội dung
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              // Nơi này sau sẽ hiển thị danh sách suất ăn
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
      
      // Bottom Navigation / Thanh thông báo ở dưới cùng
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Color(0xFFE6F3F5),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Row(
            children: [
              const Icon(Icons.info, color: darkTealColor),
              const SizedBox(width: 8),
              Text(
                'HS học 1 buổi (không được đăng ký)',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
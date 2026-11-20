import 'package:flutter/material.dart';

class AcademicTranscriptScreen extends StatelessWidget {
  const AcademicTranscriptScreen({super.key});

  // Hàm hiển thị hộp thoại thông báo
  void _showNoFileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0), // Bo góc nhẹ giống ảnh
          ),
          title: const Text(
            'Thông báo',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          content: const Text(
            'Chưa có file',
            style: TextStyle(color: Colors.black87, fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại khi bấm OK
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF45B0A8); // Màu AppBar
    const Color buttonColor = Color(0xFF246B73); // Màu xanh đậm của nút TẢI FILE

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'VietSchool - T.N.M.QUÂN',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trái
          children: [
            const SizedBox(height: 10),
            Text(
              'Loại tài liệu:',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),
            Text(
              'Niên học:',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 40),
            // Nút TẢI FILE căn giữa
            Center(
              child: ElevatedButton(
                onPressed: () => _showNoFileDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'TẢI FILE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

// Class chứa dữ liệu môn học
class Subject {
  final String name;
  bool isSelected;

  Subject(this.name, {this.isSelected = false});
}

class ExamSubjectsScreen extends StatefulWidget {
  const ExamSubjectsScreen({super.key});

  @override
  State<ExamSubjectsScreen> createState() => _ExamSubjectsScreenState();
}

class _ExamSubjectsScreenState extends State<ExamSubjectsScreen> {
  // Tạo danh sách 8 môn thi mẫu
  final List<Subject> _subjects = [
    Subject('Toán'),
    Subject('Ngữ văn'),
    Subject('Ngoại ngữ'),
    Subject('Vật lí'),
    Subject('Hóa học'),
    Subject('Sinh học'),
    Subject('Lịch sử'),
    Subject('Địa lí'),
  ];

  // Tính số lượng môn đã chọn
  int get _selectedCount => _subjects.where((s) => s.isSelected).length;

  // Hàm xử lý khi bấm nút "Chọn lại"
  void _resetSelection() {
    setState(() {
      for (var subject in _subjects) {
        subject.isSelected = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF45B0A8); // Màu teal chủ đạo
    const Color bgColor = Color(0xFFF4F6F8);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Chọn môn thi tốt nghiệp - T.N....',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              // Header: Danh sách môn thi + Tổng số môn
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Danh sách môn thi',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${_subjects.length} môn',
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: Colors.grey.shade200),
              
              // Sub-header: Đã chọn x/4 môn
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 16.0, bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Đã chọn $_selectedCount/4 môn',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                ),
              ),

              // Danh sách các môn thi có checkbox
              Expanded(
                child: ListView.builder(
                  itemCount: _subjects.length,
                  itemBuilder: (context, index) {
                    final subject = _subjects[index];
                    return CheckboxListTile(
                      title: Text(subject.name),
                      value: subject.isSelected,
                      activeColor: primaryColor,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                      onChanged: (bool? value) {
                        setState(() {
                          // Nếu đang muốn chọn thêm môn nhưng đã đủ 4 môn thì không cho chọn
                          if (value == true && _selectedCount >= 4) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Chỉ được chọn tối đa 4 môn.'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            return;
                          }
                          subject.isSelected = value ?? false;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // Thanh nút bấm dưới cùng
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              // Nút Chọn lại
              SizedBox(
                height: 45,
                width: 100, // Chiều rộng cố định cho nút nhỏ
                child: OutlinedButton(
                  onPressed: _resetSelection,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  child: const Text('Chọn lại'),
                ),
              ),
              const SizedBox(width: 12),
              // Nút Lưu lựa chọn
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý lưu ở đây
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đã lưu lựa chọn thành công!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    child: const Text('Lưu lựa chọn', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
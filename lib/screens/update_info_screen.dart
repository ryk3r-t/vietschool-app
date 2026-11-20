import 'package:flutter/material.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  // Danh sách các tab điều hướng ngang
  final List<String> _tabs = [
    'Cá nhân', 'Nơi sinh', 'Quê quán', 'Địa chỉ trường trú', 
    'Chỗ ở hiện tại', 'Cha', 'Mẹ', 'NGH', 'Chính sách'
  ];
  
  int _activeTabIndex = 0;
  bool _isFemale = false;
  bool _hasChipId = true;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF45B0A8); // Màu xanh chủ đạo
    const Color bgColor = Color(0xFFF4F6F8);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Cập nhật thông tin - T...',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'LÀM MỚI',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Thanh cuộn ngang chứa các Tab
          Container(
            color: primaryColor,
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _tabs.length,
              itemBuilder: (context, index) {
                final isActive = index == _activeTabIndex;
                return GestureDetector(
                  onTap: () => setState(() => _activeTabIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _tabs[index],
                      style: TextStyle(
                        color: isActive ? primaryColor : Colors.white,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 2. Nội dung biểu mẫu (Form) cuộn dọc
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // --- Khối 1: CÁ NHÂN ---
                  _buildSection(
                    title: 'Cá nhân',
                    children: [
                      _buildTextField('Họ', initialValue: 'TRẦN NGUYỄN MINH'),
                      _buildTextField('Tên', initialValue: 'QUÂN'),
                      _buildSwitch('Nữ', _isFemale, (val) => setState(() => _isFemale = val)),
                      _buildTextField('Ngày sinh', initialValue: '01/07/2009', icon: Icons.calendar_today),
                      _buildTextField('Quốc tịch', initialValue: 'Việt Nam'),
                      _buildTextField('Dân tộc', initialValue: 'Kinh'),
                      _buildTextField('Tôn giáo', initialValue: 'Không'),
                      _buildTextField('Số CCCD', initialValue: '079209016898'),
                      _buildSwitch('CCCD gắn chip', _hasChipId, (val) => setState(() => _hasChipId = val)),
                      _buildTextField('Ngày cấp', initialValue: '10/07/2023', icon: Icons.calendar_today),
                      _buildTextField('Nơi cấp', initialValue: 'CTCCSXQLHCVTTXH'),
                      _buildTextField('Điện thoại', hintText: 'Chưa nhập'),
                      _buildTextField('Email', hintText: 'Chưa nhập'),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // --- Khối 2: NƠI SINH ---
                  _buildSection(
                    title: 'Nơi sinh',
                    children: [
                      _buildTextField('Nơi sinh', labelText: 'Tỉnh / Thành phố', hintText: 'Chọn tỉnh'),
                      _buildTextField('', labelText: 'Quận / Huyện', hintText: 'Chọn huyện'),
                      _buildTextField('', labelText: 'Phường / Xã', hintText: 'Chọn xã'),
                      _buildTextField('Chi tiết', hintText: 'Chưa nhập'),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // --- Khối 3: CHA ---
                  _buildSection(
                    title: 'Cha',
                    children: [
                      _buildTextField('Tên cha', initialValue: 'TRẦN ĐÌNH DŨNG'),
                      _buildTextField('Điện thoại cha', hintText: 'Chưa nhập'),
                      _buildTextField('CCCD cha', hintText: 'Chưa nhập'),
                      _buildTextField('Năm sinh cha', initialValue: '1971'),
                      _buildTextField('Nghề cha', initialValue: 'CÔNG NHÂN'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // --- Khối 4: MẸ ---
                  _buildSection(
                    title: 'Mẹ',
                    children: [
                      _buildTextField('Tên mẹ', initialValue: 'NGUYỄN THỊ HƯƠNG'),
                      _buildTextField('Điện thoại mẹ', hintText: 'Chưa nhập'),
                      _buildTextField('Năm sinh mẹ', initialValue: '1972'),
                      _buildTextField('Nghề mẹ', initialValue: 'NỘI TRỢ'),
                    ],
                  ),
                  // Thêm padding trống phía dưới để không bị thanh Lưu che mất nội dung
                  const SizedBox(height: 80), 
                ],
              ),
            ),
          ),
        ],
      ),

      // 3. Thanh Lưu ở dưới cùng (Bottom Sheet cố định)
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F6F5), // Xanh nhạt
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Có thay đổi chưa lưu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text('Thông tin quan trọng sẽ được gửi khi bạn bấm Lưu.', style: TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Lưu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // --- Các hàm hỗ trợ xây dựng UI ---

  // Xây dựng 1 khối trắng (Card)
  Widget _buildSection({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  // Xây dựng ô nhập liệu (TextField)
  Widget _buildTextField(String topLabel, {String? labelText, String? hintText, String? initialValue, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (topLabel.isNotEmpty) ...[
            Text(topLabel, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
          ],
          TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF45B0A8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Xây dựng công tắc (Switch)
  Widget _buildSwitch(String label, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF45B0A8),
          ),
        ],
      ),
    );
  }
}
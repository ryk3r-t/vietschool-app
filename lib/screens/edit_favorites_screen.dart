import 'package:flutter/material.dart';

// Class chứa dữ liệu mục chức năng con
class FavoriteFeature {
  final String label;
  final IconData icon;
  final Color iconColor;
  bool isSelected;

  FavoriteFeature(this.label, this.icon, this.iconColor, {this.isSelected = false});
}

// Class chứa dữ liệu nhóm chức năng
class FavoriteCategory {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<FavoriteFeature> features;
  bool isExpanded;

  FavoriteCategory(this.title, this.icon, this.iconColor, this.features, {this.isExpanded = false});
}

class EditFavoritesScreen extends StatefulWidget {
  const EditFavoritesScreen({super.key});

  @override
  State<EditFavoritesScreen> createState() => _EditFavoritesScreenState();
}

class _EditFavoritesScreenState extends State<EditFavoritesScreen> {
  // Khởi tạo danh sách dữ liệu giống hệt với các tab trong hình và file functions_screen
  late List<FavoriteCategory> _categories;

  @override
  void initState() {
    super.initState();
    _categories = [
      FavoriteCategory('Học tập', Icons.star_border_rounded, const Color(0xFF3949AB), [
        FavoriteFeature('Xem điểm', Icons.manage_search_rounded, const Color(0xFF3B82F6)),
        FavoriteFeature('Hạnh kiểm', Icons.workspace_premium_rounded, const Color(0xFF10B981)),
        FavoriteFeature('Xem học bạ', Icons.menu_book_rounded, const Color(0xFF059669)),
        FavoriteFeature('Chọn môn thi TN', Icons.fact_check_rounded, const Color(0xFF0D9488)),
      ], isExpanded: true), // Mở sẵn tab Học tập theo hình minh hoạ
      FavoriteCategory('Lịch', Icons.calendar_today_outlined, const Color(0xFFC0392B), [
        FavoriteFeature('Xem PC dạy', Icons.event_available_rounded, const Color(0xFF0EA5E9)),
        FavoriteFeature('Xem báo giảng', Icons.event_note_rounded, const Color(0xFF0EA5E9)),
        FavoriteFeature('Xem TKB', Icons.calendar_month_rounded, const Color(0xFF0EA5E9)),
      ]),
      FavoriteCategory('Bán trú', Icons.apartment_rounded, const Color(0xFFB5A33A), [
        FavoriteFeature('Suất ăn bán trú', Icons.rice_bowl_rounded, const Color(0xFFEF4444)),
      ]),
      FavoriteCategory('Online', Icons.devices_rounded, const Color(0xFF26A69A), [
        FavoriteFeature('Học online', Icons.important_devices_rounded, const Color(0xFF2563EB)),
      ]),
      FavoriteCategory('Khác', Icons.grid_view_rounded, const Color(0xFF8E44AD), [
        FavoriteFeature('Điểm danh', Icons.face_retouching_natural_rounded, const Color(0xFF0EA5E9)),
        FavoriteFeature('Cập nhật TT', Icons.badge_rounded, const Color(0xFFEF4444)),
        FavoriteFeature('Bài tập nhanh', Icons.calculate_rounded, const Color(0xFF2563EB)),
      ]),
    ];
  }

  // Đếm tổng số chức năng đang được chọn
  int get _totalSelectedCount {
    int count = 0;
    for (var cat in _categories) {
      count += cat.features.where((f) => f.isSelected).length;
    }
    return count;
  }

  // Xử lý khi nhấn vào trái tim
  void _toggleFavorite(FavoriteFeature feature) {
    setState(() {
      if (feature.isSelected) {
        feature.isSelected = false; // Bỏ chọn thì luôn được
      } else {
        if (_totalSelectedCount >= 3) {
          // Báo lỗi nếu chọn quá 3 mục
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Chỉ được chọn tối đa 3 chức năng yêu thích.'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          feature.isSelected = true; // Cho phép chọn nếu chưa đủ 3
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF45B0A8); 
    const Color bgColor = Color(0xFFF4F7F9);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey, size: 20),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'TRẦN NG...NH QUÂN',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text('12A13', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Thẻ Header: Chức năng yêu thích + Nút Cập nhật
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.favorite_border_rounded, color: Color(0xFFD9817F), size: 24),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('Chức năng yêu thích',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Xử lý cập nhật và quay về trang trước
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đã cập nhật danh sách yêu thích!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      minimumSize: const Size(0, 36),
                    ),
                    child: const Text('Cập nhật', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Thẻ List: Danh sách Accordion
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                children: _categories.asMap().entries.map((entry) {
                  int index = entry.key;
                  FavoriteCategory category = entry.value;
                  bool isLast = index == _categories.length - 1;

                  return Column(
                    children: [
                      _buildCategoryTile(category),
                      if (category.isExpanded)
                        ...category.features.map((feature) => _buildFeatureItem(feature)).toList(),
                      if (!isLast) Divider(height: 1, color: Colors.grey.shade200, thickness: 1),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hiển thị Tiêu đề của một Nhóm (Học tập, Lịch...)
  Widget _buildCategoryTile(FavoriteCategory category) {
    int selectedInCat = category.features.where((f) => f.isSelected).length;
    int totalInCat = category.features.length;

    return InkWell(
      onTap: () {
        setState(() {
          category.isExpanded = !category.isExpanded;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(category.icon, color: category.iconColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(category.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4B5563))),
            ),
            Text('$selectedInCat/$totalInCat',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF6B7280))),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF45B0A8), width: 1.5),
              ),
              child: Icon(
                category.isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                color: const Color(0xFF45B0A8),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hiển thị từng mục con bên trong Nhóm (khi được mở rộng)
  Widget _buildFeatureItem(FavoriteFeature feature) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Row(
        children: [
          const SizedBox(width: 8), // Thụt lề một chút
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: feature.iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(feature.icon, color: feature.iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(feature.label,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1F2937))),
          ),
          IconButton(
            onPressed: () => _toggleFavorite(feature),
            icon: Icon(
              feature.isSelected ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: const Color(0xFFEF4444), // Màu đỏ của trái tim
              size: 26,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(), // Giảm khoảng trống mặc định của IconButton
          ),
        ],
      ),
    );
  }
}
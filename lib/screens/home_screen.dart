import 'package:flutter/material.dart';
import '../common.dart';

/// Tab 1 – Trang chủ (news feed).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7F9), // Màu nền xám xanh nhạt, hiện đại hơn
      child: Column(children: [
        const _Header(),
        Expanded(
          child: RefreshIndicator(
            color: const Color(0xFF4FB8C2),
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: _posts.isEmpty 
                ? _buildEmptyState() 
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 16), // Tăng lề 2 bên một chút
                    itemCount: _posts.length,
                    itemBuilder: (_, i) => _PostCard(post: _posts[i]),
                  ),
          ),
        ),
      ]),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 100),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))
                  ],
                ),
                child: const Icon(Icons.inbox_rounded, size: 72, color: Color(0xFFD1D8E0)),
              ),
              const SizedBox(height: 24),
              const Text(
                'Bảng tin chưa có bài viết',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kéo xuống để tải lại hoặc quay lại sau bạn nhé!',
                style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  Widget _circle(Widget child, {Color? bg}) {
    return Container(
      width: 44,
      height: 44,
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: bg ?? Colors.white.withOpacity(0.9), // Nền trắng hơi trong suốt
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))
        ],
      ),
      child: Center(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 8, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF4FB8C2), Color(0xFFD3F1F3), Color(0xFFF4F7F9)], // Chuyển màu mượt hơn
        ),
      ),
      child: Row(children: [
        const Spacer(),
        _circle(const Icon(Icons.notifications_active, color: Colors.white, size: 22), bg: const Color(0xFF22A650)),
        _circle(const Icon(Icons.filter_alt_outlined, color: Color(0xFF555555), size: 22)),
        _circle(const Icon(Icons.search, color: Color(0xFF555555), size: 22)),
        Stack(clipBehavior: Clip.none, children: [
          _circle(const Icon(Icons.chat_bubble_outline, color: Color(0xFF555555), size: 22)),
          Positioned(
            right: -2,
            bottom: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3), 
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white, width: 1.5), // Thêm viền trắng mỏng cho badge
              ),
              child: const Text('Chat', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
            ),
          ),
        ]),
      ]),
    );
  }
}

class _Post {
  final String initials, name, time, content;
  final Color color;
  final int likes, comments;
  const _Post(this.initials, this.name, this.time, this.content, this.color, this.likes, this.comments);
}

const List<_Post> _posts = []; 

class _PostCard extends StatelessWidget {
  final _Post post;
  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    const grey = Color(0xFF6B7280);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Bo góc mềm hơn
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: post.color.withOpacity(0.15), // Nền nhạt
              child: Text(post.initials, style: TextStyle(color: post.color, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(post.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
                const SizedBox(height: 2),
                Text(post.time, style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
              ]),
            ),
            const Icon(Icons.more_horiz, size: 20, color: Color(0xFF9CA3AF)), // Dùng dấu 3 chấm tinh tế hơn
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(post.content, style: const TextStyle(fontSize: 15, color: Color(0xFF374151), height: 1.4)),
        ),
        Divider(height: 1, color: Colors.grey.shade100, thickness: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(children: [
            const Icon(Icons.thumb_up_outlined, size: 20, color: grey),
            const SizedBox(width: 6),
            Text('${post.likes}', style: const TextStyle(color: grey, fontWeight: FontWeight.w500)),
            const SizedBox(width: 24),
            const Icon(Icons.chat_bubble_outline, size: 20, color: grey),
            const SizedBox(width: 6),
            Text('${post.comments}', style: const TextStyle(color: grey, fontWeight: FontWeight.w500)),
            const Spacer(),
            const Text('💗👍', style: TextStyle(fontSize: 16)),
          ]),
        ),
      ]),
    );
  }
}
import 'package:flutter/material.dart';
import '../common.dart';

/// Tab 2 – Dịch vụ công (public services).
class PublicServiceScreen extends StatelessWidget {
  const PublicServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBgTeal,
      child: Column(children: [
        const StudentAppBar(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16), 
            children: [
              // "Hồ sơ đang xử lý" card
              Container(
                height: 120,
                padding: const EdgeInsets.fromLTRB(20, 24, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white, // Chuyển nền trắng để trông sang hơn
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFBCE3E6), width: 1.5), // Viền nhạt, mỏng hơn
                  boxShadow: [
                    BoxShadow(color: const Color(0xFF3E9EA8).withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 4))
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F4FD),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.folder_open_rounded, size: 36, color: Color(0xFF2E88E0)),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 6.0),
                        child: Text('Hồ sơ\nđang xử lý',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1F2937), height: 1.3)),
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF65454), 
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: const Color(0xFFF65454).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))
                        ],
                      ),
                      child: const Text('0', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // "Danh mục dịch vụ" card
              Container(
                height: 100,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 12, offset: const Offset(0, 4))
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.dashboard_customize_rounded, color: Color(0xFF1C3F94), size: 28),
                    SizedBox(width: 12),
                    Text('Danh mục dịch vụ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1C3F94))),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Bottom pill: FAQ + contact
        Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))
            ],
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.help_outline_rounded, color: Color(0xFFF65454), size: 20),
            const SizedBox(width: 8),
            const Text('Câu hỏi thường gặp', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF4B5563))),
            const SizedBox(width: 24),
            Container(width: 1, height: 20, color: Colors.grey.shade200), // Vạch chia
            const SizedBox(width: 24),
            const Icon(Icons.headset_mic_rounded, color: Color(0xFF1E6FD9), size: 20),
            const SizedBox(width: 8),
            const Text('Liên hệ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF4B5563))),
          ]),
        ),
      ]),
    );
  }
}
import 'package:lucide_icons/lucide_icons.dart';
import '../models/lookup_category.dart';
import '../models/recent_item.dart';

class LookupDataProvider {
  static const List<LookupCategory> categories = [
    LookupCategory(title: 'Nhóm kháng sinh', subtitle: 'Phân loại và mô tả', icon: LucideIcons.layers),
    LookupCategory(title: 'Kháng sinh', subtitle: 'Liều dùng và phổ tác dụng', icon: LucideIcons.pill),
    LookupCategory(title: 'Tác nhân gây bệnh', subtitle: 'Mô tả và độ nhạy', icon: LucideIcons.bug),
    LookupCategory(title: 'Tác nhân nghi ngờ', subtitle: 'Theo bệnh và mức độ', icon: LucideIcons.alertCircle),
    LookupCategory(title: 'Biến số lâm sàng', subtitle: 'Các biến số dùng cho tiêu chí', icon: LucideIcons.clipboardList),
    // LookupCategory(title: 'Phác đồ điều trị', subtitle: 'Theo bệnh và mức độ', icon: LucideIcons.clipboardList),
    LookupCategory(title: "Tiêu chí đánh giá", subtitle: 'Danh sách các tiêu chí', icon: LucideIcons.checkSquare),
    LookupCategory(title: 'Thang điểm lâm sàng', subtitle: 'Các bộ tiêu chí & Đánh giá', icon: LucideIcons.stethoscope),
    LookupCategory(title: 'Yếu tố nguy cơ', subtitle: 'Nguy cơ theo tác nhân', icon: LucideIcons.alertTriangle),
  ];

  static const List<RecentItem> recentItems = [
    RecentItem(title: 'Ceftriaxone', subtitle: 'Cephalosporin thế hệ 3', tag: 'Thuốc'),
    RecentItem(title: 'Viêm phổi cộng đồng', subtitle: '5 tiêu chí đánh giá', tag: 'Bệnh'),
  ];
}
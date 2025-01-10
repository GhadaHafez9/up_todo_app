import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 2)
class CategoryModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? iconPath;

  @HiveField(3)
  final int colorBg;

  @HiveField(4)
  final int iconCodePoint;

  @HiveField(5)
  final int? colorValueIcon;
  @HiveField(6)
  final String? iconFontPackage;
  @HiveField(7)
  final String iconFontFamily;

  CategoryModel({
    required this.name,
    this.iconPath,
    required this.colorBg,
    required this.iconCodePoint,
    this.colorValueIcon,
    this.id = 0,
    this.iconFontPackage,
    required this.iconFontFamily,
  });
}

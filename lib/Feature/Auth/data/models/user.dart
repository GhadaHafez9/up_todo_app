import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String img;

  User({this.id, required this.name, required this.img});

  User copyWith({String? id, String? name, String? img}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      img: img ?? this.img,
    );
  }

  List<Object?> get props => [id, name, img];
}

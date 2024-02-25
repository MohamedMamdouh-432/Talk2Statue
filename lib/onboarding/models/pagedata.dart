import 'package:equatable/equatable.dart';

class PageData extends Equatable {
  final String imgPath;
  final String title;
  final String desc;

  const PageData({
    required this.imgPath,
    required this.title,
    required this.desc,
  });

  @override
  List<Object> get props => [
        imgPath,
        title,
        desc,
      ];
}

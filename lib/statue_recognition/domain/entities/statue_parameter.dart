import 'package:equatable/equatable.dart';

class StatueParams extends Equatable {
  final String statueImg;
  
  const StatueParams(this.statueImg);
  
  @override
  List<Object> get props => [statueImg];
}

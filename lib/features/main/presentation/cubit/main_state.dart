import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final int selectedIndex;

  const MainState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}

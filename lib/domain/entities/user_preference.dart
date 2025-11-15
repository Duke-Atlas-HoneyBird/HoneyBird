import 'package:equatable/equatable.dart';

/// Domain entity representing user preferences for dietary restrictions and experiences.
/// 
/// This entity is immutable with a copyWith method for creating modified instances.
/// Default values match the Swift implementation.
class UserPreference extends Equatable {
  final String id;
  
  // Dietary restrictions
  final bool halaal;
  final bool haram;
  final bool pork;
  final bool vegan;
  final bool vegetarian;
  final bool lactose;
  
  // Experience preferences
  final bool outdoor;
  final bool wineTasting;
  final bool wineFarms;
  final bool african;
  final bool italian;
  final bool greek;
  final bool chinese;
  final bool thai;

  const UserPreference({
    required this.id,
    this.halaal = false,
    this.haram = false,
    this.pork = false,
    this.vegan = false,
    this.vegetarian = false,
    this.lactose = false,
    this.outdoor = false,
    this.wineTasting = false,
    this.wineFarms = false,
    this.african = true,
    this.chinese = true,
    this.greek = true,
    this.italian = true,
    this.thai = true,
  });

  /// Creates a copy of this UserPreference with the given fields replaced with new values.
  UserPreference copyWith({
    String? id,
    bool? halaal,
    bool? haram,
    bool? pork,
    bool? vegan,
    bool? vegetarian,
    bool? lactose,
    bool? outdoor,
    bool? wineTasting,
    bool? wineFarms,
    bool? african,
    bool? italian,
    bool? greek,
    bool? chinese,
    bool? thai,
  }) {
    return UserPreference(
      id: id ?? this.id,
      halaal: halaal ?? this.halaal,
      haram: haram ?? this.haram,
      pork: pork ?? this.pork,
      vegan: vegan ?? this.vegan,
      vegetarian: vegetarian ?? this.vegetarian,
      lactose: lactose ?? this.lactose,
      outdoor: outdoor ?? this.outdoor,
      wineTasting: wineTasting ?? this.wineTasting,
      wineFarms: wineFarms ?? this.wineFarms,
      african: african ?? this.african,
      italian: italian ?? this.italian,
      greek: greek ?? this.greek,
      chinese: chinese ?? this.chinese,
      thai: thai ?? this.thai,
    );
  }

  @override
  List<Object?> get props => [
        id,
        halaal,
        haram,
        pork,
        vegan,
        vegetarian,
        lactose,
        outdoor,
        wineTasting,
        wineFarms,
        african,
        italian,
        greek,
        chinese,
        thai,
      ];
}

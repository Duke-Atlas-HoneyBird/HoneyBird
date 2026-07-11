import 'package:equatable/equatable.dart';
import '../../core/utils/uuid_utils.dart';

/// Domain entity representing a restaurant / merchant on the platform.
class Restaurant extends Equatable {
  final String id;
  final String name;

  Restaurant({
    String? id,
    required this.name,
  }) : id = id ?? UuidUtils.generate();

  @override
  List<Object?> get props => [id, name];
}

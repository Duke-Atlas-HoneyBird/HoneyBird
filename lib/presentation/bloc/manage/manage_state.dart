import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/drop_task.dart';

part 'manage_state.freezed.dart';

@freezed
class ManageState with _$ManageState {
  const factory ManageState({
    @Default(false) bool isLoading,
    @Default([]) List<DropTask> tasks,
    String? errorMessage,
  }) = _ManageState;
}

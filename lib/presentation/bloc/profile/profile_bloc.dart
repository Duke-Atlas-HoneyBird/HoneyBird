import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_message_utils.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/entities/user_preference.dart';
import '../../../domain/repositories/block_repository.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/repositories/user_preference_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final UserPreferenceRepository _preferenceRepository;
  final BlockRepository _blockRepository;

  ProfileBloc({
    required UserRepository userRepository,
    required UserPreferenceRepository preferenceRepository,
    required BlockRepository blockRepository,
  })  : _userRepository = userRepository,
        _preferenceRepository = preferenceRepository,
        _blockRepository = blockRepository,
        super(const ProfileState()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<BlockUser>(_onBlockUser);
    on<UnblockUser>(_onUnblockUser);
  }

  Future<void> _onLoadUserProfile(
    LoadUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final userResult = await _userRepository.getUserByUID(event.targetUserUID);
    final isBlockedResult = await _blockRepository.isBlocked(
      event.viewerUserUID,
      event.targetUserUID,
    );

    await userResult.fold(
      (failure) async => emit(state.copyWith(
          isLoading: false, errorMessage: ErrorMessageUtils.forUi('load_profile'))),
      (user) async {
        // Load preferences - may fail if user hasn't set them
        UserPreference? prefs;
        if(event.targetUserUID == event.viewerUserUID)
        {
          prefs = state.preferences;
        }
  
        final isBlocked = isBlockedResult.fold((_) => false, (b) => b);

        emit(state.copyWith(
          isLoading: false,
          user: user,
          preferences: prefs,
          isBlocked: isBlocked,
        ));
      },
    );
  }

  Future<void> _onBlockUser(
    BlockUser event,
    Emitter<ProfileState> emit,
  ) async {
    final result =
        await _blockRepository.blockUser(event.currentUserUID, event.targetUserUID);

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: ErrorMessageUtils.forUi('block'))),
      (_) => emit(state.copyWith(isBlocked: true, errorMessage: null)),
    );
  }

  Future<void> _onUnblockUser(
    UnblockUser event,
    Emitter<ProfileState> emit,
  ) async {
    final result = await _blockRepository.unblockUser(
      event.currentUserUID,
      event.targetUserUID,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: ErrorMessageUtils.forUi('unblock'))),
      (_) => emit(state.copyWith(isBlocked: false, errorMessage: null)),
    );
  }
}

import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../data_sources/firebase_message_data_source.dart';
import '../models/message_model.dart';

/// Implementation of [MessageRepository] using Firestore as the mediated backend.
class MessageRepositoryImpl implements MessageRepository {
  final FirebaseMessageDataSource dataSource;

  MessageRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Conversation>>> getConversations(
      String userUID) async {
    try {
      final conversations = await dataSource.getConversations(userUID);
      return Right(conversations);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages(
      String conversationId) async {
    try {
      final messages = await dataSource.getMessages(conversationId);
      return Right(messages);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage(
    Message message, {
    String? conversationId,
  }) async {
    try {
      final messageModel = MessageModel.fromEntity(message);
      final sentMessage =
          await dataSource.sendMessage(messageModel, conversationId);
      return Right(sentMessage);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(
    String conversationId,
    String userUID,
  ) async {
    try {
      await dataSource.markAsRead(conversationId, userUID);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount(String userUID) async {
    try {
      final count = await dataSource.getUnreadCount(userUID);
      return Right(count);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> ensureMerchantChannelNotice({
    required String userUID,
    required String userName,
    required String restaurantId,
    required String restaurantName,
  }) async {
    try {
      final convId = Conversation.idFor(userUID, restaurantId);
      await dataSource.ensureMerchantChannelNotice(
        conversationId: convId,
        userUID: userUID,
        userName: userName,
        restaurantId: restaurantId,
        restaurantName: restaurantName,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }
}

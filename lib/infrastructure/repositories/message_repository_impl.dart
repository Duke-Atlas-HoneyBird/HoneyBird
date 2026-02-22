import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../data_sources/firebase_message_data_source.dart';
import '../models/message_model.dart';

/// Implementation of MessageRepository that uses Firestore as the data source
class MessageRepositoryImpl implements MessageRepository {
  final FirebaseMessageDataSource dataSource;

  MessageRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Conversation>>> getConversations(String userUID) async {
    try {
      var conversations = await dataSource.getConversations(userUID);
      return Right(conversations);
    } on ServerException catch (e) {
      print('[MessageRepositoryImpl] getConversations ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[MessageRepositoryImpl] getConversations unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> seedFakeConversationsIfEmpty(String userUID) async {
    try {
      await dataSource.seedFakeConversationsIfEmpty(userUID);
      return const Right(null);
    } on ServerException catch (e) {
      print('[MessageRepositoryImpl] seedFakeConversationsIfEmpty ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[MessageRepositoryImpl] seedFakeConversationsIfEmpty unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages(String conversationId) async {
    try {
      final messages = await dataSource.getMessages(conversationId);
      return Right(messages);
    } on ServerException catch (e) {
      print('[MessageRepositoryImpl] getMessages ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[MessageRepositoryImpl] getMessages unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage(Message message, {String? conversationId}) async {
    try {
      final messageModel = MessageModel.fromEntity(message);
      final sentMessage = await dataSource.sendMessage(messageModel, conversationId);
      return Right(sentMessage);
    } on ServerException catch (e) {
      print('[MessageRepositoryImpl] sendMessage ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[MessageRepositoryImpl] sendMessage unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(String conversationId, String userUID) async {
    try {
      await dataSource.markAsRead(conversationId, userUID);
      return const Right(null);
    } on ServerException catch (e) {
      print('[MessageRepositoryImpl] markAsRead ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[MessageRepositoryImpl] markAsRead unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount(String userUID) async {
    try {
      final count = await dataSource.getUnreadCount(userUID);
      return Right(count);
    } on ServerException catch (e) {
      print('[MessageRepositoryImpl] getUnreadCount ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[MessageRepositoryImpl] getUnreadCount unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }
}


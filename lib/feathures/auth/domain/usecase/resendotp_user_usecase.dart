import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final resendOtpUserUseCaseProvider = Provider<ResendOtpUserUseCase>(
    (ref) => ResendOtpUserUseCase(
        userRepository: ref.watch(authRepositoryProvider)));

class ResendOtpUserUseCase {
  final IAuthRepository userRepository;

  ResendOtpUserUseCase({required this.userRepository});

  Future<Either<Failure, void>> resendOTP() async {
    return await userRepository.resendOtp();
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final verifyOTPUseCaseProvider = Provider<VerifyOTPUseCase>((ref) =>
    VerifyOTPUseCase(userRepository: ref.watch(authRepositoryProvider)));

class VerifyOTPUseCase {
  final IAuthRepository userRepository;

  VerifyOTPUseCase({required this.userRepository});

  Future<Either<Failure, bool>> verifyOTP(int otp, bool redirect) async {
    return await userRepository.verifyOTP(otp, redirect);
  }
}

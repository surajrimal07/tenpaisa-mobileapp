import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/router/approutes.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/core/common/localauth/local_auth.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/domain/usecase/add_user_usecase.dart';
import 'package:paisa/feathures/auth/domain/usecase/delete_user_usecase.dart';
import 'package:paisa/feathures/auth/domain/usecase/forget_user_usecase.dart';
import 'package:paisa/feathures/auth/domain/usecase/get_fingerprint_usecase.dart';
import 'package:paisa/feathures/auth/domain/usecase/get_user_usecase.dart';
import 'package:paisa/feathures/auth/domain/usecase/login_user_usecase.dart';
import 'package:paisa/feathures/auth/domain/usecase/logout_user_usecase.dart';
import 'package:paisa/feathures/auth/domain/usecase/resendotp_user_usecase.dart';
import 'package:paisa/feathures/auth/domain/usecase/savestyle_user_usecase.dart';
import 'package:paisa/feathures/auth/domain/usecase/update_picture_usecase.dart';
import 'package:paisa/feathures/auth/domain/usecase/update_user_usecase.dart';
import 'package:paisa/feathures/auth/domain/usecase/verifyotp_user_usecase.dart';
import 'package:paisa/feathures/auth/presentation/pages/forget_widget.dart';
import 'package:paisa/feathures/auth/presentation/state/before_auth_state.dart';
import 'package:paisa/feathures/auth/presentation/view/auth_view.dart';
import 'package:paisa/feathures/portfolio/presentation/state/portfolio_state.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
import 'package:paisa/feathures/watchlist/presentation/state/watchlist_state.dart';
import 'package:paisa/feathures/watchlist/presentation/viewmodel/watchlist_viewmodel.dart';
import 'package:permission_handler/permission_handler.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, LoginState>(
  (ref) => AuthViewModel(
    loginUserUseCase: ref.watch(loginUserUseCaseProvider),
    getUserUseCase: ref.watch(getUserUseCaseProvider),
    signUpUseCase: ref.watch(addUserUseCaseProvider),
    otpUseCase: ref.watch(verifyOTPUseCaseProvider),
    resendOtpUseCase: ref.watch(resendOtpUserUseCaseProvider),
    styleUseCase: ref.watch(saveStyleUserUseCaseProvider),
    forgetPasswordUseCase: ref.watch(forgetUserUseCaseProvider),
    updateProfilePictureUseCase: ref.watch(updatePictureUseCaseProvider),
    logoutUserUseCase: ref.watch(logoutUserUseCaseProvider),
    updateUserUseCase: ref.watch(updateUserUseCaseProvider),
    fingerprintUserUseCase: ref.watch(fingerprintUserUseCaseProvider),
    deleteUserUseCase: ref.watch(deleteUserUseCaseProvider),
  ),
);

class AuthViewModel extends StateNotifier<LoginState> {
  final LoginUserUseCase loginUserUseCase;
  final GetUserUseCase getUserUseCase;
  final AddUserUseCase signUpUseCase;
  final VerifyOTPUseCase otpUseCase;
  final ResendOtpUserUseCase resendOtpUseCase;
  final SaveStyleUserUseCase styleUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final ForgetUserUseCase forgetPasswordUseCase;
  final UpdatePictureUseCase updateProfilePictureUseCase;
  final LogoutUserUseCase logoutUserUseCase;
  final FingerprintUserUseCase fingerprintUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  AuthViewModel(
      {required this.otpUseCase,
      required this.signUpUseCase,
      required this.loginUserUseCase,
      required this.getUserUseCase,
      required this.resendOtpUseCase,
      required this.styleUseCase,
      required this.forgetPasswordUseCase,
      required this.updateProfilePictureUseCase,
      required this.logoutUserUseCase,
      required this.updateUserUseCase,
      required this.fingerprintUserUseCase,
      required this.deleteUserUseCase})
      : super(LoginState.initialState());

  Future<void> signIn(
      ref, String email, String password, bool remember, nav) async {
    state = state.copyWith(isLoading: true);
    var data = await loginUserUseCase.loginUser(email, password, remember);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
      },
      (success) {
        ref.read(authEntityProvider.notifier).state = success;
        state = state.copyWith(isLoading: false, error: null);
        nav.routeToAndReplaceAll(AppRoute.homeRoute);
      },
    );
  }

  Future<void> cameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> fingerprintLogin(ref, nav) async {
    state = state.copyWith(isLoading: true);
    final isAuthenticated = await ref.read(localAuthProvider).authenticate();
    if (isAuthenticated) {
      final result = await getUserUseCase.getUser();
      result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.error);
          CustomToast.showToast(failure.error.toString(),
              customType: Type.error);
        },
        (success) {
          CustomToast.showToast(ModelStrings.authSuccess,
              customType: Type.success);

          ref.read(authEntityProvider.notifier).state = success;
          state = state.copyWith(isLoading: false, error: null);
          nav.routeToAndReplaceAll(AppRoute.homeRoute);
        },
      );
    } else {
      state = state.copyWith(isLoading: false, error: 'Authentication Failed');
      CustomToast.showToast(ModelStrings.authFailed, customType: Type.error);
    }
  }

  Future<bool> getFingerprintStatus() async {
    final result = await fingerprintUserUseCase.getFingerprint();
    return result;
  }

  Future<void> signUp(AuthEntity user, bool remember, nav) async {
    state = state.copyWith(isLoading: true);
    var data = await signUpUseCase.addUser(user, remember);
    data.fold(
      (failure) {
        CustomToast.showToast(failure.error.toString());
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        nav.state = AuthScreen.otp;
      },
    );
  }

  Future<void> verifyOTP(
      int otp, nav, bool redirect, ref, bool fromforget) async {
    state = state.copyWith(isLoading: true);

    var data = await otpUseCase.verifyOTP(otp, redirect);
    data.fold(
      (failure) {
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
        state = state.copyWith(isLoading: false, error: failure.error);
        return false;
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        if (fromforget) {
          ref.read(verificationStatusProvider).setOtpVerified(true);
          return true;
        }
        redirect ? nav.state = AuthScreen.style : null;
        return true;
      },
    );
  }

  Future<void> resendOTP(nav) async {
    state = state.copyWith(isLoading: true);
    var data = await resendOtpUseCase.resendOTP();
    data.fold(
      (failure) {
        CustomToast.showToast(failure.error.toString(), customType: Type.info);
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
      },
    );
  }

  Future<void> passwordUpdateSuccess(ref) async {
    final nav = ref.read(navigationServiceProvider);
    nav.state = AuthScreen.login;
  }

  Future<void> saveStyle(
      String field, String value, nav, bool redirect, ref) async {
    state = state.copyWith(isLoading: true);
    var data = await styleUseCase.saveStyle(field, value);
    data.fold(
      (failure) {
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (success) {
        ref.read(authEntityProvider.notifier).state = success;
        state = state.copyWith(isLoading: false, error: null);
        //show success dialog
        //then redirect
        redirect ? nav.routeToAndReplaceAll(AppRoute.homeRoute) : null;
      },
    );
  }

  Future<void> forgetPassword(String email, nav) async {
    state = state.copyWith(isLoading: true);
    var data = await forgetPasswordUseCase.forgetPassword(email);
    data.fold(
      (failure) {
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
      },
    );
  }

  Future<void> updateProfile(File image, String email, ref) async {
    state = state.copyWith(isLoading: true);
    CustomToast.showToast(ModelStrings.updateProfilePicture,
        customType: Type.info);
    var data =
        await updateProfilePictureUseCase.updateProfilePicture(image, email);
    data.fold(
      (failure) {
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (success) { //put it in state not entity
        ref.read(authEntityProvider.notifier).state = success;
        state = state.copyWith(isLoading: false, error: null);
      },
    );
  }

  Future<void> logout(ref) async {
    state = state.copyWith(isLoading: true);
    final nav = ref.read(navigationServiceProvider);
    var data = await logoutUserUseCase.logoutUser();
    data.fold(
      (failure) {
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (success) {
        ref.read(authEntityProvider.notifier).state = const AuthEntity(
          name: DefaultUserValues.defaultName,
          email: DefaultUserValues.defaultEmail,
          password: DefaultUserValues.defaultPassword,
          token: DefaultUserValues.defaultToken,
          phone: DefaultUserValues.defaultPhone,
        );

        ref.read(portfolioViewModelProvider.notifier).state =
            PortfolioState.initialState();

        ref.read(watchlistViewModelProvider.notifier).state =
            WatchlistState.initial();

        state = state.copyWith(isLoading: false, error: null);
        nav.routeToAndReplaceAll(AppRoute.authRoute);
      },
    );
  }

  Future<void> updateUser(String email, String field, String value, ref) async {
    state = state.copyWith(isLoading: true, error: null);
    var data = await updateUserUseCase.updateUser(email, field, value);
    data.fold(
      (failure) {
        state = state.copyWith(
            isLoading: false, error: failure.error, showMessage: true);
      },
      (success) {
        ref.read(authEntityProvider.notifier).state = success;
        state =
            state.copyWith(isLoading: false, error: null, showMessage: true);
      },
    );
  }

  Future<void> deleteUser(String password, WidgetRef ref) async {
    state = state.copyWith(isLoading: true);
    CustomToast.showToast(ModelStrings.pleaseWait, customType: Type.info);

    var nav = ref.read(navigationServiceProvider);
    var data = await deleteUserUseCase.deleteUser(password);

    data.fold(
      (failure) {
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (success) {
        ref.read(authEntityProvider.notifier).state = const AuthEntity(
          name: DefaultUserValues.defaultName,
          email: DefaultUserValues.defaultEmail,
          password: DefaultUserValues.defaultPassword,
          token: DefaultUserValues.defaultToken,
          phone: DefaultUserValues.defaultPhone,
        );
        state = state.copyWith(isLoading: false, error: null);
        CustomToast.showToast(ModelStrings.userDeleted,
            customType: Type.success);
        nav.routeToAndReplaceAll(AppRoute.authRoute);
      },
    );
  }
}

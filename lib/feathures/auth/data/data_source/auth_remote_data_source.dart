import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/endpoint_constants.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/http/http_service.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/data/dto/login_auth_dto.dart';
import 'package:paisa/feathures/auth/data/model/auth_remote_model.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

final endPoints = EndPoints();
const showtoast = true;

class AuthRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({required this.dio, required this.userSharedPrefs});

/////login

//working //do not touch
  Future<Either<Failure, AuthEntity>> loginUser(
      String email, String pass, bool remember) async {
    try {
      var response = await dio
          .post(EndPoints.login, data: {'email': email, 'password': pass});

      if (response.statusCode == 200) {
        AuthDTO authDTO = AuthDTO.fromJson(response.data);
        AuthRemoteModel user = authDTO.data;
        AuthEntity userEntity = AuthRemoteModel.toEntity(user);
        CustomToast.showToast(authDTO.message);
        return right(userEntity);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      print("Dio Exception: Occured"); //why this is not working?
      return Left(
        Failure(
            error: "Internet connection not available",
            statusCode: e.response?.statusCode.toString() ?? '0',
            showToast: showtoast),
      );
    }
  }

//working //this sends otp //this function name should be otp sender
  Future<Either<Failure, bool>> sendOTP() async {
    var email = await userSharedPrefs.getTempEmail();
    try {
      var response = await dio.post(
        EndPoints.signup,
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedResponse = response.data;
        String dataValue = parsedResponse['hash'];

        await userSharedPrefs.saveHash(dataValue);
        CustomToast.showToast(parsedResponse['message']);
        return right(true);
      } else {
        final Map<String, dynamic> responseData = response.data;
        CustomToast.showToast(responseData['message']);
        return left(
            Failure(error: responseData['message'], showToast: showtoast));
      }
    } on DioException catch (error) {
      CustomToast.showToast("DioError: ${error.message}");
      return left(Failure(error: error.message!, showToast: showtoast));
    }
  }

//save after otp  /final save function //working //do not touch
  Future<Either<Failure, bool>> registerUserFinal(userTempData) async {
    try {
      Map<String, dynamic> decodedData = jsonDecode(userTempData);

      var response = await dio.post(
        EndPoints.saveUser,
        data: {
          'name': decodedData['name'], //user.name etc was here earlier
          'email': decodedData['email'],
          'phone': decodedData['phone'].toString(),
          'password': decodedData['pass'],
        },
      );

      if (response.statusCode == 201) {
        AuthDTO authDTO = AuthDTO.fromJson(response.data);

        String dataValue = authDTO.data.token;

        bool rem = await userSharedPrefs.gettempRememberMe();

        await Future.wait([
          userSharedPrefs.setUserToken(dataValue),
          userSharedPrefs.setUserEmail(authDTO.data.email),
          userSharedPrefs.setLoggedIn(),
          userSharedPrefs.setRememberMe(rem),
          userSharedPrefs.deleteHash(),
          userSharedPrefs.deleteTempEmail(),
          userSharedPrefs.deleteTempUserData(),
          userSharedPrefs.deletetempRememberMe(),
        ]);

        CustomToast.showToast(authDTO.message);
        return right(true);
      } else {
        final Map<String, dynamic> responseData = response.data;
        CustomToast.showToast(responseData['message']);
        return left(
            Failure(error: responseData['message'], showToast: showtoast));
      }
    } catch (e) {
      CustomToast.showToast(e.toString());
      return left(Failure(error: e.toString(), showToast: showtoast));
    }
  }

//verify otp //working //do not touch
  Future<Either<Failure, bool>> verifyOTP(int otpcode, bool redirect) async {
    String otp = otpcode.toString();
    String hash = await userSharedPrefs.getHash() ?? "";
    String email = await userSharedPrefs.getTempEmail() ?? "";

    try {
      var response = await dio.post(
        EndPoints.otpVerify,
        data: {
          'email': email,
          'hash': hash,
          'otp': otp,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        CustomToast.showToast(responseData['message']);

        if (redirect) {
          var tempUserData = await userSharedPrefs.getTempUserData();

          Either<Failure, bool> registerUserFinalResult =
              await registerUserFinal(
                  tempUserData); //user was passed here earlier
          if (registerUserFinalResult.isLeft()) {
            return registerUserFinalResult;
          }
        }

        return right(true);
      } else {
        final Map<String, dynamic> responseData = response.data;
        CustomToast.showToast(responseData['message']);
        return left(
            Failure(error: responseData['message'], showToast: showtoast));
      }
    } catch (e) {
      CustomToast.showToast(e.toString());
      return left(Failure(error: e.toString(), showToast: showtoast));
    }
  }

//use case not done
//testing //this is intented to use when user has set rememberme as true which
//means we don't get authentity from login function, so we use this
  Future<Either<Failure, AuthEntity>> getUser(String email) async {
    //print("Email in get user: $email");
    try {
      var response = await dio.post(
        EndPoints.verifyApi,
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        AuthDTO authDTO = AuthDTO.fromJson(response.data);
        AuthRemoteModel user = authDTO.data;
        AuthEntity userEntity = AuthRemoteModel.toEntity(user);
        return right(userEntity);
      } else {
        final Map<String, dynamic> responseData = response.data; //fixed //last
        CustomToast.showToast(responseData['message']);
        return left(
            Failure(error: responseData['message'], showToast: showtoast));
      }
    } catch (e) {
      CustomToast.showToast(e.toString());
      return left(Failure(error: e.toString(), showToast: showtoast));
    }
  }

//working //do not touch
  Future<Either<Failure, bool>> preVerify(String value, String fields) async {
    CustomToast.showToast("Please wait");
    try {
      var response = await dio.post(
        EndPoints.preVerify,
        data: {
          'value': value,
          'field': fields,
        },
      );

      if (response.statusCode == 200) {
        //final Map<String, dynamic> responseData = response.data;
        //CustomToast.showToast(responseData['message']);
        return right(true);
      } else {
        CustomToast.showToast(response.data["message"]);
        return left(Failure(error: response.data["message"]));
      }
    } on DioException catch (e) {
      CustomToast.showToast(e.error.toString());
      return left(Failure(
          error: e.response?.data["message"] ?? e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
          showToast: showtoast));
    }
  }

//update the user //working //made for update user style page
//optimize this code later, merge both update user functions
//return auth entity and handle return from style use case

//optimzation necessary 1 , merge both update and updateuser 1
  Future<Either<Failure, AuthEntity>> updateUser(
      String email, String field, String value) async {
    try {
      var response = await dio.post(
        EndPoints.updateUser,
        data: {
          'email': email,
          'field': field,
          'value': value,
        },
      );

      if (response.statusCode == 200) {
        // final Map<String, dynamic> responseData = response.data;
        // CustomToast.showToast(responseData['message']);
        // return right(true);

        AuthDTO authDTO = AuthDTO.fromJson(response.data);
        AuthRemoteModel user = authDTO.data;
        AuthEntity userEntity = AuthRemoteModel.toEntity(user);
        CustomToast.showToast(authDTO.message);
        return right(userEntity);
      } else {
        final Map<String, dynamic> responseData = response.data;
        return left(
            Failure(error: responseData['message'], showToast: showtoast));
      }
    } catch (e) {
      return left(Failure(error: e.toString(), showToast: showtoast));
    }
  }

//delete the user
  Future<Either<Failure, bool>> deleteUser(
      String email, String password) async {
    try {
      var response = await dio.post(
        EndPoints.deleteUser,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return right(true);
      } else {
        final Map<String, dynamic> responseData = response.data; //fixed //last
        CustomToast.showToast(responseData['message']);
        return left(
            Failure(error: responseData['message'], showToast: showtoast));
      }
    } catch (e) {
      return left(Failure(error: e.toString(), showToast: showtoast));
    }
  }

//not used //testing is required //to resend the otp
  Future<void> resendOTP(String email) async {
    try {
      var response = await dio.post(
        EndPoints.otpLogin,
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedResponse = response.data;
        String dataValue = parsedResponse['data'];
        await userSharedPrefs.saveHash(dataValue);
        CustomToast.showToast("OTP sent successfully");
      } else {
        final Map<String, dynamic> responseData = json.decode(response.data);
        CustomToast.showToast(responseData['message']);
      }
    } catch (e) {
      CustomToast.showToast(e.toString());
    }
  }

// //used in forget password
//   Future<Either<Failure, String>> getToken(String email) async {
//     await userSharedPrefs.saveTempEmail(email);
//     try {
//       var response = await dio.post(
//         EndPoints.otpLogin,
//         data: {
//           'email': email,
//         },
//       );

//       if (response.statusCode == 200) {
//         Map<String, dynamic> parsedResponse = json.decode(response.data);
//         String dataValue = parsedResponse['data']; //might be issue here
//         // await userSharedPrefs.setUserToken(dataValue);
//         return right(dataValue);
//       } else {
//         final Map<String, dynamic> responseData = json.decode(response.data);
//         CustomToast.showToast(responseData['message']);
//         return left(
//             Failure(error: responseData['message'], showToast: showtoast));
//       }
//     } catch (e) {
//       // CustomToast.showToast(e.toString());
//       return left(Failure(error: e.toString(), showToast: showtoast));
//     }
//   }

//testing
  Future<Either<Failure, bool>> forget(String email) async {
    try {
      var response = await dio.post(
        EndPoints.forget,
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedResponse = response.data;
        String dataValue = parsedResponse['data'];
        await userSharedPrefs.saveHash(dataValue);
        await userSharedPrefs.saveTempEmail(email);
        return right(true);
      } else {
        final Map<String, dynamic> responseData = response.data;
        return left(
            Failure(error: responseData['message'], showToast: showtoast));
      }
    } catch (e) {
      return left(Failure(error: e.toString(), showToast: showtoast));
    }
  }

//working //do not touch
  Future<Either<Failure, bool>> createUser(
    AuthEntity user,
    bool remember,
  ) async {
    await userSharedPrefs.saveTempEmail(user.email); //save data for later use

    Map<String, dynamic> dataToPass = {
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'pass': user.password,
    };
    //let's save user data to temp in shared prefs
    final userDataJson = jsonEncode(dataToPass);
    await userSharedPrefs.saveTempUserData(userDataJson);

    try {
      Either<Failure, bool> emailVerificationResult =
          await preVerify(user.email, "email");
      if (emailVerificationResult.isLeft()) {
        return emailVerificationResult;
      }

      Either<Failure, bool> phoneVerificationResult =
          await preVerify(user.phone.toString(), "phone");
      if (phoneVerificationResult.isLeft()) {
        return phoneVerificationResult;
      }

      await userSharedPrefs.settempRememberMe(remember);
      await sendOTP(); //responsible for sending otp

      return right(true);
    } catch (failure) {
      return left(Failure(error: failure.toString(), showToast: showtoast));
    }
  }

  Future<Either<Failure, AuthEntity>> updateProfilePicture(
      File image, String email) async {
    try {
      String fileName = image.path.split('/').last;

      FormData formData = FormData.fromMap(
        {
          'dpImage': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
          'oldEmail': email
        },
      );

      var response = await dio.post(
        EndPoints.updateProfilePicture,
        data: formData,
      );

      if (response.statusCode == 200) {
        AuthDTO authDTO = AuthDTO.fromJson(response.data);
        AuthRemoteModel user = authDTO.data;
        AuthEntity userEntity = AuthRemoteModel.toEntity(user);
        CustomToast.showToast(authDTO.message);
        return right(userEntity);
      } else {
        final Map<String, dynamic> responseData = response.data;
        return left(
            Failure(error: responseData['message'], showToast: showtoast));
      }
    } catch (e) {
      return left(Failure(error: e.toString(), showToast: showtoast));
    }
  }
}

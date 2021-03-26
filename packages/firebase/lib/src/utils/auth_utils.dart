import 'dart:async';

import 'package:dstore_firebase/src/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthUtils {
  Stream<FirebasePhoneVerification> loginWithPhone(String number) {
    final scontroller = StreamController<FirebasePhoneVerification>();
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (value) {
          scontroller.sink
              .add(FirebasePhoneVerification.phoneAuthCredential(value));
        },
        codeSent: (verificationId, forceResendingToken) {
          scontroller.sink.add(FirebasePhoneVerification.codeSent(
              verificationId: verificationId,
              forceResendingToken: forceResendingToken));
        },
        verificationFailed: (error) {
          scontroller.sink
              .add(FirebasePhoneVerification.phoneVerificationFailed(error));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          scontroller.sink.add(
              FirebasePhoneVerification.codeAutoRetrievalTimeout(
                  verificationId: verificationId));
        });
    return scontroller.stream;
  }
}

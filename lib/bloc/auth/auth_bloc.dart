import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<LoginLoadingEvent>((event, emit) {
      emit(LoginLoadingState());
    });
    on<LoginFailedEvent>((event, emit) {
      emit(LoginFailedState(error: event.error));
    });
    on<LoginCodeSentEvent>((event, emit) {
      emit(LoginCodeSentState());
    });
    on<NewUserCreatedEvent>((event, emit) {
      emit(NewUserCreatedState(firebaseUser: event.firebaseUser));
    });
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? verificationId;
  String? phonenumber;

  void sendOTP(String phoneNumber) async {
    add(LoginLoadingEvent());
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: "+977$phoneNumber",
      verificationCompleted: (PhoneAuthCredential phoneAuthCrendential) {},
      verificationFailed: (error) {
        add(LoginFailedEvent(error: error.message.toString()));
      },
      codeSent: (vid, token) {
        phonenumber = "+977$phoneNumber";
        verificationId = vid;
        add(LoginCodeSentEvent());
      },
      codeAutoRetrievalTimeout: (vid) {
        verificationId = vid;
      },
    );
  }

  verifyOtp(String otp) async {
    add(LoginLoadingEvent());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!, smsCode: otp);
    signWIthPhone(credential);
  }

  void signWIthPhone(PhoneAuthCredential phoneAuthCredential) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot =
        await users.where('phone', isEqualTo: phonenumber).get();

    if (querySnapshot.docs.isEmpty) {
      try {
        UserCredential userCredential =
            await auth.signInWithCredential(phoneAuthCredential);
        if (userCredential.user != null) {
          add(NewUserCreatedEvent(firebaseUser: userCredential.user!));
        }
      } on FirebaseAuthException catch (e) {
        add(LoginFailedEvent(error: e.message!));
      }
    }
    if (querySnapshot.docs.isNotEmpty) {
      try {
        UserCredential userCredential =
            await auth.signInWithCredential(phoneAuthCredential);
        if (userCredential.user != null) {
          add(LoggedInEvent(firebaseUser: userCredential.user!));
        }
      } on FirebaseAuthException catch (e) {
        add(LoginFailedEvent(error: e.message!));
      }
    }
  }

  @override
  Future<void> close() async {
    sendOTP("");
    verifyOtp("");
    super.close();
  }
}

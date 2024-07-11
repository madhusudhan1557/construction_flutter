import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/data/models/users.dart';
import 'package:construction/utils/routes.dart';
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
    on<UserNotFountEvent>((event, emit) {
      emit(UserNotFountState());
    });
    on<InvalidPasswordEvent>((event, emit) {
      emit(InvalidPasswordState());
    });
    on<EmailSignUpCompletedEvent>((event, emit) {
      emit(EmailSignUpCompletedState());
    });
    on<EmailSignUpLoadingEvent>((event, emit) {
      emit(EmailSignUpLoadingState());
    });
    on<EmailAlreadyExistEvent>((event, emit) {
      emit(EmailAlreadyExistState());
    });
    on<UsernameAlreadyExistEvent>((event, emit) {
      emit(UsernameAlreadyExistState());
    });
    on<WeakPasswordEvent>((event, emit) {
      emit(WeakPasswordState());
    });
    on<CompletedLoadingEvent>((event, emit) {
      emit(CompletedLoadingState());
    });
    on<EmailSignUpFailedEvent>((event, emit) {
      emit(EmailSignUpFailedState(error: event.error));
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

  signUpWithEmail(UserModel usermodel) async {
    try {
      add(EmailSignUpLoadingEvent());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usermodel.email!,
        password: usermodel.password!,
      );
      CollectionReference users =
          FirebaseFirestore.instance.collection("users");
      QuerySnapshot userQuery =
          await users.where("fullname", isEqualTo: usermodel.fullname).get();
      if (userQuery.docs.isEmpty) {
        await users.doc(FirebaseAuth.instance.currentUser!.uid).set(
          {
            "uid": FirebaseAuth.instance.currentUser!.uid,
            "fullname": usermodel.fullname,
            'email': usermodel.email,
            'phone': usermodel.phone,
            'address': usermodel.address,
            "role": usermodel.role,
          },
        );

        add(EmailSignUpCompletedEvent());
      } else {
        add(UsernameAlreadyExistEvent());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        add(WeakPasswordEvent());
      } else if (e.code == 'email-already-in-use') {
        add(EmailAlreadyExistEvent());
      }
    } catch (e) {
      add(
        EmailSignUpFailedEvent(
          error: e.toString(),
        ),
      );
    }
  }

  signInWithEmail(UserModel userModel) async {
    add(LoginLoadingEvent());
    try {
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userModel.email!, password: userModel.password!);
      QuerySnapshot users = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: userModel.email!)
          .get();
      if (users.docs.isEmpty) {
        add(UserNotFountEvent());
      } else {
        add(CompletedLoadingEvent());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        add(UserNotFountEvent());
      } else if (e.code == 'wrong-password') {
        add(InvalidPasswordEvent());
      }
    } catch (e) {
      add(LoginFailedEvent(error: e.toString()));
    }
  }

  signout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) =>
        Navigator.of(context).pushNamedAndRemoveUntil(login, (route) => false));
  }

}

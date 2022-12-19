import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/main.dart';

import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/show_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/emojione_monotone.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';

import '../../utils/app_colors.dart';
import '../../utils/routes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: AppColors.customWhite,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String role = "";
              for (QueryDocumentSnapshot<Map<String, dynamic>> element
                  in snapshot.data!.docs) {
                role = element['role'];
              }
              return Container();
            } else {
              return Center(
                child: Builder(
                  builder: (context) => customLoading(size),
                ),
              );
            }
          }),
    );
  }
}

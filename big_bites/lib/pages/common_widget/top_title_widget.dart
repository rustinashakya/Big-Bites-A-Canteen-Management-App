import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/pages/dashboard_page/dashboard_page.dart';
import 'package:big_bites/pages/dashboard_page/profile_page/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopTitleWidget extends StatelessWidget {
  const TopTitleWidget({
    super.key,
    required this.title,
    this.isStaff = false,
    this.onAddButtonClicked,
    this.isTodayMenu = false,
    this.suffix,
  });

  final bool isStaff;

  final String title;
  final bool isTodayMenu;
  final VoidCallback? onAddButtonClicked;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: Fonts.topTitleLargeKaushan,
                  ),
                ),
                if (suffix != null) SizedBox(width: 8),
                if (suffix != null) suffix!,
              ],
            ),
          ),
          isStaff
              ? (isTodayMenu
                  ? IconButton(
                      onPressed: onAddButtonClicked,
                      icon: Image.asset(Images.addMenu))
                  : const SizedBox.shrink())
              : GestureDetector(
                  onTap: () async {
                    if (context.mounted) {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        final userDoc = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .get();
                        final firstName = userDoc.data()?['First Name'] as String? ?? '';
                        
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardPage(
                                userId: user.uid,
                                firstName: firstName,
                                initialIndex: 4,
                              ),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: SizedBox(
                    height: 50,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Image.asset(Images.profileImage),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

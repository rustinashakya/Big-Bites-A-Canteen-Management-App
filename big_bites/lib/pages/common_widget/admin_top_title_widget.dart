import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/images.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_dashboard_page.dart';
import 'package:flutter/material.dart';

class AdminTopTitleWidget extends StatelessWidget {
  const AdminTopTitleWidget({
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
                  onTap: () {
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminDashboardPage(initialIndex: 4),
                        ),
                      );
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

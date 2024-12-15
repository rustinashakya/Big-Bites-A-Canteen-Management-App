import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:big_bites/pages/dashboard_page/favorite_page/widgets/favourite_list_widget.dart';
import 'package:big_bites/utils/shared_preferences_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String? userId;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await SharedPreferencesHelper().getUserId();
    setState(() {
      userId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        TopTitleWidget(
          title: "My Favorites",
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('favorites')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: Fonts.bodyMediumInter,
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    'No Items Added to Favorites',
                    style: Fonts.bodyMediumInter,
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final doc = snapshot.data!.docs[index];
                  return FavouriteListWidget(
                    favItem: doc.data() as Map<String, dynamic>,
                    favId: doc.id,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
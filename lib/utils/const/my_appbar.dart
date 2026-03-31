import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvvm_practice/view/favorite/favorite_view.dart';
import 'package:mvvm_practice/view/home/home_viewmodel.dart';
import 'package:mvvm_practice/view/login/login_view.dart';
import 'package:provider/provider.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 5,
      backgroundColor: Colors.blueAccent,
      title: Text(
        "Thuprai",
        style: GoogleFonts.notoSans(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoriteView()),
            ); // ✅ waits until user pops back

            if (context.mounted) {
              await context
                  .read<HomeViewModel>()
                  .refreshFavoriteSlugs(); // ✅ re-sync
            }
          },

          icon: Icon(Icons.favorite, color: Colors.white),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              context.read<HomeViewModel>().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

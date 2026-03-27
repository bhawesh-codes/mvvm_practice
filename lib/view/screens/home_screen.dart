import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvvm_practice/view/screens/login_screen.dart';
import 'package:mvvm_practice/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
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
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                vm.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (vm.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (vm.error != null) {
            return Center(child: Text(vm.error!));
          }

          if (vm.bookData == null) {
            return Center(child: Text("No data"));
          }

          final books = vm.bookData!.results ?? [];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: books.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    final book = books[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: book.frontCover != null
                                ? Image.network(
                                    book.frontCover!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  )
                                : Container(color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          book.title ?? "No title",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                ),

                // Center(
                //   child: Row(
                //     mainAxisAlignment: .center,
                //     children: [
                //       TextButton.icon(
                //         onPressed: () {
                //           context.read<HomeViewModel>().previousPage();
                //         },
                //         label: Text("Previous Page"),
                //         icon: Icon(Icons.arrow_back),
                //       ),
                //       SizedBox(width: 8),
                //       TextButton.icon(
                //         onPressed: () {
                //           context.read<HomeViewModel>().nextPage();
                //         },
                //         label: Text("Next Page"),
                //         icon: Icon(Icons.arrow_forward),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 12),
                Divider(),
                SizedBox(height: 12),
                Row(
                  mainAxisSize: .min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<HomeViewModel>().previousPage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 18,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Previous Page",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        context.read<HomeViewModel>().nextPage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Next Page",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}

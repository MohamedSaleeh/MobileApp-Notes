import 'package:Memo/providers/accountProvider.dart';
import 'package:flutter/material.dart';
import 'package:Memo/packages/logo.dart';
import 'package:Memo/packages/note.dart';
import 'package:Memo/providers/navbarProvider.dart';
import 'package:Memo/providers/notesProvider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      final accountProvider = context.read<AccountProvider>();
      final notesProvider = context.read<NotesProvider>();

      final currentUserId = accountProvider.currentUserId;
      if (notesProvider.notes.isEmpty) {
        notesProvider.displayNotes(currentUserId);
      }
    });

    return Scaffold(
      bottomNavigationBar: Consumer<NavbarProvider>(
        builder: (context, value, child) => BottomNavigationBar(
          currentIndex: value.currentIndex,
          onTap: (val) {
            value.updateIndex(val);
            if (val == 1) {
              Navigator.pushNamed(context, "notesdetailspage");
            }
            if (val == 2) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                "profilepage",
                (route) => false,
              );
            }
          },
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Logo(withBreakLine: false, fontSize: 24),
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final isLoading = notesProvider.isLoading;
          final items = notesProvider.notes;
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: items.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Column(
                      children: [
                        SvgPicture.asset('images/empty.svg', height: 186),
                        const SizedBox(height: 32),
                        const Text(
                          'Create your first Memories',
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 24),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 64,
                              vertical: 12,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "notesdetailspage");
                          },
                          child: const Text("Create"),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final note = items[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "showdetailspage",
                            arguments: note,
                          );
                        },
                        child: Note(
                          date: note.createdAt.toString(),
                          title: note.title,
                          description: note.content,
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

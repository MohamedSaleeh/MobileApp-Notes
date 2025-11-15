import 'package:Memo/database/noteModel.dart';
import 'package:Memo/providers/accountProvider.dart';
import 'package:flutter/material.dart';
import 'package:Memo/formControls.dart';
import 'package:Memo/providers/navbarProvider.dart';
import 'package:Memo/providers/notesProvider.dart';

import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Notesdetailspage extends StatelessWidget {
  Notesdetailspage({super.key});
  void showSnackBar(BuildContext context, String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  final TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    dateController.text = DateTime.now().toString().substring(0, 10);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Back"),
        leading: IconButton(
          iconSize: 32,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<NavbarProvider>().updateIndex(0);
            Navigator.pushNamedAndRemoveUntil(
              context,
              "home",
              (route) => false,
            );
          },
        ),
      ),
      body: ReactiveForm(
        formGroup: notesFormgroup,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: 32,
          ),
          child: Column(
            children: [
              ReactiveTextField(
                formControlName: 'title',
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffFFF5F5),
                  hintText: 'Set an Title',
                  hintStyle: const TextStyle(color: Color(0xffAD7575)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ReactiveTextField(
                formControlName: 'date',
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffFFF5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ReactiveTextField(
                  formControlName: 'content',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffFFF5F5),
                    hintText: 'Type your Thoughts',
                    hintStyle: const TextStyle(color: Color(0xffAD7575)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  maxLines: 40,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  if (notesFormgroup.valid) {
                    await context.read<NotesProvider>().addNote(
                      Notemodel(
                        title: notesFormgroup.control('title').value,
                        content: notesFormgroup.control('content').value,
                        createdAt: DateTime.now(),
                        userId: context.read<AccountProvider>().currentUserId,
                      ),
                    );
                    notesFormgroup.control('title').value = '';
                    notesFormgroup.control('content').value = '';
                    context.read<NavbarProvider>().updateIndex(0);
                    Navigator.pop(context);
                    showSnackBar(context, 'Note added successfully', false);
                  } else {
                    notesFormgroup.markAllAsTouched();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

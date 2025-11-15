import 'package:Memo/providers/notesProvider.dart';
import 'package:flutter/material.dart';
import 'package:Memo/formControls.dart';
import 'package:Memo/packages/customDialog.dart';
import 'package:Memo/packages/logo.dart';
import 'package:Memo/packages/passwordDialog.dart';
import 'package:Memo/providers/accountProvider.dart';
import 'package:Memo/providers/navbarProvider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  void showSnackBar(BuildContext context, String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<NavbarProvider>(
        builder: (context, value, child) => BottomNavigationBar(
          currentIndex: value.currentIndex,
          onTap: (val) {
            value.updateIndex(val);
            if (val == 1) {
              Navigator.pushNamed(context, "notesdetailspage");
            }
            if (val == 0) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                "home",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 96),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 48, bottom: 24),
                  child: SvgPicture.asset('images/account.svg', height: 150),
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'Username',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Consumer<AccountProvider>(
                  builder: (context, account, child) {
                    return Text(
                      textAlign: TextAlign.center,
                      account.currentUser?.username ?? 'No Username',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff282828),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog(
                          textButton: 'Update',
                          title: 'Update Username',
                          hint: 'Enter new username',
                          controlName: 'username',
                          formGroup: profileFormgroup,
                          actionOK: () {
                            return () async {
                              final newUsername = profileFormgroup
                                  .control('username')
                                  .value;
                              if (newUsername.isNotEmpty) {
                                final isSuccess = await context
                                    .read<AccountProvider>()
                                    .updateUsername(newUsername);
                                if (isSuccess) {
                                  showSnackBar(
                                    context,
                                    'Username updated successfully',
                                    false,
                                  );
                                  Navigator.of(context).pop();
                                } else {
                                  showSnackBar(
                                    context,
                                    'Failed to update username',
                                    true,
                                  );
                                }
                              }
                            };
                          },
                        );
                      },
                    );
                  },
                  child: const Text('Update Username'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff282828),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog(
                          textButton: 'Update',
                          title: 'Update Email',
                          hint: 'Enter new email',
                          controlName: 'email',
                          formGroup: profileFormgroup,
                          actionOK: () {
                            return () async {
                              final newEmail = profileFormgroup
                                  .control('email')
                                  .value;
                              if (newEmail.isNotEmpty) {
                                final isSuccess = await context
                                    .read<AccountProvider>()
                                    .updateEmail(newEmail);
                                if (isSuccess) {
                                  showSnackBar(
                                    context,
                                    'Email updated successfully',
                                    false,
                                  );
                                  Navigator.of(context).pop();
                                } else {
                                  showSnackBar(
                                    context,
                                    'Email already exists or update failed',
                                    true,
                                  );
                                }
                              }
                            };
                          },
                        );
                      },
                    );
                  },
                  child: const Text('Update Email'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff282828),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PasswordDialog(
                          title: 'Update Password',
                          hint: const [
                            'Input old  Password',
                            'Input New  Password',
                            'Match New  Password',
                          ],
                          controlName: const [
                            'oldPassword',
                            'newPassword',
                            'matchNewPassword',
                          ],
                          textButton: 'Update',
                          actionOK: () {
                            return () async {
                              final oldPassword = profileFormgroup
                                  .control('oldPassword')
                                  .value;
                              final newPassword = profileFormgroup
                                  .control('newPassword')
                                  .value;
                              final matchPassword = profileFormgroup
                                  .control('matchNewPassword')
                                  .value;
                              final oldPasswordOfCurrentUser = context
                                  .read<AccountProvider>()
                                  .currentUser!
                                  .password;
                              if (oldPassword == oldPasswordOfCurrentUser) {
                                if (newPassword == matchPassword) {
                                  final isSuccess = await context
                                      .read<AccountProvider>()
                                      .updatePassword(oldPassword, newPassword);
                                  if (isSuccess) {
                                    showSnackBar(
                                      context,
                                      'Password updated successfully!',
                                      false,
                                    );
                                    Navigator.of(context).pop();
                                  } else {
                                    showSnackBar(
                                      context,
                                      'Old password is incorrect',
                                      true,
                                    );
                                  }
                                } else {
                                  showSnackBar(
                                    context,
                                    'Passwords do not match',
                                    true,
                                  );
                                }
                              } else {
                                showSnackBar(
                                  context,
                                  'Old password is incorrect',
                                  true,
                                );
                              }
                            };
                          },
                          formGroup: profileFormgroup,
                        );
                      },
                    );
                  },
                  child: const Text('Update Password'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff282828),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'deleteaccountpage');
                  },
                  child: const Text('Delete Account'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff282828),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    context.read<NotesProvider>().reset();
                    context.read<AccountProvider>().logout();

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'loginPage',
                      (root) => false,
                    );
                  },
                  child: const Text('Logout'),
                ),
                const SizedBox(height: 32),
                const Text("Read", style: TextStyle(fontSize: 12)),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: 'Terms and Condition',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:Memo/database/datebase.dart';
import 'package:Memo/database/noteModel.dart';
import 'package:flutter/widgets.dart';

class NotesProvider extends ChangeNotifier {
  SqlDb db = SqlDb();
  bool _isLoading = false;
int? _currentUserId;
  final List<Notemodel> _notes = [];

  List<Notemodel> get notes => _notes;

  bool get isLoading => _isLoading;

  Future<void> addNote(Notemodel note) async {
    await db.insertNote(note);
    _notes.insert(0, note);
    notifyListeners();
  }

  Future<void> displayNotes(int userId) async {
    _isLoading = true;
    notifyListeners();

    List<Notemodel> fetchedNotes = await db.getNotesByUserId(userId);
    _notes.clear();
    _notes.addAll(fetchedNotes);
     _currentUserId = userId;
    notifyListeners();
    _isLoading = false;
    notifyListeners();
  }

  void clearNotes(int userId) {
    db.deleteNotesByUser(userId);
    _notes.clear();
    _currentUserId = null;
    notifyListeners();
  }

   void reset() {
    _notes.clear();
    _currentUserId = null;
    _isLoading = false;
    notifyListeners();
  }
}

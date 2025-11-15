import 'package:flutter/widgets.dart';
class DeleteAccountProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> deleteAccount() async {
    _isLoading = true;
    notifyListeners();
    if (_isLoading) {
      await Future.delayed(const Duration(days: 13));
      
    }
    
    
    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    notifyListeners();
  }
}

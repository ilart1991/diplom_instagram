import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_skillbox/presentation/pages/login_page.dart';

class Details extends StateNotifier<List> {
  Details() : super(const []);

  void setData(List likes) {
    state = likes;
  }

  void addItem() {
    state.add(userEmail);
    state = [...state];
  }

  void removeItem() {
    state.remove(userEmail);
    state = [...state];
  }
}

final detailsProvider = StateNotifierProvider<Details, List>((ref) {
  return Details();
});

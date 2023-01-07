import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_skillbox/presentation/pages/login_page.dart';

class DetailsProvider extends StateNotifier<List> {
  DetailsProvider() : super(const []);

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

final listProvider = StateNotifierProvider<DetailsProvider, List>((ref) {
  return DetailsProvider();
});

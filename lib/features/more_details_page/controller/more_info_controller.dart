import 'package:flutter_riverpod/legacy.dart';
import '../repo/more_info_repo.dart';
import 'more_info_state.dart';

class MoreInfoController extends StateNotifier<MoreInfoState> {
  final MoreInfoRepo repo;

  MoreInfoController({required this.repo}) : super(const MoreInfoInitial());

  Future<void> getMoreInfo(String id) async {
    state = const MoreInfoLoading();
    try {
      final crypto = await repo.getMoreInfo(id);
      if (crypto != null) {
        state = MoreInfoLoaded(crypto);
      } else {
        state = const MoreInfoError('No data found');
      }
    } catch (e) {
      state = MoreInfoError(e.toString());
    }
  }
}

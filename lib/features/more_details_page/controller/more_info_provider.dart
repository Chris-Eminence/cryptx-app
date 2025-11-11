import 'package:cryptx/features/more_details_page/controller/more_info_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../repo/more_info_repo.dart';
import 'more_info_controller.dart';

final moreInfoRepoProvider = Provider<MoreInfoRepo>((ref) {
  return MoreInfoRepo();
});

final moreInfoNotifierProvider =
StateNotifierProvider<MoreInfoController, MoreInfoState>((ref) {
  final repo = ref.read(moreInfoRepoProvider);
  return MoreInfoController(repo: repo);
});

import 'package:cryptx/features/more_details_page/model/more_info_model.dart';

abstract class MoreInfoState {
  const MoreInfoState();
}

class MoreInfoInitial extends MoreInfoState {
  const MoreInfoInitial();
}

class MoreInfoLoading extends MoreInfoState {
  const MoreInfoLoading();
}

class MoreInfoLoaded extends MoreInfoState {
  final MoreInfoModel moreInfoModel;
  const MoreInfoLoaded(this.moreInfoModel);
}

class MoreInfoError extends MoreInfoState {
  final String message;
  const MoreInfoError(this.message);
}

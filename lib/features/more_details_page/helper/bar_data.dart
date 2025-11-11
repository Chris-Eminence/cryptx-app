import 'package:cryptx/features/more_details_page/helper/individual_bar.dart';

class BarData{

  final double sunData;
  final double monData;
   final double tueData;
  final double wedData;
  final double thuData;
  final double friData;
  final double satData;

  BarData({
    required this.sunData,
    required this.monData,
    required this.tueData,
    required this.wedData,
    required this.thuData,
    required this.friData,
    required this.satData,

  });

  List<IndividualBarData> barData = [];

  void initializeBarData(){
    barData = [
      IndividualBarData(x: 0, y: sunData),
      IndividualBarData(x: 1, y: monData),
      IndividualBarData(x: 2, y: tueData),
      IndividualBarData(x: 3, y: wedData),
      IndividualBarData(x: 4, y: thuData ),
      IndividualBarData(x: 5, y: friData),
      IndividualBarData(x: 6, y: satData)
    ];
  }
}
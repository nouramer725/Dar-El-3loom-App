
import 'package:dar_el_3loom/utils/size_config.dart';

double w(double value) {
  return value * SizeConfig.screenWidth / 430;
}

double h(double value) {
  return value * SizeConfig.screenHeight / 932;
}

double sp(double fontSize) => fontSize * SizeConfig.screenWidth / 430;

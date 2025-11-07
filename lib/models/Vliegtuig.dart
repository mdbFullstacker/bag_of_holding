import 'package:bag_of_holding/models/Voertuig.dart';

class Vliegtuig extends Voertuig {
  late bool flys;

  Vliegtuig(super.id, super.name, super.brand, super.wheels, super.passangers ) {
    this.flys = true;
  }

}
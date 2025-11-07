import 'package:bag_of_holding/models/Voertuig.dart';

class Boot extends Voertuig {
  late bool floats;

  Boot(super.id, super.name, super.brand, super.wheels, super.passangers, ) {
    this.floats = true;
  }

}
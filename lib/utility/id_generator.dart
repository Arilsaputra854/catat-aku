import 'dart:math';

class IdGenerator {

    String generateNumeric(){
      return Random().nextInt(999999999).toString();
    }

}
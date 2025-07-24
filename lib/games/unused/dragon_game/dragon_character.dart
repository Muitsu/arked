import 'dart:math';

class Dragon {
  List<Point<int>> dragon = [const Point(0, 0)];
  Point<int> direction = Constants.right;

  Point<int> get head {
    return dragon[0];
  }

  bool didBiteItself() {
    for (int i = 1; i < dragon.length; i++) {
      if (dragon[i] == head) {
        return true;
      }
    }
    return false;
  }

  bool pointOnDragon(Point<int> point) {
    for (Point body in dragon) {
      if (body == point) {
        return true;
      }
    }
    return false;
  }

  void update() {
    // For moving in a direction, move all body parts to the location of the
    // part before them
    for (int i = dragon.length - 1; i > 0; --i) {
      dragon[i] = dragon[i - 1];
    }
    // Then update in the direction dragon is moving
    dragon[0] = Point((head.x + direction.x) % 50, (head.y + direction.y) % 50);
  }

  void eatFood() {
    // Since food is added to the end and dragon would ultimately
    // Update one position, save the last location and append it again.
    var foodLoc = dragon.last;
    update();
    dragon.add(foodLoc);
  }
}

class Constants {
  // Canvas
  static const double canvasSize = 500;
  static const double blockSize = 10;

  // Directions
  static const up = Point(0, -1);
  static const down = Point(0, 1);
  static const right = Point(1, 0);
  static const left = Point(-1, 0);
}

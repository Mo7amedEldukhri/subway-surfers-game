import 'package:flame/components.dart';
import 'dart:math' as math;
import 'dart:ui';

class Coin extends PositionComponent {
  static const double coinSize = 30;

  double rotation = 0;

  Coin({required Vector2 position})
      : super(
          position: position,
          size: Vector2(coinSize, coinSize),
        );

  @override
  void update(double dt) {
    super.update(dt);
    rotation += 3;
  }

  bool isCollidingWith(dynamic other) {
    if (other == null) return false;

    // Use anchor-centred position for the player (anchor: Anchor.center)
    final otherCenter = Offset(
      other.position.x,
      other.position.y,
    );

    final thisCenter = Offset(
      position.x + size.x / 2,
      position.y + size.y / 2,
    );

    final distance = (otherCenter - thisCenter).distance;
    final collisionDistance = (size.x / 2) + (other.size.x / 2);

    return distance < collisionDistance;
  }

  @override
  void render(Canvas canvas) {
    canvas.save();

    canvas.translate(size.x / 2, size.y / 2);
    canvas.rotate(rotation * math.pi / 180);
    canvas.translate(-size.x / 2, -size.y / 2);

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      Paint()..color = const Color(0xFFFFB300),
    );

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      Paint()
        ..color = const Color(0xFFFFA000)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 4,
      Paint()
        ..color = const Color(0xFFFFA000)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    canvas.restore();
  }
}

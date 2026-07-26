import 'package:flame/components.dart';
import 'dart:ui';

class Obstacle extends PositionComponent {
  static const double obstacleWidth = 50;
  static const double obstacleHeight = 50;

  Obstacle({required Vector2 position})
      : super(
          position: position,
          size: Vector2(obstacleWidth, obstacleHeight),
        );

  bool isCollidingWith(dynamic other) {
    if (other == null) return false;

    // AABB collision using other's anchor-centred position
    final myLeft = position.x;
    final myRight = position.x + obstacleWidth;
    final myTop = position.y;
    final myBottom = position.y + obstacleHeight;

    final otherLeft = other.position.x - other.size.x / 2;
    final otherRight = other.position.x + other.size.x / 2;
    final otherTop = other.position.y - other.size.y / 2;
    final otherBottom = other.position.y + other.size.y / 2;

    return myLeft < otherRight &&
        myRight > otherLeft &&
        myTop < otherBottom &&
        myBottom > otherTop;
  }

  @override
  void render(Canvas canvas) {
    // Main body - red box
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, obstacleWidth, obstacleHeight),
        const Radius.circular(6),
      ),
      Paint()..color = const Color(0xFFE53935),
    );

    // X mark
    final linePaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      const Offset(10, 10),
      const Offset(obstacleWidth - 10, obstacleHeight - 10),
      linePaint,
    );
    canvas.drawLine(
      const Offset(obstacleWidth - 10, 10),
      const Offset(10, obstacleHeight - 10),
      linePaint,
    );
  }
}

import 'package:flame/game.dart';
import 'dart:math' as math;

class Coin extends PositionComponent {
  static const double coinSize = 30;
  
  double rotation = 0;
  
  Coin({required Vector2 position}) : super(
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
    
    final otherCenter = Offset(
      other.position.x + other.width / 2,
      other.position.y + other.height / 2,
    );
    
    final thisCenter = Offset(
      position.x + width / 2,
      position.y + height / 2,
    );
    
    final distance = (otherCenter - thisCenter).distance;
    final collisionDistance = (width / 2) + (other.width / 2);
    
    return distance < collisionDistance;
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    
    canvas.translate(width / 2, height / 2);
    canvas.rotate(rotation * math.pi / 180);
    canvas.translate(-width / 2, -height / 2);
    
    canvas.drawCircle(
      Offset(width / 2, height / 2),
      width / 2,
      Paint()..color = const Color(0xFFFFB300),
    );
    
    canvas.drawCircle(
      Offset(width / 2, height / 2),
      width / 2,
      Paint()
        ..color = const Color(0xFFFFA000)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    
    canvas.drawCircle(
      Offset(width / 2, height / 2),
      width / 4,
      Paint()
        ..color = const Color(0xFFFFA000)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
    
    canvas.restore();
  }
}

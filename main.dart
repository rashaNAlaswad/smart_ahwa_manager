import 'ahwa_app.dart';

void main() async {
  final app = SmartAhwaManager.create();
  await app.run();
}

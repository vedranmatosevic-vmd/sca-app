import 'package:firebase_database/firebase_database.dart';
import 'package:sca_app/models/match.dart';

class DatabaseService {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  addMatch(Match matchData) async {
    await _ref.child("users/vematosevic/matches").set(matchData.toMap());
  }


}


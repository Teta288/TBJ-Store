import 'package:cupertino_store/firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';
import 'model/app_state_model.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Stripe.publishableKey =
  "pk_test_51MyEmZFQsYZxmyn4vVYsmru65aMsJWu9BPd53ebHgsPyCqmJqdp14ztkCS2haz0t7Xl3J1XSumfN8KeAuSbZXsYg00wA2lSXrn";
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      create: (_) => AppStateModel()..loadProducts(),
      child: const CupertinoStoreApp(),
    ),
  );
}

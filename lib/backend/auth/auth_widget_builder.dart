import 'package:flutter/material.dart';
import '../service/databaseService.dart';
import '../service/firebase_auth_service.dart';
import '../service/firebase_storage_service.dart';
import '../service/firestore_service.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key? key, required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<LoggedInUser?>) builder;
  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return StreamBuilder<LoggedInUser?>(
        stream: authService.onAuthStateChanged,
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user != null) {
            return MultiProvider(
                providers: [
                  Provider<LoggedInUser>.value(value: user),
                  Provider<FirebaseStorageService>(
                    create: (_) => FirebaseStorageService(uid: user.uid!),
                  ),
                  Provider<DatabaseService>(
                    create: (_) => DatabaseService(uid: user.uid!),
                  ),
                  Provider<FirestoreService>(
                    create: (_) => FirestoreService(uid: user.uid!),
                  ),
                ],
                child: Consumer<DatabaseService>(
                    builder: (_, databaseService, __) {
                  return builder(context, snapshot);
                }));
          }
          return builder(context, snapshot);
        });
  }
}

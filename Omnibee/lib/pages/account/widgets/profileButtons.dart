import 'package:Omnibee/bloc/blocs.dart';
import 'package:Omnibee/models/models.dart';
import 'package:Omnibee/pages/account/widgets/customTile.dart';
import 'package:Omnibee/services/paymentService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileContact extends StatelessWidget {
  final Function signOut;

  ProfileContact(this.signOut);

  void _performSetup(User user) {
    PaymentService.createAccount(user.email);
  }

  Function _showHelpInfo(BuildContext context) {
    return () {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: RichText(
                      text: TextSpan(children: [
                    new TextSpan(
                      text:
                          'You can view a list of frequently asked questions ',
                      style: new TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    new TextSpan(
                      text: 'here. ',
                      style: new TextStyle(color: Colors.blue, fontSize: 18),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://omnibee.io/faq');
                        },
                    ),
                    new TextSpan(
                      text:
                          'If you need more help, please contact us by phone or email. \n\nhello@omnibee.io\n(607)269-8901 (Urgent) ',
                      style: new TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ]))),
              Center(
                child: CupertinoButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ],
          );
        },
      );
    };
  }

  void _showSetupInfo(BuildContext context, User user) {
    print("Showing bottom sheet");
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text(
                'Setup a payment account to get paid after your delivery!',
                style: TextStyle(fontSize: 19),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text('Please wait up to 10 seconds for the form to load.',
                  style: TextStyle(fontSize: 19)),
            ),
            CupertinoButton(
                color: Theme.of(context).primaryColor,
                child: Text("Set Up Payments"),
                onPressed: () {
                  _performSetup(user);
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                User user = (state as Authenticated).user;
                print(user.stripeSetupComplete);
                if (!user.stripeSetupComplete) {
                  print("Showing set up info");
                  _showSetupInfo(context, user);
                } else {
                  final snackBar = SnackBar(
                    content: Text('Runner setup already complete!'),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(),
                ),
                child: ListTile(
                  title: Text(
                    "Become a Runner",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
            ),
            CustomTile(label: 'Help', onTap: _showHelpInfo(context)),
            CustomTile(
                label: 'Feedback',
                onTap: () {
                  //TODO: change to feedback form
                  launch('https://omnibee.io/faq');
                }),
            CustomTile(label: 'Log out', onTap: signOut),
          ],
        ),
      );
    });
  }
}

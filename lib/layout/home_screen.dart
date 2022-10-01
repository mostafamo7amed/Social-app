import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/shared/components/component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News feed'),
          ),
          body: Column(
            children: [
              if (!FirebaseAuth.instance.currentUser!.emailVerified)
                Container(
                  height: 50,
                  color: Colors.amber.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(child: Text('Please Verify your email')),
                        TextButton(onPressed: () {
                          FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
                            toast(message: 'check your mail', data: ToastStates.success);
                          }).catchError((e){
                            toast(message: e.toString(), data: ToastStates.error);
                          });
                        }, child: const Text('Send')),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

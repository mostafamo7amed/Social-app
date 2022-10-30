import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';

import '../../styles/icons_broken.dart';

class CommentsScreen extends StatelessWidget {

  CommentsScreen(this.postId, {Key? key}) : super(key: key);
  String postId;
  var commentController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.getCubit(context);
        return SafeArea(
          child: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Text('Comments'),
                        Spacer(),
                        Icon(IconBroken.Heart),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: commentController,
                            maxLines: null,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      height: 1.5,
                                    ),
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                              hintText: 'Write a comment',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'comment can not be empty';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              cubit.commentPost(postId, commentController.text);
                            }
                          },
                          icon: const Icon(
                            IconBroken.Send,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

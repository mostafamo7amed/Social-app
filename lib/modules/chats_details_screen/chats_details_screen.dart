import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';

import '../../styles/icons_broken.dart';

class ChatsDetailsScreen extends StatelessWidget {
  UserModel model;
  ChatsDetailsScreen(this.model, {super.key});
  var chatController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.getCubit(context).getMessage(
            receiverId: model.uid!
        );
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialCubit.getCubit(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage('${model.image}'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${model.name}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              var messages = SocialCubit.getCubit(context).messages[index];
                              var cubit  = SocialCubit.getCubit(context);
                              if(cubit.userModel!.uid == messages.sender){
                                return buildSenderMessage(messages);
                              }else{
                                return buildReceiverMessage(messages);
                              }
                            },
                            separatorBuilder: (context, index) => const SizedBox(height: 10,),
                            itemCount: SocialCubit.getCubit(context).messages.length),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: chatController,
                              maxLines: null,
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                height: 1.5,
                              ),
                              decoration: const InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                hintText: 'Write a comment',
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                cubit.sendMessage(
                                  receiverId: model.uid!,
                                  text: chatController.text,
                                  dateTime: DateTime.now().toString(),
                                );
                                chatController.text = '';
                              }
                            },
                            icon: const Icon(
                              IconBroken.Send,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


  Widget buildSenderMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            ),
          ),
          child: Text('${model.text}'),
        ),
      );

  Widget buildReceiverMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: const BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomStart: Radius.circular(10),
            ),
          ),
          child: Text('${model.text}'),
        ),
      );
}

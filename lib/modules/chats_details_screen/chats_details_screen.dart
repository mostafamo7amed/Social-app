import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';

import '../../styles/icons_broken.dart';

class ChatsDetailsScreen extends StatelessWidget {
  final UserModel model;
  ChatsDetailsScreen(this.model, {super.key});
  final chatController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.getCubit(context).getMessage(receiverId: model.uid!);
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var messages =
                                  SocialCubit.getCubit(context).messages[index];
                              var cubit = SocialCubit.getCubit(context);
                              if (cubit.userModel!.uid == messages.sender) {
                                if (messages.text == 'image') {
                                  return buildSenderImage(messages, context);
                                } else {
                                  return buildSenderMessage(messages, context);
                                }
                              } else {
                                if (messages.text == 'image') {
                                  return buildReceiverImage(messages,context);
                                } else {
                                  return buildReceiverMessage(
                                      messages, context);
                                }
                              }
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            itemCount:
                                SocialCubit.getCubit(context).messages.length),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: chatController,
                              maxLines: null,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    height: 1.5,
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                  ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                hintText: 'Message',
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
                              cubit.getMessageImage(
                                receiverId: model.uid!,
                                dateTime: DateTime.now().toString(),
                              );
                            },
                            icon: const Icon(
                              IconBroken.Image,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
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

  Widget buildSenderMessage(MessageModel model, context) {
    DateTime time = DateTime.parse(model.dateTime!);
    String formattedTime = DateFormat('kk:mm a').format(time);

    return Align(
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
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      height: 1.5,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
            Text(
              formattedTime,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    height: 1.3,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReceiverMessage(MessageModel model, context) {
    DateTime time = DateTime.parse(model.dateTime!);
    String formattedTime = DateFormat('kk:mm a').format(time);
    return Align(
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
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  height: 1.5,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Text(
              formattedTime,
              style: Theme.of(context).textTheme.caption!.copyWith(
                height: 1.3,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReceiverImage(MessageModel model,context) {
    DateTime time = DateTime.parse(model.dateTime!);
    String formattedTime = DateFormat('kk:mm a').format(time);
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            height: 150,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                bottomStart: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(model.image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              formattedTime,
              style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.white,
                height: 1.3,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSenderImage(MessageModel model, context) {
    DateTime time = DateTime.parse(model.dateTime!);
    String formattedTime = DateFormat('kk:mm a').format(time);
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            height: 150,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                bottomEnd: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(model.image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              formattedTime,
              style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.white,
                height: 1.3,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

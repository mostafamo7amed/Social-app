import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/shared/components/component.dart';

import '../../styles/icons_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
        if(state is SocialCreatePostSuccessState){
          textController.clear();
          SocialCubit.getCubit(context).removePostImage();
        }
      },
      builder: (context, state) {
        var userModel = SocialCubit.getCubit(context).userModel;
        var cubit = SocialCubit.getCubit(context);
        return Scaffold(
          appBar: defaultAppBar(context: context, title: 'Create post', actions: [
            TextButton(
              onPressed: () {
                String dateTime =  DateTime.now().toString();
                if(formKey.currentState!.validate()){
                  if(cubit.postImage == null){
                    cubit.createPost(text: textController.text, dateTime: dateTime);
                  }else{
                    cubit.uploadPostImage(text: textController.text, dateTime: dateTime);
                  }
                }
              },
              child: const Text(
                'Post',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is SocialUploadPostImageLoadingState || state is SocialCreatePostLoadingState)
                    const LinearProgressIndicator(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            '${userModel!.image}',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userModel.name}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: textController,
                      maxLines: null,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(
                        height: 1.5,
                      ),
                      decoration: const InputDecoration(
                        hintText: ' what in your mind ?',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'text can not be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    if(cubit.postImage!= null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Wrap(
                              children: [
                                Container(
                                  height: 260,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                      image: FileImage(cubit.postImage!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 15,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  cubit.removePostImage();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            children: const [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5,
                              ),
                              Text('add photo'),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('#Tags'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

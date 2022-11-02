import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats_details_screen/chats_details_screen.dart';
import 'package:social_app/shared/components/component.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.getCubit(context);
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildChatItem(cubit.users[index], context),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
            itemCount: cubit.users.length);
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
    onTap: () {
      navigateTo(context, ChatsDetailsScreen(model));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  '${model.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        height: 1.5,
                      ),
                ),
              ),
            ],
          ),
    ),
  );
}

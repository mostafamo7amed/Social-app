import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/feeds_screen/comments_screen.dart';
import 'package:social_app/shared/components/component.dart';
import '../../styles/icons_broken.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.getCubit(context);
        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty && cubit.userModel!=null,
          builder: (context) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  child: Stack(alignment: Alignment.bottomRight, children: [
                    Image.network(
                      'https://img.freepik.com/free-photo/horizontal-shot-pretty-dark-skinned-woman-with-afro-hairstyle-has-broad-smile-white-teeth-shows-something-nice-friend-points-upper-right-corner-stands-against-wall_273609-16442.jpg?w=740&t=st=1664820100~exp=1664820700~hmac=ebac4c69137e4603dfe88dc5b9ec65cd97a954e57c9532649a2a4ea3d77e3b17',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Communicate with friends',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ]),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => postBuilder(cubit.posts[index], context,index),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                    itemCount: cubit.posts.length),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget postBuilder(PostModel model, context,index) {
    return  Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${model.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 15,
                          ),
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconBroken.More_Circle,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                height: 1.3,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            //tags
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style:
                            Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style:
                            Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style:
                            Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style:
                            Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style:
                            Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style:
                            Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style:
                            Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                    '${model.postImage}',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 20,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${SocialCubit.getCubit(context).likes[index]}',
                          style:
                          Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  const Spacer(),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Chat,
                          size: 20,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${SocialCubit.getCubit(context).comment[index]}',
                          style:
                          Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      navigateTo(context, CommentsScreen(SocialCubit.getCubit(context).postId[index]));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              '${SocialCubit.getCubit(context).userModel!.image}'
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'write comment...',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                          Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 22,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'like',
                          style:
                          Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      var cubit = SocialCubit.getCubit(context);
                      cubit.likePost(cubit.postId[index]);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.share,
                          size: 22,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'share',
                          style:
                          Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 3,
            )
          ],
        ),
      ),
    );
  }




  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    print(formattedTime);
    print(formattedDate);
  }
}

import 'package:flutter/material.dart';
import '../../styles/icons_broken.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              itemBuilder: (context, index) => postBuilder(context),
              separatorBuilder: (context, index) => const SizedBox(height: 5,),
              itemCount: 10),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget postBuilder(context) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=740&t=st=1664964381~exp=1664964981~hmac=9959189edadcf63760040449df60e6c6bf10f9b0115341bf117a5b7ca83ee347',
                    ),
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
                            Text(
                              'Mostafa Mohamed',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    height: 1.5,
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
                          'Jun 21 , 2022 at 11:00 am',
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
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      height: 1.3,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              SizedBox(
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
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  'https://img.freepik.com/free-photo/horizontal-shot-pretty-dark-skinned-woman-with-afro-hairstyle-has-broad-smile-white-teeth-shows-something-nice-friend-points-upper-right-corner-stands-against-wall_273609-16442.jpg?w=740&t=st=1664820100~exp=1664820700~hmac=ebac4c69137e4603dfe88dc5b9ec65cd97a954e57c9532649a2a4ea3d77e3b17',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 140,
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
                            '120',
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
                            '85 comment',
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
                      onTap: () {},
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=740&t=st=1664964381~exp=1664964981~hmac=9959189edadcf63760040449df60e6c6bf10f9b0115341bf117a5b7ca83ee347',
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
                      onTap: () {},
                    ),
                    const SizedBox(
                      width: 5,
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

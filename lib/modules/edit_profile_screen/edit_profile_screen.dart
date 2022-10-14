import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/social_cubit/cubit.dart';
import '../../cubit/social_cubit/states.dart';
import '../../shared/components/component.dart';
import '../../styles/icons_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.getCubit(context).userModel;
        var cubit = SocialCubit.getCubit(context);
        nameController.text = model!.name!;
        phoneController.text = model.phone!;
        bioController.text = model.bio!;


        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit profile',
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 190,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: cubit.coverImage ==null? Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${model.cover}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ) :Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0),
                                    ),
                                    image: DecorationImage(
                                      image: FileImage(cubit.coverImage!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      cubit.getCoverImage();
                                    },
                                    icon: const Icon(
                                      IconBroken.Camera,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 58,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: cubit.profileImage==null? CircleAvatar(
                                  radius: 55,
                                  backgroundImage: NetworkImage('${model.image}'),

                                ): CircleAvatar(
                                  radius: 55,
                                  backgroundImage: FileImage(cubit.profileImage!),

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      cubit.getProfileImage();
                                    },
                                    icon: const Icon(
                                      IconBroken.Camera,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        controller: nameController,
                        label: 'Name',
                        prefix: const Icon(IconBroken.User),
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'name can not be empty';
                          }
                          return null;
                        },
                        type: TextInputType.text,
                        context: context),
                    const SizedBox(height: 10,),
                    defaultFormField(
                        controller: phoneController,
                        label: 'Phone',
                        prefix: const Icon(IconBroken.Call),
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'phone can not be empty';
                          }
                          return null;
                        },
                        type: TextInputType.number,
                        context: context),
                    const SizedBox(height: 10,),
                    defaultFormField(
                        controller: bioController,
                        label: 'Bio',
                        prefix: const Icon(IconBroken.Info_Circle),
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'bio can not be empty';
                          }
                          return null;
                        },
                        type: TextInputType.text,
                        context: context),
                    const SizedBox(height: 10,),
                    defaultButton(onPressed: (){
                      cubit.updateUsersProfile(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                    }, text: 'Update'),
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

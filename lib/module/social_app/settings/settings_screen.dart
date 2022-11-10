import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/social_app/cubit/social_cubit.dart';
import 'package:flutter_udemy_course/layout/social_app/cubit/social_states.dart';

class SettingsScreens extends StatelessWidget {
  const SettingsScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = SocialCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      child: Card(
                        elevation: 10,
                        margin: EdgeInsets.all(8),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          image: NetworkImage(
                            "${list!.cover}",
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150,
                        ),
                      ),
                      alignment: Alignment.topCenter,
                    ),
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      radius: 53,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        "${list.image}",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "${list.name}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${list.bio}",
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.grey,
                    ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "100",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "posts",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "330",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "photos",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "300",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "followers",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "146",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "following",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text("Add Photo"),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Icon(Icons.edit),
                      ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

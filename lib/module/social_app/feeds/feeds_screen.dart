import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udemy_course/shared/style/colors.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Card(
            elevation: 10,
            margin: EdgeInsets.all(8),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Image(
                  image: NetworkImage(
                    "https://i.pinimg.com/564x/2d/44/2b/2d442b5a0e8bd15f67265c889cd55948.jpg",
                  ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "communicate with your friends ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemBuilder: (context, index) {
              return buildPostItem(context);
            },
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget buildPostItem(context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        "https://i.pinimg.com/564x/55/1b/7e/551b7e10fcf25b588e8ab4be5351e91d.jpg",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("salaheldin saleh ",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        height: 1.5, color: Colors.black)),
                            SizedBox(width: 8),
                            Icon(
                              Icons.check_circle,
                              size: 18,
                              color: primaryColor,
                            )
                          ],
                        ),
                        Text("january 21, 2021 at 11:00 pm",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.1, color: Colors.grey[800]))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.more_horiz),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 1.1,
                      height: 15,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Text(
                        "#software",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: primaryColor, height: 1.1),
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    MaterialButton(
                      minWidth: 1.1,
                      height: 15,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Text(
                        "#software",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: primaryColor, height: 1.1),
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    MaterialButton(
                      minWidth: 1.1,
                      height: 15,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Text(
                        "#software_development",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: primaryColor, height: 1.1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Image(
                    image: NetworkImage(
                      "https://i.pinimg.com/564x/f5/ba/8a/f5ba8ad7dc49addb515d9b92e52e854e.jpg",
                    ),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180,
                  ),
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            Text("120")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.comment,
                              color: Colors.amber,
                            ),
                            Text("512 comment")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                        "https://i.pinimg.com/564x/55/1b/7e/551b7e10fcf25b588e8ab4be5351e91d.jpg",
                      ),
                    ),
                  ),
                  Text("write a comment ...."),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  Text("120")
                ],
              )
            ],
          ),
        ),
      );
}

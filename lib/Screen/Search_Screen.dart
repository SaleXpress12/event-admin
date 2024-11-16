import 'package:evente_mobile_admin_app/widget/cardUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dialog/snacbar.dart';
import '../../widget/empty_screen.dart';
import '../bloc/search_bloc.dart';



class SearchPageUser extends StatefulWidget {
  const SearchPageUser({Key? key}) : super(key: key);

  @override
  _SearchPageUserState createState() => _SearchPageUserState();
}

class _SearchPageUserState extends State<SearchPageUser> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0))
    .then((value) => context.read<SearchBloc>().saerchInitialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: _searchBar(),
      ),
      key: scaffoldKey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // suggestion text

            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 15, bottom: 5, right: 15),
              child: Text(
                context.watch<SearchBloc>().searchStarted == false
                    ? 'Recent searchs'
                    : 'We have found',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            context.watch<SearchBloc>().searchStarted == false
                ? const SuggestionsUI()
                : const AfterSearchUI()
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color:Colors.white),
      child: TextFormField(
        autofocus: true,
        controller: context.watch<SearchBloc>().textfieldCtrl,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search item" ,
          hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color:Colors.black54),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.close,
              size: 25,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              context.read<SearchBloc>().saerchInitialize();
            },
          ),
        ),
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) {
          if (value == '') {
            openSnacbar(scaffoldKey, 'Type something!');
          } else {
            context.read<SearchBloc>().setSearchText(value);
            context.read<SearchBloc>().addToSearchList(value);
          }
        },
      ),
    );
  }
}

class SuggestionsUI extends StatelessWidget {
  const SuggestionsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SearchBloc>();
    return Expanded(
      child: sb.recentSearchData.isEmpty
          ?const EmptyScreen()
          : ListView.separated(
              padding: const EdgeInsets.all(15),
              itemCount: sb.recentSearchData.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListTile(
                    title: Text(
                      sb.recentSearchData[index],
                      style: const TextStyle(fontSize: 17),
                    ),
                    leading: Icon(
                      CupertinoIcons.time_solid,
                      color: Colors.grey[400],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context
                            .read<SearchBloc>()
                            .removeFromSearchList(sb.recentSearchData[index]);
                      },
                    ),
                    onTap: () {
                      context
                          .read<SearchBloc>()
                          .setSearchText(sb.recentSearchData[index]);
                    },
                  ),
                );
              },
            ),
    );
  }
}

class AfterSearchUI extends StatelessWidget {
  const AfterSearchUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: context.watch<SearchBloc>().getDataUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return const EmptyScreen();
            } else {
              return ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CardUSer(
                      user: snapshot.data[index], heroTag: 'search$index');
                },
              );
            }
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

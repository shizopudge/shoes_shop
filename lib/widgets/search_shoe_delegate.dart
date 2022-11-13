import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shoes_app_ui_training/common/error_text.dart';
import 'package:shoes_app_ui_training/common/loader.dart';

import 'package:shoes_app_ui_training/shoes/controller/shoes_controller.dart';
import 'package:shoes_app_ui_training/utils/styles.dart';

class SearchShoeDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchShoeDelegate(this.ref);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (() {
          query = '';
        }),
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(searchShoeProvider(query)).when(
        data: (communities) => ListView.builder(
            itemCount: communities.length,
            itemBuilder: (BuildContext context, int index) {
              final shoe = communities[index];
              return ListTile(
                contentPadding: const EdgeInsets.all(8),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(shoe.image),
                  radius: 30,
                ),
                title: Text(
                  shoe.title,
                  style: textstyle2.copyWith(fontSize: 18),
                ),
                onTap: () => navigateToShoeScreen(context, shoe.id),
              );
            }),
        error: ((error, stackTrace) => ErrorText(
              error: error.toString(),
            )),
        loading: (() => const Loader()));
  }

  void navigateToShoeScreen(BuildContext context, String shoeId) {
    Routemaster.of(context).push('/shoe-screen/$shoeId');
  }
}

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_app/common/base/widgets/points_container.dart';
import 'package:test_task_app/constants/app_colors.dart';
import 'package:test_task_app/constants/app_string.dart';
import 'package:test_task_app/data/models/character_model.dart';
import 'package:test_task_app/screens/home/fragments/characters_data_inherited.dart';
import 'package:test_task_app/screens/home/fragments/list/list_vm.dart';

class ListPage extends StatefulWidget {
  final TabController tabController;
  const ListPage({super.key, required this.tabController});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  _moveToHomeTab(int characterIndex) {
    setState(() {
      widget.tabController.animateTo(0);
      var a = CharactersData.of(context);
      a.indexContainer?['index'] = characterIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.homeScreen),
        centerTitle: true,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.dark01,
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    final vm = Provider.of<ListVM>(context);

    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(children: [
          PointsContainer(
            total: vm.totalAttempts,
            success: vm.successAttempts,
            failed: vm.failedAttempts,
          ),
          _buildSearchField(),
          _buildList(vm.searchResult),
        ]));
  }

  _buildSearchField() {
    final vm = Provider.of<ListVM>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: AppString.filterCharacters,
          suffixIcon: const Icon(Icons.search, color: AppColors.dark01),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(0.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(0.0),
            ),
          ),
        ),
        onChanged: (value) {
          vm.onSearchChanged(value);
        },
      ),
    );
  }

  _buildList(List<CharacterModel> characters) {
    return Expanded(
      child: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (context, index) => _buildItem(characters[index], index),
      ),
    );
  }

  _buildItem(CharacterModel character, int characterIdex) {
    final vm = Provider.of<ListVM>(context);
    return InkWell(
      onTap: () {
        vm.navigateToItemPage(character);
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Row(
            children: [
              _buildImage(character.image),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('${AppString.attempts}:  ${character.totalAttempt}'),
                  ],
                ),
              ),
              const Spacer(),
              ..._buildStatusIcon(character.successAttempt > 0, characterIdex),
            ],
          )),
    );
  }

  _buildImage(String url) {
    return CachedNetworkImage(
      height: 50,
      width: 40,
      fit: BoxFit.cover,
      imageUrl: url,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      errorListener: (value) {
        debugPrint(value.toString());
      },
    );
  }

  List<Widget> _buildStatusIcon(bool isCheck, int characterIndex) {
    if (isCheck) {
      return [
        const Icon(
          Icons.check_circle_outline,
          color: AppColors.blue100,
          size: 32,
        )
      ];
    } else {
      return [
        IconButton(
          splashColor: AppColors.transparent,
          splashRadius: 0.1,
          icon: const Icon(Icons.repeat_rounded, size: 32),
          onPressed: () {
            _moveToHomeTab(characterIndex);
          },
        ),
        const SizedBox(width: 16),
        const Icon(Icons.cancel_outlined, color: AppColors.red100, size: 32),
      ];
    }
  }
}

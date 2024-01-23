import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_task_app/common/base/widgets/points_container.dart';
import 'package:test_task_app/constants/app_colors.dart';
import 'package:test_task_app/constants/app_string.dart';
import 'package:test_task_app/data/models/house_model.dart';
import 'package:test_task_app/screens/home/fragments/characters_data_inherited.dart';
import 'package:test_task_app/screens/home/fragments/home/home_vm.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final TabController tabController;

  const HomePage({Key? key, required this.tabController}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.tabController.addListener(_handleTabChange);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final vm = Provider.of<HomeVM>(context);
    if (!vm.isDataReceived) {
      vm.isDataReceived = true;
      var a = CharactersData.of(context);
      vm.characterIndex = a.indexContainer?['index'] ?? 0;
    }
    super.didChangeDependencies();
  }

  _handleTabChange() {
    if (mounted && widget.tabController.index == 1 && widget.tabController.indexIsChanging) {
      final vm = Provider.of<HomeVM>(context, listen: false);
      vm.saveDataOnTabChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    final vm = Provider.of<HomeVM>(context);
    return vm.isLoading
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.blue100,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(AppString.homeScreen),
              centerTitle: true,
              actions: [
                _resetButton(),
              ],
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.dark01,
              automaticallyImplyLeading: false,
            ),
            body: _buildBody(),
          );
  }

  _resetButton() {
    final vm = Provider.of<HomeVM>(context);
    return TextButton(
      onPressed: () {
        vm.onResetButtonTap();
      },
      child: Text(
        AppString.reset,
        style: const TextStyle(color: AppColors.dark01),
      ),
    );
  }

  _buildBody() {
    final vm = Provider.of<HomeVM>(context);
    return RefreshIndicator(
      onRefresh: () {
        return vm.onRefresh();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PointsContainer(
                total: vm.characters[vm.characterIndex].totalAttempt,
                success: vm.characters[vm.characterIndex].successAttempt,
                failed: vm.characters[vm.characterIndex].failedAttempt,
              ),
              const SizedBox(height: 24),
              _buildImage(vm.characters[vm.characterIndex].image),
              _buildName(vm.characters[vm.characterIndex].name),
              _buildHouseButtons(vm.houses),
              _buildNotInHouseButton(),
            ],
          ),
        ),
      ),
    );
  }

  _buildImage(String url) {
    return CachedNetworkImage(
      height: 200,
      width: 160,
      fit: BoxFit.cover,
      imageUrl: url,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  _buildName(String name) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        name,
        style: const TextStyle(color: AppColors.dark01, fontSize: 14),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
    );
  }

  _buildHouseButtons(List<House> houses) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 2,
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      itemCount: houses.length,
      itemBuilder: (context, index) {
        return _buildHouseCell(houses[index]);
      },
    );
  }

  _buildNotInHouseButton() {
    final vm = Provider.of<HomeVM>(context);
    return InkWell(
      onTap: () {
        String result = vm.notInHouseButton();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.dark04,
            content: Text(result),
            duration: const Duration(milliseconds: 200),
          ),
        );
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.dark01,
          ),
        ),
        child: Center(
          child: Text(
            AppString.notInHouse,
          ),
        ),
      ),
    );
  }

  _buildHouseCell(House house) {
    final vm = Provider.of<HomeVM>(context);
    return InkWell(
      onTap: () {
        String result = vm.onHouseCellTap(house);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.dark04,
            content: Text(result),
            duration: const Duration(milliseconds: 200),
          ),
        );
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.dark01,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                house.assetImage,
                height: 30,
                width: 30,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 4),
              Text(house.name),
            ],
          ),
        ),
      ),
    );
  }
}

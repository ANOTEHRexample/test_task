import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_task_app/constants/app_colors.dart';
import 'package:test_task_app/constants/app_string.dart';
import 'package:test_task_app/screens/item/item_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _BookPageState();
}

class _BookPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ItemVM>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          vm.character.name,
          style: const TextStyle(color: AppColors.dark01),
        ),
        automaticallyImplyLeading: false,
        leading: _buildBackButton(),
        leadingWidth: 100,
        centerTitle: true,
      ),
      backgroundColor: AppColors.white,
      body: vm.isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.blue100,
                ),
              ),
            )
          : _body(context),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const Flexible(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: AppColors.dark01,
              ),
              SizedBox(width: 4),
              Text(
                'Back',
                style: TextStyle(
                  color: AppColors.dark01,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final vm = Provider.of<ItemVM>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildImage(),
          const SizedBox(width: 16),
          Expanded(
            child: vm.character.successAttempt > 0 ? _buildDescription() : _buildAccessDenied(),
          ),
        ],
      ),
    );
  }

  _buildImage() {
    final vm = Provider.of<ItemVM>(context);
    return Expanded(
      child: CachedNetworkImage(
        height: 250,
        width: 160,
        fit: BoxFit.cover,
        imageUrl: vm.character.image,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        errorListener: (value) {
          debugPrint(value.toString());
        },
      ),
    );
  }

  _buildDescription() {
    final vm = Provider.of<ItemVM>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${AppString.house}: ${vm.character.house}'),
            const SizedBox(height: 16),
            Text('${AppString.dateOfBirth}: ${vm.character.dateOfBirth}'),
            const SizedBox(height: 16),
            Text('${AppString.actor}: ${vm.character.actor}'),
            const SizedBox(height: 16),
            Text('${AppString.species}: ${vm.character.species}'),
          ],
        ),
      ),
    );
  }

  _buildAccessDenied() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.red100,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(
          AppString.accessDenied,
          style: const TextStyle(
            color: AppColors.red100,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

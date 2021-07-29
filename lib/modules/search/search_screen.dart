import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: searchController,
                      onSubmit: (String value) {
                        SearchCubit.get(context).getSearch(value);
                      },
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Enter text to search';
                        }
                        return null;
                      },
                      prefix: Icons.search,
                      label: 'Search',
                      inputType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ConditionalBuilder(
                          condition: state is! SearchLoadingState,
                          builder: (context) => ListView.separated(
                            itemBuilder: (context, index) => buildFavItem(
                                SearchCubit.get(context)
                                    .searchModel
                                    .data
                                    .data[index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: SearchCubit.get(context)
                                .searchModel
                                .data
                                .data
                                .length,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

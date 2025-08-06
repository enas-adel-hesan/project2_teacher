import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../app_links.dart';
import '../../../core/errors/network/network_info.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/handle_network_call.dart';
import 'state.dart';
import 'package:teacher/data/models/category_model.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final NetworkInfo networkInfo = GetIt.I<NetworkInfo>();

  CategoriesCubit() : super(InitialState());

  Future<void> getCategories() async {
    emit(LoadingState());

    final result = await handleNetworkCall<CategoryModel>(
      networkInfo: networkInfo,
      apiCall: getCategoriesRequest,
    );

    result.fold(
          (failure) => emit(ErrorState(failure.message)),
          (categoryModel) => emit(SuccessState(categoryModel.data ?? [])),
    );
  }

  Future<CategoryModel> getCategoriesRequest() async {

    final response = await DioHelper.getData(url: AppLinks.categories);
    return CategoryModel.fromJson(response.data);
  }
}

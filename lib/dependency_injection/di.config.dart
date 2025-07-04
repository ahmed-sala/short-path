// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../config/helpers/dio_module.dart' as _i644;
import '../config/helpers/firestore/firestore_module.dart' as _i240;
import '../config/helpers/firestore/firestore_services.dart' as _i635;
import '../config/helpers/shared_pref/shared_pref_module.dart' as _i222;
import '../src/data/api/api_services.dart' as _i687;
import '../src/data/api/dio_client.dart' as _i885;
import '../src/data/api/network_factory.dart' as _i13;
import '../src/data/data_source/offline_data_source/auth/contracts/auth_offline_datasource.dart'
    as _i990;
import '../src/data/data_source/offline_data_source/auth/impl/auth_offline_datasource_impl.dart'
    as _i718;
import '../src/data/data_source/online_data_source/auth/contracts/auth_online_datasource.dart'
    as _i144;
import '../src/data/data_source/online_data_source/auth/impl/auth_online_datasource_impl.dart'
    as _i116;
import '../src/data/data_source/online_data_source/career/contract/career_online_datasource.dart'
    as _i658;
import '../src/data/data_source/online_data_source/career/impl/career_online_datasource_impl.dart'
    as _i656;
import '../src/data/data_source/online_data_source/home/contract/home_online_datasource.dart'
    as _i177;
import '../src/data/data_source/online_data_source/home/impl/home_online_datasource_impl.dart'
    as _i36;
import '../src/data/data_source/online_data_source/profile/contracts/profile_online_datasource.dart'
    as _i263;
import '../src/data/data_source/online_data_source/profile/contracts/user_info_online_datasource.dart'
    as _i747;
import '../src/data/data_source/online_data_source/profile/impl/profile_online_datasource_impl.dart'
    as _i636;
import '../src/data/data_source/online_data_source/profile/impl/user_info_online_datasource_impl.dart'
    as _i699;
import '../src/data/data_source/online_data_source/user_info/contracts/user_info_online_datasource.dart'
    as _i468;
import '../src/data/data_source/online_data_source/user_info/impl/user_info_online_datasource_impl.dart'
    as _i260;
import '../src/data/repository_impl/auth/auth_repository_impl.dart' as _i946;
import '../src/data/repository_impl/career/career_repository_impl.dart'
    as _i726;
import '../src/data/repository_impl/home/home_repository_impl.dart' as _i210;
import '../src/data/repository_impl/profile/user_info_repository_impl.dart'
    as _i488;
import '../src/data/repository_impl/user_info/user_info_repository_impl.dart'
    as _i300;
import '../src/domain/repositories/contract/auth_repository.dart' as _i367;
import '../src/domain/repositories/contract/career_repository.dart' as _i645;
import '../src/domain/repositories/contract/home_repository.dart' as _i363;
import '../src/domain/repositories/contract/profile_repository.dart' as _i552;
import '../src/domain/repositories/contract/user_info_repository.dart' as _i175;
import '../src/domain/usecases/additional_info/additional_info_usecase.dart'
    as _i563;
import '../src/domain/usecases/auth/auth_use_case.dart' as _i692;
import '../src/domain/usecases/career/career_usecase.dart' as _i720;
import '../src/domain/usecases/Certification/certification_usecase.dart'
    as _i665;
import '../src/domain/usecases/EducationProjectUsecase/educationProject_usecase.dart'
    as _i428;
import '../src/domain/usecases/home/home_usecase.dart' as _i991;
import '../src/domain/usecases/profile/profile_usecase.dart' as _i501;
import '../src/domain/usecases/Project/project_usecase.dart' as _i859;
import '../src/domain/usecases/user_info/user_info_usecase.dart' as _i748;
import '../src/presentation/mangers/auth/login/login_viewmodel.dart' as _i312;
import '../src/presentation/mangers/auth/register/register_viewmodel.dart'
    as _i599;
import '../src/presentation/mangers/career/career_viewmodel.dart' as _i510;
import '../src/presentation/mangers/career/cv_cubit.dart' as _i218;
import '../src/presentation/mangers/home/home_viewmodel.dart' as _i190;
import '../src/presentation/mangers/home/jobs/jobs_viewmodel.dart' as _i132;
import '../src/presentation/mangers/job_detail/job_detail_cubit.dart' as _i982;
import '../src/presentation/mangers/localization/localization_viewmodel.dart'
    as _i841;
import '../src/presentation/mangers/onboarding/onboarding_viewmodel.dart'
    as _i359;
import '../src/presentation/mangers/profile/personal_profile_viewmodel.dart'
    as _i1046;
import '../src/presentation/mangers/saved_jobs/saved_jobs_cubit.dart' as _i740;
import '../src/presentation/mangers/section/section_Screen_viewmodel.dart'
    as _i794;
import '../src/presentation/mangers/user_info/additional_info/additional_info_viewmodel.dart'
    as _i374;
import '../src/presentation/mangers/user_info/Certification/certification_viewmodel.dart'
    as _i744;
import '../src/presentation/mangers/user_info/education/education_viewmodel.dart'
    as _i228;
import '../src/presentation/mangers/user_info/Language/language_viewmodel.dart'
    as _i208;
import '../src/presentation/mangers/user_info/profile/profile_viewmodel.dart'
    as _i4;
import '../src/presentation/mangers/user_info/Project/Project_Viewmodel.dart'
    as _i213;
import '../src/presentation/mangers/user_info/skill_gathering/skill_gathering_viewmodel.dart'
    as _i639;
import '../src/presentation/mangers/user_info/work_experience/work_experience_viewmodel.dart'
    as _i277;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPrefModule = _$SharedPrefModule();
    final registerModule = _$RegisterModule();
    final firebaseModule = _$FirebaseModule();
    final dioProvider = _$DioProvider();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i428.EducationProjectUsecase>(
        () => _i428.EducationProjectUsecase());
    gh.factory<_i841.LocalizationViewmodel>(
        () => _i841.LocalizationViewmodel());
    gh.factory<_i359.OnboardingViewmodel>(() => _i359.OnboardingViewmodel());
    gh.factory<_i794.SectionScreenViewmodel>(
        () => _i794.SectionScreenViewmodel());
    gh.lazySingleton<_i885.DioClient>(() => registerModule.dioClient);
    gh.lazySingleton<_i974.FirebaseFirestore>(
        () => firebaseModule.firebaseFirestore);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => sharedPrefModule.secureStorage);
    gh.lazySingleton<_i361.Dio>(() => dioProvider.dioProvider());
    gh.lazySingleton<_i528.PrettyDioLogger>(() => dioProvider.providePretty());
    gh.lazySingleton<_i13.AppInterceptors>(() => _i13.AppInterceptors());
    gh.factory<_i990.AuthOfflineDataSource>(
        () => _i718.authOfflineDatasourceImpl());
    gh.singleton<_i687.ApiServices>(() => _i687.ApiServices(gh<_i361.Dio>()));
    gh.factory<_i658.CareerOnlineDatasource>(
        () => _i656.CareerOnlineDatasourceImpl(gh<_i687.ApiServices>()));
    gh.factory<_i635.FirestoreService>(
        () => _i635.FirestoreService(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i263.ProfileOnlineDataSource>(
        () => _i636.ProfileOnlineDatasourceImpl(gh<_i687.ApiServices>()));
    gh.factory<_i468.UserInfoOnlineDataSource>(
        () => _i260.UserInfoOnlineDatasourceImpl(gh<_i687.ApiServices>()));
    gh.factory<_i144.AuthOnlineDatasource>(
        () => _i116.AuthOnlineDataSourceImpl(gh<_i687.ApiServices>()));
    gh.factory<_i747.UserInfoOnlineDataSource>(
        () => _i699.UserInfoOnlineDatasourceImpl(gh<_i687.ApiServices>()));
    gh.factory<_i367.AuthRepository>(() => _i946.AuthRepositoryImpl(
          gh<_i144.AuthOnlineDatasource>(),
          gh<_i990.AuthOfflineDataSource>(),
        ));
    gh.factory<_i645.CareerRepository>(
        () => _i726.CareerRepositoryImpl(gh<_i658.CareerOnlineDatasource>()));
    gh.factory<_i175.UserInfoRepository>(() => _i300.UserInfoRepositoryImpl(
          gh<_i468.UserInfoOnlineDataSource>(),
          gh<_i990.AuthOfflineDataSource>(),
        ));
    gh.factory<_i552.ProfileRepository>(
        () => _i488.ProfileRepositoryImpl(gh<_i263.ProfileOnlineDataSource>()));
    gh.factory<_i177.HomeOnlineDatasource>(() => _i36.HomeOnlineDatasourceImpl(
          gh<_i687.ApiServices>(),
          gh<_i635.FirestoreService>(),
        ));
    gh.factory<_i692.AuthUseCase>(
        () => _i692.AuthUseCase(gh<_i367.AuthRepository>()));
    gh.factory<_i563.AdditionalInfoUsecase>(
        () => _i563.AdditionalInfoUsecase(gh<_i175.UserInfoRepository>()));
    gh.factory<_i665.CertificationUsecase>(
        () => _i665.CertificationUsecase(gh<_i175.UserInfoRepository>()));
    gh.factory<_i859.ProjectUsecase>(
        () => _i859.ProjectUsecase(gh<_i175.UserInfoRepository>()));
    gh.factory<_i748.UserInfoUsecase>(
        () => _i748.UserInfoUsecase(gh<_i175.UserInfoRepository>()));
    gh.factory<_i4.ProfileViewmodel>(
        () => _i4.ProfileViewmodel(gh<_i748.UserInfoUsecase>()));
    gh.factory<_i277.WorkExperienceViewModel>(
        () => _i277.WorkExperienceViewModel(gh<_i748.UserInfoUsecase>()));
    gh.factory<_i312.LoginViewModel>(
        () => _i312.LoginViewModel(gh<_i692.AuthUseCase>()));
    gh.factory<_i720.CareerUsecase>(
        () => _i720.CareerUsecase(gh<_i645.CareerRepository>()));
    gh.factory<_i599.RegisterViewModel>(
        () => _i599.RegisterViewModel(gh<_i692.AuthUseCase>()));
    gh.factory<_i744.CertificationViewmodel>(
        () => _i744.CertificationViewmodel(gh<_i665.CertificationUsecase>()));
    gh.factory<_i510.CareerViewmodel>(
        () => _i510.CareerViewmodel(gh<_i720.CareerUsecase>()));
    gh.factory<_i218.CvCubit>(() => _i218.CvCubit(gh<_i720.CareerUsecase>()));
    gh.factory<_i982.JobDetailCubit>(
        () => _i982.JobDetailCubit(gh<_i720.CareerUsecase>()));
    gh.factory<_i363.HomeRepository>(() => _i210.HomeRepositoryImpl(
          gh<_i177.HomeOnlineDatasource>(),
          gh<_i990.AuthOfflineDataSource>(),
        ));
    gh.factory<_i374.AdditionalInfoViewmodel>(
        () => _i374.AdditionalInfoViewmodel(gh<_i563.AdditionalInfoUsecase>()));
    gh.factory<_i501.ProfileUsecase>(() => _i501.ProfileUsecase(
          gh<_i552.ProfileRepository>(),
          gh<_i367.AuthRepository>(),
        ));
    gh.factory<_i213.ProjectViewmodel>(
        () => _i213.ProjectViewmodel(gh<_i859.ProjectUsecase>()));
    gh.factory<_i228.EducationViewmodelNew>(
        () => _i228.EducationViewmodelNew(gh<_i748.UserInfoUsecase>()));
    gh.factory<_i208.LanguageViewmodel>(
        () => _i208.LanguageViewmodel(gh<_i748.UserInfoUsecase>()));
    gh.factory<_i639.SkillGatheringViewmodel>(
        () => _i639.SkillGatheringViewmodel(gh<_i748.UserInfoUsecase>()));
    gh.factory<_i991.HomeUsecase>(() => _i991.HomeUsecase(
          gh<_i367.AuthRepository>(),
          gh<_i363.HomeRepository>(),
        ));
    gh.factory<_i1046.PersonalProfileCubit>(
        () => _i1046.PersonalProfileCubit(gh<_i501.ProfileUsecase>()));
    gh.factory<_i190.HomeViewmodel>(
        () => _i190.HomeViewmodel(gh<_i991.HomeUsecase>()));
    gh.factory<_i132.JobsViewmodel>(
        () => _i132.JobsViewmodel(gh<_i991.HomeUsecase>()));
    gh.factory<_i740.SavedJobsCubit>(
        () => _i740.SavedJobsCubit(gh<_i991.HomeUsecase>()));
    return this;
  }
}

class _$SharedPrefModule extends _i222.SharedPrefModule {}

class _$RegisterModule extends _i644.RegisterModule {}

class _$FirebaseModule extends _i240.FirebaseModule {}

class _$DioProvider extends _i13.DioProvider {}

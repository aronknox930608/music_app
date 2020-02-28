import 'package:flutter/material.dart';
import 'package:flutter_music_app/models/data_model.dart';
import 'package:flutter_music_app/provider/view_state_model.dart';

/// 我的收藏列表
// class FavouriteListModel extends ViewStateRefreshListModel<Data> {
//   //LoginModel loginModel;

//   //FavouriteListModel({this.loginModel});


//   @override
//   void onUnAuthorizedException() {
//     super.onUnAuthorizedException();
//     //loginModel.logout();
//   }

//   @override
//   Future<List<Data>> loadData({int pageNum}) async {
//     return await WanAndroidRepository.fetchCollectList(pageNum);
//   }
// }

/// 收藏/取消收藏
class FavouriteModel extends ViewStateModel {
  GlobalFavouriteStateModel globalFavouriteModel;

  FavouriteModel({@required this.globalFavouriteModel});

  // collect(Data article) async {
  //   setBusy();
  //   try {
  //     // article.collect 字段为null,代表是从我的收藏页面进入的 需要调用特殊的取消接口
  //     if (article.collect == null) {
  //       await WanAndroidRepository.unMyCollect(
  //           id: article.id, originId: article.originId);
  //       globalFavouriteModel.removeFavourite(article.originId);
  //     } else {
  //       if (article.collect) {
  //         await WanAndroidRepository.unCollect(article.id);
  //         globalFavouriteModel.removeFavourite(article.id);
  //       } else {
  //         await WanAndroidRepository.collect(article.id);
  //         globalFavouriteModel.addFavourite(article.id);
  //       }
  //     }
  //     article.collect = !(article.collect ?? true);
  //     setIdle();
  //   } catch (e, s) {
  //     setError(e,s);
  //   }
  // }
}

/// 全局维护状态是否收藏
///
class GlobalFavouriteStateModel extends ChangeNotifier {
  /// 将页面列表项中所有的收藏状态操作结果存储到集合中.
  ///
  /// [key]为articleId,[value]为bool类型,代表是否收藏
  ///
  /// 设置static的目的是,列表更新时,刷新该map中的值
  static final Map<int, bool> _map = Map();

  /// 列表数据刷新后,同步刷新该map数据
  ///
  /// 在其他终端(如PC端)收藏/取消收藏后,会导致两边状态不一致.
  /// 列表页面刷新后,应该将新的收藏状态同步更新到map
  static refresh(List<Data> list) {
    list.forEach((data) {
      if (_map.containsKey(data.songid)) {
        _map[data.songid] = true;
      }
    });
  }

  addFavourite(int id) {
    _map[id] = true;
    notifyListeners();
  }

  removeFavourite(int id) {
    _map[id] = false;
    notifyListeners();
  }

  /// 用于切换用户后,将该用户所有收藏的文章,对应的状态置为true
  replaceAll(List ids) {
    _map.clear();
    ids.forEach((id) => _map[id] = true);
    notifyListeners();
  }

  contains(id){
    return _map.containsKey(id);
  }

  operator [](int id) {
    return _map[id];
  }
}

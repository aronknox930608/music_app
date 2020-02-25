import 'package:flutter_music_app/models/data_model.dart';
import 'package:flutter_music_app/provider/view_state_refresh_list_model.dart';
import 'package:flutter_music_app/service/base_repository.dart';

class ForYouModel extends ViewStateRefreshListModel {
  final String input;

  ForYouModel({this.input});

  @override
  Future<List<Data>> loadData({int pageNum}) async {
    return await BaseRepository.fetchSongList(input, pageNum);
  }
}

class DataHelper {
  static String setWriters(List data) {
    var modifiedData =
        data.where((element) => element.department == 'Writing').toList();
    var listStrings = [];
    for (var i = 0; i < modifiedData.length; i++) {
      listStrings.add(modifiedData[i].name);
    }
    return listStrings.join(", ");
  }

  static String setDirector(List data) {
    var modifiedData = data.firstWhere((element) => element.job == 'Director');
    return modifiedData.name;
  }
}

class DataHelper {
  static String setWriters(List data) {
    try {
      var modifiedData =
          data.where((element) => element.department == 'Writing').toList();
      var listStrings = [];
      for (var i = 0; i < modifiedData.length; i++) {
        listStrings.add(modifiedData[i].name);
      }
      return listStrings.join(", ");
    } catch (e) {
      return 'No Data Available';
    }
  }

  static String setDirector(List data) {
    try {
      var modifiedData =
          data.firstWhere((element) => element.job == 'Director');
      return modifiedData.name;
    } catch (e) {
      return 'No Data Available';
    }
  }
}

class LocalValues{
  Map<String, double> activityStatus = {
    "Sedentary":1.25,
    "Lightly activity":1.45,
    "Moderate activity":1.65,
    "Very activity":1.9
  };

  double getActivityStatus(String key) {
    return activityStatus[key] ?? 1.0; // Return 1.0 if key doesn't exist
  }

}
A repository with examples for Medium article series

Part 1: https://medium.com/@pomis172/making-flutter-apps-look-more-native-part-1-tap-effects-48a59cb158bf  
Part 2: https://medium.com/@pomis172/making-flutter-apps-look-more-native-part-2-refresh-indicators-a747cefc496b?postPublishedType=initial


```
./calculate.sh average_frame_build_time_millis worst_frame_build_time_millis 
```

```
flutter drive \
  --driver=test_driver/perf_driver.dart \
  --target=integration_test/prototyped_list_view_scrolling_test.dart \ 
  --profile \
  --no-dds
```

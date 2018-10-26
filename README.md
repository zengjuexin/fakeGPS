# fakeGPS
修改苹果手机定位，运行后能试手机上所有的软件都显示你设置的位置。

新建一个.gpx文件

然后"command+shift+,  "，在default Location中选择你刚才创建的.gpx文件，如下图
![Image](/souce/1.png)

修改.gpx文件中的经纬度坐标，这个坐标采用的是WGS-84，高德地图用的是GCJ-02是火星坐标，需要转成WGS-84才能使用。
[高德坐标查询](https://lbs.amap.com/console/show/picker)

最后选择设备运行，你就能坐在家里环游世界了。

问题来了，当拔掉手机后，定位又恢复成正常。
改用无线调试运行，不要停止运行，不要关掉Xcode，不管走哪里，定位都不会变。







# 交叉编译 ARM 平台的 OpenSSH

[![Build Status](https://travis-ci.com/zhijl/openssh-arm.svg?branch=master)](https://travis-ci.com/zhijl/openssh-arm)

该项目目前用的是 `arm-hisiv500-linux` 交叉编译 OpenSSH 和 rz/sz 串口传输工具

其他的编译器也可以集成进来，等有时间再测试下其他编译器

## 配置交叉编译器

- 将 `arm-hisiv500-linux` 的 `bin` 目录配置在 `PATH`中

(其他编译器也可以用，需要修改 build_hisiv500.sh 脚本中的 `CC`、`CXX` 和 `AR`)

## 编译方法

`arm-hisiv500-linux`：

``` sh
./fetch.sh             # 获取 OpenSSH 及其依赖源码
./build_hisiv500.sh    # 使用交叉编译器进行编译
```

`Linux host x86_64`：

``` sh
./fetch.sh
./build_x86_64.sh      # 使用 GNU GCC 编译器进行编译
```

编译好的文件将存放在 `install-*` 目录下

### 参考

https://github.com/Tencent/ncnn/blob/master/toolchains/hisiv500.toolchain.cmake

软件移植 - OpenSSH移植  https://segmentfault.com/a/1190000019829361

ARM移植rz和sz命令  https://blog.csdn.net/zhengqijun_/article/details/72231524

rzsz源码  https://github.com/coderfordev/rzsz

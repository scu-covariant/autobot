# autobot
机器人以插件的形式提供扩展功能， 基于lua-mirai的二次封装机器人框架

## 框架简介
    目录结构及对应功能
        |-data      作为数据库，每个文件作为一页(page)
            |- ring     权限分级及权限列表(尚不完善)
            |- ...      其他具体功能
        |-funs
            |- ...      其他具体功能
        |-manage
            |- ...      其他具体功能
        |-auto.lua      暂无意义
        |-init.lua      初始化Database, Funcs, Ctrl, Ring 四个全局变量
        |-mod.lua       功能模块列表, 处于其中的模块将被加载生效
        |-setting       尚不完善
        |-utility       负责功能加载，序列化table等工具
当需要新增加功能时， 只需要在 data / funs / manage 三个目录下各新增功能名文件，要求三处文件名相同， 实现各自要求的接口后， 在mod中按顺序添加文件名即可

## 快速上手
+ 确定自己的模块名 ModName ， 作为文件名，
+ 在 data 中新建 ModName.lua 文件， 设置自己所需的变量及数据项
+ 在 funs 中新建 ModName.lua 文件， 实现 funs/interface 中要求的接口 info, errnum, filiter, check, action, after, log, 返回值自动注册函数
+ 在 manage 中新建 ModName.lua 文件， 实现 manage /interface.lua 中要求的接口
+ 联系我(你懂的) 测试并上线

### 其他注意事项
+ 目前稳定使用的功能包括 repeat 自动复读 baidu 百度搜索， 建议作为样板参考使用
+ 由于lua中的表本身可作为关系型数据库使用， 因此复杂数据建议使用 uid (即qq号)作为主键， foreign key 外键作为主键所对应 table 的主键， 来达到 db.Data\[uid\].ForeignKey 即可访问数据的效果
+ 问我

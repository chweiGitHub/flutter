 

### 基于MVP模式下的flutter数据、view、逻辑（P）的抽取封装。
    1. 在 pubspec.yaml 中引用： 
        ```
        dependencies:  
          mvp_module:
            path: ./mvp_module
        ```
    2. 继承BaseModel
        (1) 重写dealResult 方法，补充完满足自己需要的接口统一解析逻辑（a. 统一的网络state处理； b. 统一的业务state处理，如token过期等； c. 统一的数据转换。）。
        (2) getBaseSignParams，统一的签名参数 （a. token/userId/deviceId/platform等； b. 参数的加密、签名、压缩等）
        (3) getBaseParams,统一的非签名参数 (a. deviceId/platform等； b. 参数的加密、签名、压缩等)
        
    3. 有自己需要统计处理的view层逻辑请继承BaseState 重写（增加）相关方法统一处理。  
    4. 书写自己的presenter，使用。
    5. 参考example, example可直接运行。 
    
### 后续计划： 
    1. 增加Future模式
    2. 进一步提取网络层
    3. 强化model
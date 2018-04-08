# Helpe 数据接口API

##服务器接口概览##
1. 商铺列表 此版本不支持
2. 商品类型
3. 认证
	* 登录
   * 注册
   * 修改密码
   * 忘记密码
   * 登出
4. 用户
   * 用户信息
   * 修改
   * 更新用户头像
5. 订单
    * 订单详情
    * 我的订单
    * 下单
    * 我的出售订单
    * 订单状态更新() 
6. 举报
    * 添加举报
7. 收藏
    * 收藏动作
    * 删除收藏
    * 收藏列表
8. 评价
    * 评价添加
    * 评价修改
    * 评价列表
    * 我的评价
    * 关于我的评价
9. 商品
    * 发布
    * 上架
    * 下架
    * 设置默认图片
    * 自定义属性 此版本不支持
    * 商品列表
    * 商品详情  
    * 我商品列表  
10. 地址    
    * 增加用户地址
    * 用户地址列表
    * 用户地址修改
    * 用户地址删除
11. 服务器
    * 服务器信息
    * 聊天im认证接口
12. 交易记录
    * 交易记录列表
13. 关注
    * 我的关注列表
    * 关注我的列表
    * 添加关注
    * 删除关注
    

##环境域名##
1. 开发环境
开发测试 可以随便指定
2. 测试环境
https://testapi.helpe.online/
3. 正式环境
https://api.helpe.online/

##数据格式##
###数据更新类接口
* 请求
默认数据使用POST方式发送
* 返回

```
{
    "status": 0,
    "data": [],
    "err": ""
}
```

###单个数据读取接口
* 请求
默认数据使用GET方式发送
* 返回

```
{
    "status": "0",
    "err": "success",
    "data": {
        "id": 290,
        ...
        "pet": 0,
        "itemdetail": {
            "itemid": 290,
            "mark": "0",
            "ct": 1521214999,
            "mt": 1521214999
        },
        "itemimg": []
    }
}
```

###列表数据读取接口
* 请求
默认数据使用GET方式发送
* 返回

```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 1,
                ...                
                "pet": 1520696319,
                "itemdetail": {
                    "itemid": 1,
                    "mark": "得到的，个，个，个，个，",
                    "ct": 1520696319,
                    "mt": 0
                },
                "itemimg": [
                    {
                        "id": 1,
                        "itemid": 1,
                        "url": "/itemimg1",
                        "uid": 1,
                        "ct": 1520696319
                    },
                    {
                        "id": 2,
                        "itemid": 1,
                        "url": "/itemimg2",
                        "uid": 1,
                        "ct": 1520696319
                    }
                ]
            },
            {
                "id": 2,
                ...
                "itemimg": []
            }
        ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/item?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=1&per-page=2"
            },
            "next": {
                "href": "http://devapi.helpe.online/v1/item?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=2&per-page=2"
            },
            "last": {
                "href": "http://devapi.helpe.online/v1/item?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=15&per-page=2"
            }
        },
        "_meta": {
            "totalCount": 29,
            "pageCount": 15,
            "currentPage": 1,
            "perPage": 2
        }
    }
}
```

##2.商品（服务，求助）分类模块##
###2.1列表接口
/v1/category[/index]

根据请求条件返回已经发布的分类列表

### 请求参数 ###
URL /v1/category?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5
GET 请求 

- pid 父分类id
- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###
```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 1,
                "jp_name": "古本",
                "cn_name": "",
                "pid": 0,
                "sort": 1,
                "flag": 1,
                "ct": 0,
                "mt": null
            },
            ......
                   ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/category/index?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&pid=0&page=1"
            }
        },
        "_meta": {
            "totalCount": 8,
            "pageCount": 1,
            "currentPage": 1,
            "perPage": 20
        }
    }
}

```



##3. 认证模块 ##
### 3.1 登录接口
#### 标准登录 (自有账号体系)

GET 请求
/v1/passport/login
根据返回 status 的状态判断,0是正常, 非0是异常, data中包含用户信息

### 请求参数 ###
- email 	客户端检查电子邮件准确性, 如果准确,往服务端检查校验
- password  密码
- type = 1

### 返回状态 ###
- 0												  // 成功
- 10008 => 'LOGIN_IN_TYPE_ERROR',                 // 登录类型错误, 在不接受的范围内
- 10009 => 'USER_IS_NOT_EXISTS',                  // 用户不存在 默认登录的电子邮件
- 10010 => 'USER_PASSWORD_ERROR',                 // 用户名密码错误
- 10011 => 'USER_INFO_GET_ERROR',                 // 常规登录用户信息获取错误
- 10012 => 'USER_INFO_SAVE_ERROR',                // 常规登录用户信息获取错误

### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : {
		"id": 1,																// 用户ID
        "type": 1,																// 用户类型
        "email": "ft20082@qq.com",												// 用户账号
        "username": "ft20082",													// 昵称
        "access_token": "KVvaPT5cSRErU2hIxEM8c2AERCxF2Vu5dYQ2JF4R",				// access token
        "password_reset_token": null,											// 重置密码的token 可忽略
        "face": null,															// 头像, 应该是一个图片
        "gender": null,															// 性别
        "birthday": null,														// 生日  (yyyy-mm-dd)
        "career": null,															// 职业
        "city": null,															// 城市
        "tel": null,															// 电话
        "ip": null,																// 最后登录IP
        "info": null,															// 说明
        "status": 1,															// 用户状态
        "created_at": 1521041986,												// 创建时间
        "updated_at": 1521207945												// 最后更新时间
	},
}
```

#### facebook登录 (第三方登录)
GET 请求
/v1/passport/login
根据返回 status 的状态判断,0是正常, 非0是异常, data中包含用户信息

### 请求参数 ###
- fb_access_token 		// facebook用户的access_token
- type = 2				// 类型为2, 是第三方facebook 登录

### 返回状态 ###
- 0												  // 成功
- 10007 => 'SAVE_TO_DATABASE_ERROR',              // 保存到数据库错误
- 10008 => 'LOGIN_IN_TYPE_ERROR',                 // 登录类型错误, 在不接受的范围内
- 10013 => 'THIRD_PARTY_GET_USER_INFO_ERROR',     // 第三方token 获取用户信息错误
- 10017 => 'ALIYUN_OSS_OPERATE_ERROR',            // 阿里云OSS操作错误

### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : {
		"id": 1,																// 用户ID
        "type": 1,																// 用户类型
        "email": "ft20082@qq.com",												// 用户账号
        "username": "ft20082",													// 昵称
        "access_token": "KVvaPT5cSRErU2hIxEM8c2AERCxF2Vu5dYQ2JF4R",				// access token
        "password_reset_token": null,											// 重置密码的token 可忽略
        "face": null,															// 头像, 应该是一个图片
        "gender": null,															// 性别
        "birthday": null,														// 生日  (yyyy-mm-dd)
        "career": null,															// 职业
        "city": null,															// 城市
        "tel": null,															// 电话
        "ip": null,																// 最后登录IP
        "info": null,															// 说明
        "status": 1,															// 用户状态
        "created_at": 1521041986,												// 创建时间
        "updated_at": 1521207945												// 最后更新时间
	},
}
```

### 3.2 注册接口

#### 注册步骤1 (验证邮件地址)
GET 请求
/v1/passport/checkEmail
根据返回 status 的状态判断,0是正常, 非0是异常

### 请求参数 ###
- email 	客户端检查电子邮件准确性, 如果准确,往服务端检查校验

### 返回状态 ###
- 0												  // 成功
- 10001 => 'EMAIL_ADDRESS_CHECK_ERROR',           // 邮件地址检查错误
- 10002 => 'SEND_EMAIL_CHECK_FREQUENTLY',         // 邮件发送太频繁, 要隔一定时间,默认是1分钟
- 10003 => 'PASSPORT_EMAIL_EXISTS',               // 通行证表邮件已存在
- 10004 => 'SEND_EMAIL_CHECK_FAILURE',            // 电子邮件发送失败

### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : [],
}
```

#### 注册步骤2 (提交注册信息)
GET 请求
/v1/passport/register
说明: 请求内容必须包含电子邮件的校验key

### 请求参数 ###
- username		用户名<昵称>
- password		密码
- email			电子邮件
- auth_token 	电子邮件校验key

### 返回状态 ###
- 0 											  // 成功
- 10003 => 'PASSPORT_EMAIL_EXISTS',               // 通行证表邮件已存在
- 10005 => 'REGISTER_TOKEN_CHECK_ERROR',          // 注册的校验token检查错误
- 10006 => 'REGISTER_EMAIL_CHECK_ERROR',          // 注册邮件检查错误
- 10007 => 'SAVE_TO_DATABASE_ERROR',              // 保存到数据库错误

### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : [],
}
```

### 3.3 修改密码
GET 请求
/v1/user/reset-password

### 请求参数 ###
- t 							// access_token是服务端给客户端的校验key
- old_password					// 老的密码
- new_password					// 新的密码

### 返回状态 ###
- 0												  // 成功
- 10000 => 'ACCESS_TOKEN_CHECK_ERROR',            // ACCESS TOKEN 检查错误
- 9995 => 'PASSWORD_CHECK_ERROR',                 // 密码检查错误
- 9998 => 'REQUEST_PARAM_ERROR',                  // 请求参数错误
- 10015 => 'THIRD_PARTY_NOT_SUPPORT',             // 第三方登录不支持, 比如重置密码


### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : [],
}
```

### 3.4 忘记密码

#### 忘记密码步骤1 (发送验证邮件)
GET 请求
/v1/user/forget-password
服务端不需要校验

### 请求参数 ###
- email											  // 电子邮件地址 

### 返回状态 ###
- 0												  // 成功
- 10001 => 'EMAIL_ADDRESS_CHECK_ERROR',           // 邮件地址检查错误
- 10009 => 'USER_IS_NOT_EXISTS',                  // 用户不存在 默认登录的电子邮件
- 10004 => 'SEND_EMAIL_CHECK_FAILURE',            // 电子邮件发送失败

### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : [],
}
```

#### 忘记密码步骤2 (更新密码)
GET 请求
/v1/user/forget-password-reset
说明: 请求内容必须包含电子邮件的校验key

### 请求参数 ###
- email			电子邮件
- auth_token 	电子邮件校验key
- password      密码

### 返回状态 ###
- 0 											  // 成功
- 10001 => 'EMAIL_ADDRESS_CHECK_ERROR',           // 邮件地址检查错误
- 10007 => 'SAVE_TO_DATABASE_ERROR',              // 保存到数据库错误
- 10009 => 'USER_IS_NOT_EXISTS',                  // 用户不存在 默认登录的电子邮件
- 10016 => 'AUTH_TOKEN_CHECK_ERROR',              // 校验码检查错误

### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : [],
}
```

### 3.5 登出

GET 请求
/v1/passport/logout
根据返回 status 的状态判断,0是正常, 非0是异常

常规登录

### 请求参数 ###
- t 	access_token是服务端给客户端的校验key

### 返回状态 ###
- 0												  // 成功
- 10000 => 'ACCESS_TOKEN_CHECK_ERROR',            // ACCESS TOKEN 检查错误


### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : [],
}
```

## 4. 用户信息模块 ##
###4.1 获取用户信息
GET 请求
/v1/user/info
### 请求参数 ###
- t 	access_token是服务端给客户端的校验key

### 返回状态 ###
- 0												  // 成功
- 10000 => 'ACCESS_TOKEN_CHECK_ERROR',            // ACCESS TOKEN 检查错误


### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : {
		"id": 1,																// 用户ID
        "type": 1,																// 用户类型
        "email": "ft20082@qq.com",												// 用户账号
        "username": "ft20082",													// 昵称
        "face": null,															// 头像, 应该是一个图片
        "gender": null,															// 性别
        "birthday": null,														// 生日 (yyyy-mm-dd)
        "career": null,															// 职业
        "city": null,															// 城市
        "tel": null,															// 电话
        "ip": null,																// 最后登录IP
        "info": null,															// 说明
        "status": 1,															// 用户状态
        "created_at": 1521041986,												// 创建时间
        "updated_at": 1521207945												// 最后更新时间
	},
}
```

###4.2 更新用户信息
POST 请求
/v1/user/update
### 请求参数 ###
- t 					// access_token是服务端给客户端的校验key
- username				// 用户昵称
- gender				// 性别
- birthday				// 生日 (yyyy-mm-dd)
- career				// 职业
- city					// 城市
- tel 					// 电话
- info 					// 个人简介

### 返回状态 ###
- 0												  // 成功
- 10000 => 'ACCESS_TOKEN_CHECK_ERROR',            // ACCESS TOKEN 检查错误
- 9998 => 'REQUEST_PARAM_ERROR',                  // 请求参数错误
- 10007 => 'SAVE_TO_DATABASE_ERROR',              // 保存到数据库错误

### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : [],
}
```

###4.3 更新用户头像
POST 请求
/v1/user/avatar
### 请求参数 ###
- t 							// access_token是服务端给客户端的校验key
- face  						// 用户头像 file 类型 

### 返回状态 ###
- 0												  // 成功
- 10000 => 'ACCESS_TOKEN_CHECK_ERROR',            // ACCESS TOKEN 检查错误
- 10017 => 'ALIYUN_OSS_OPERATE_ERROR',            // 阿里云OSS操作错误
- 10018 => 'USER_IMG_UPLOAD_ERROR',               // 用户图片上传错误


### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : [],
}
```

##5.订单模块##
###5.1列表接口
/v1/order[/index]

根据请求条件返回我的订单列表

### 请求参数 ###
GET 请求

- et st  开始创建时间 结束创建时间 成对否则忽略
- status 一个或者多个状态，多个状态使用10,20,40
- type 0 服务 1 求助 -1 全部 
- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###

```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 80,
                "no": 0,
                "uid": 1,
                "status": 0,
                "ordertp": 0,
                "cash": "1000.00",
                "ct": 1522077081,
                "pt": 1520696319,
                "mt": 1522077081,
                "itemid": 5,
                "num": 1,
                "type": 1,
                "owner": 2,
                "changeprice": "0.00",
                "remark": "dddddd",
                "paytp": 1,
                "fd": 0,
                "iteminfo": {
                    "id": 5,
                    "name": "name555",
                    "appid": 2,
                    "price": "1000.00",
                    "img": "/img",
                    "flag": 0,
                    "ct": 1520696319,
                    "mt": 1520696319,
                    "uid": 2,
                    "cid": 1,
                    "tag": 0,
                    "type": 1,
                    "aid": 1,
                    "aaid": 1,
                    "lat": 1,
                    "lng": 1,
                    "pt": 1520696319,
                    "paytp": 0,
                    "contact": "contact",
                    "salenum": 0,
                    "deadline": "2018-05",
                    "unit": "ci",
                    "pet": 1520696319
                },
                "userinfo": {
                    "id": 1,
                    "type": 1,
                    "email": "ft20082@qq.com",
                    "username": null,
                    "face": null,
                    "gender": null,
                    "birthday": null,
                    "career": null,
                    "city": null,
                    "tel": null,
                    "ip": "127.0.0.1",
                    "info": null,
                    "status": 1,
                    "created_at": 1521041986,
                    "updated_at": 1521213114
                }
            },
            ......
                    ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/order/index?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=1"
            }
        },
        "_meta": {
            "totalCount": 2,
            "pageCount": 1,
            "currentPage": 1,
            "perPage": 20
        }
    }
}
```

###5.2列表接口
/v1/order/sale

根据请求条件返回我的出售订单列表

### 请求参数 ###
GET 请求

- et st  开始创建时间 结束创建时间 成对否则忽略
- status 一个或者多个状态，多个状态使用10,20,40
- type 0 服务 1 求助 -1 全部 
- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###

```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 80,
                "no": 0,
                "uid": 1,
                "status": 0,
                "ordertp": 0,
                "cash": "1000.00",
                "ct": 1522077081,
                "pt": 1520696319,
                "mt": 1522077081,
                "itemid": 5,
                "num": 1,
                "type": 1,
                "owner": 2,
                "changeprice": "0.00",
                "remark": "dddddd",
                "paytp": 1,
                "fd": 0,
                "iteminfo": {
                    "id": 5,
                    "name": "name555",
                    "appid": 2,
                    "price": "1000.00",
                    "img": "/img",
                    "flag": 0,
                    "ct": 1520696319,
                    "mt": 1520696319,
                    "uid": 2,
                    "cid": 1,
                    "tag": 0,
                    "type": 1,
                    "aid": 1,
                    "aaid": 1,
                    "lat": 1,
                    "lng": 1,
                    "pt": 1520696319,
                    "paytp": 0,
                    "contact": "contact",
                    "salenum": 0,
                    "deadline": "2018-05",
                    "unit": "ci",
                    "pet": 1520696319
                },
                "userinfo": {
                    "id": 1,
                    "type": 1,
                    "email": "ft20082@qq.com",
                    "username": null,
                    "face": null,
                    "gender": null,
                    "birthday": null,
                    "career": null,
                    "city": null,
                    "tel": null,
                    "ip": "127.0.0.1",
                    "info": null,
                    "status": 1,
                    "created_at": 1521041986,
                    "updated_at": 1521213114
                }
            },
            ......
                    ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/order/index?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=1"
            }
        },
        "_meta": {
            "totalCount": 2,
            "pageCount": 1,
            "currentPage": 1,
            "perPage": 20
        }
    }
}
```



###5.3订单信息接口
/v1/order/info

根据请求条件返回订单信息

### 请求参数 ###
GET 请求

- id 订单id

### 返回结果 ###

```
{
    "status": "0",
    "err": "success",
    "data": {
        "id": 80,
        "no": 0,
        "uid": 1,
        "status": 0,
        "ordertp": 0,
        "cash": "1000.00",
        "ct": 1522077081,
        "pt": 1520696319,
        "mt": 1522077081,
        "itemid": 5,
        "num": 1,
        "type": 1,
        "owner": 2,
        "changeprice": "0.00",
        "remark": "dddddd",
        "paytp": 1,
        "fd": 0,
        "iteminfo": {
            "id": 5,
            "name": "name555",
            "appid": 2,
            "price": "1000.00",
            "img": "/img",
            "flag": 0,
            "ct": 1520696319,
            "mt": 1520696319,
            "uid": 2,
            "cid": 1,
            "tag": 0,
            "type": 1,
            "aid": 1,
            "aaid": 1,
            "lat": 1,
            "lng": 1,
            "pt": 1520696319,
            "paytp": 0,
            "contact": "contact",
            "salenum": 0,
            "deadline": "2018-05",
            "unit": "ci",
            "pet": 1520696319
        },
        "userinfo": {
            "id": 1,
            "type": 1,
            "email": "ft20082@qq.com",
            "username": null,
            "face": null,
            "gender": null,
            "birthday": null,
            "career": null,
            "city": null,
            "tel": null,
            "ip": "127.0.0.1",
            "info": null,
            "status": 1,
            "created_at": 1521041986,
            "updated_at": 1521213114
        },
        "orderaddr": {
            "id": 203,
            "uid": 1,
            "aid": 1,
            "info": "测试地址",
            "ct": 1522077081,
            "lat": 1,
            "lng": 1,
            "orderid": 80
        },
        "ownerinfo": {
            "id": 2,
            "type": 1,
            "email": "824322790@qq.com",
            "username": null,
            "face": null,
            "gender": null,
            "birthday": null,
            "career": null,
            "city": null,
            "tel": null,
            "ip": null,
            "info": null,
            "status": 1,
            "created_at": 1521041986,
            "updated_at": 1521041986
        }
    }
}
```


###5.4 发布接口###

/v1/order/buy

下单购买商品或者提供求助内容

### 请求参数 ###
URL /v1/order/buy?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- token  登陆后服务器给的token
- aid  选择的地址名称
- num  数量
- id  商品id
- changeprice 折扣
- remark  描述
- paytp 支付类型 0 线上支付  1 线下支付 2  线上支付  线下支付


###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```

###5.5 接受订单接口###

/v1/order/accept

接受订单

### 请求参数 ###
URL /v1/order/accept?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- id  订单id

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```

###5.5 拒绝订单接口###

/v1/order/refuse

接受订单

### 请求参数 ###
URL /v1/order/refuse?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- id  订单id

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```

###5.6 结束订单接口###

/v1/order/finish

结束订单

### 请求参数 ###
URL /v1/order/finish?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- id  订单id

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```


##6. 举报模块##
###6.1添加举报
POST 请求
/v1/report/add
### 请求参数 ###
- t 							// access_token是服务端给客户端的校验key
- item_type  					// 举报的类型
- item_value                    // 举报类型的编号
- reason                        // 理由
- info                          // 理由详细, 暂时可以使用

### 返回状态 ###
- 0												  // 成功
- 9998 => 'REQUEST_PARAM_ERROR',                  // 请求参数错误
- 10000 => 'ACCESS_TOKEN_CHECK_ERROR',            // ACCESS TOKEN 检查错误


### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : [],
}
```

##7.收藏模块##
###7.1列表接口
/v1/fav[/index]

根据请求条件返回评论列表结果

### 请求参数 ###
GET 请求

- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###
```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 1,
                "uid": 1,
                "itemid": 1,
                "ct": 11111,
                "mt": 111111,
                "iteminfo": {
                    "id": 1,
                    "name": "1",
                    "appid": 1,
                    "price": "1000.00",
                    "img": "/img",
                    "flag": 0,
                    "ct": 1520696319,
                    "mt": 1521261910,
                    "uid": 1,
                    "cid": 1,
                    "tag": 0,
                    "type": 1,
                    "aid": 1,
                    "aaid": 1,
                    "lat": 1,
                    "lng": 1,
                    "pt": 1520696319,
                    "paytp": 0,
                    "contact": "contact",
                    "salenum": 0,
                    "deadline": "2018-05",
                    "unit": "ci",
                    "pet": 1520696319
                }
            },
           ......
                   ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/fav/index?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=1"
            }
        },
        "_meta": {
            "totalCount": 2,
            "pageCount": 1,
            "currentPage": 1,
            "perPage": 20
        }
    }
}
```

###7.2 保存接口###

/v1/fav/save

保存收藏接口

### 请求参数 ###
URL /v1/fav/save?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- id      itemid

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```

###7.3 删除接口###

/v1/fav/save

删除收藏接口

### 请求参数 ###
URL /v1/fav/save?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- id      favid

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```


##8.评价模块##
###8.1列表接口
/v1/feeback[/index]

根据请求条件返回评论列表结果

### 请求参数 ###
GET 请求

- orderid 订单id 如果使用了orderid则忽略itemid
- itemid 商品id 
- minscore maxscore 最小评分 最大评分 成对否则忽略
- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###
```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 23,
                "content": "henhao",
                "itemid": 5,
                "flag": 0,
                "score": 93,
                "orderid": 80,
                "uid": 2,
                "owner": 1,
                "ct": 1522143447,
                "mt": 1522143447,
                "orderinfo": {
                    "id": 80,
                    "no": 0,
                    "uid": 1,
                    "status": 10,
                    "ordertp": 0,
                    "cash": "1000.00",
                    "ct": 1522077081,
                    "pt": 1520696319,
                    "mt": 1522143447,
                    "itemid": 5,
                    "num": 1,
                    "type": 1,
                    "owner": 2,
                    "changeprice": "0.00",
                    "remark": "dddddd",
                    "paytp": 1,
                    "fd": 1,
                    "iteminfo": {
                        "id": 5,
                        "name": "name555",
                        "appid": 2,
                        "price": "1000.00",
                        "img": "/img",
                        "flag": 0,
                        "ct": 1520696319,
                        "mt": 1520696319,
                        "uid": 2,
                        "cid": 1,
                        "tag": 0,
                        "type": 1,
                        "aid": 1,
                        "aaid": 1,
                        "lat": 1,
                        "lng": 1,
                        "pt": 1520696319,
                        "paytp": 0,
                        "contact": "contact",
                        "salenum": 0,
                        "deadline": "2018-05",
                        "unit": "ci",
                        "pet": 1520696319
                    },
                    "userinfo": {
                        "id": 1,
                        "type": 1,
                        "email": "ft20082@qq.com",
                        "username": null,
                        "face": null,
                        "gender": null,
                        "birthday": null,
                        "career": null,
                        "city": null,
                        "tel": null,
                        "ip": "127.0.0.1",
                        "info": null,
                        "status": 1,
                        "created_at": 1521041986,
                        "updated_at": 1521213114
                    }
                }
            }
        ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/feedback/index?orderid=80&t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=1"
            }
        },
        "_meta": {
            "totalCount": 1,
            "pageCount": 1,
            "currentPage": 1,
            "perPage": 20
        }
    }
}
```

###8.2我的评论接口
/v1/feeback/my

返回我发布的评论列表结果

### 请求参数 ###
GET 请求

- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###
```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 23,
                "content": "henhao",
                "itemid": 5,
                "flag": 0,
                "score": 93,
                "orderid": 80,
                "uid": 2,
                "owner": 1,
                "ct": 1522143447,
                "mt": 1522143447,
                "orderinfo": {
                    "id": 80,
                    "no": 0,
                    "uid": 1,
                    "status": 10,
                    "ordertp": 0,
                    "cash": "1000.00",
                    "ct": 1522077081,
                    "pt": 1520696319,
                    "mt": 1522143447,
                    "itemid": 5,
                    "num": 1,
                    "type": 1,
                    "owner": 2,
                    "changeprice": "0.00",
                    "remark": "dddddd",
                    "paytp": 1,
                    "fd": 1
                }
            }
        ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/feedback/my?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=1"
            }
        },
        "_meta": {
            "totalCount": 1,
            "pageCount": 1,
            "currentPage": 1,
            "perPage": 20
        }
    }
}
```


###8.3关于我的评论接口
/v1/feeback/aboutme

返回我发布的评论列表结果

### 请求参数 ###
GET 请求

- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###
```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 23,
                "content": "henhao",
                "itemid": 5,
                "flag": 0,
                "score": 93,
                "orderid": 80,
                "uid": 2,
                "owner": 1,
                "ct": 1522143447,
                "mt": 1522143447,
                "orderinfo": {
                    "id": 80,
                    "no": 0,
                    "uid": 1,
                    "status": 10,
                    "ordertp": 0,
                    "cash": "1000.00",
                    "ct": 1522077081,
                    "pt": 1520696319,
                    "mt": 1522143447,
                    "itemid": 5,
                    "num": 1,
                    "type": 1,
                    "owner": 2,
                    "changeprice": "0.00",
                    "remark": "dddddd",
                    "paytp": 1,
                    "fd": 1
                }
            }
        ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/feedback/my?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=1"
            }
        },
        "_meta": {
            "totalCount": 1,
            "pageCount": 1,
            "currentPage": 1,
            "perPage": 20
        }
    }
}
```

###8.4 添加接口###

/v1/feedback/save

添加评论接口

### 请求参数 ###
URL /v1/feedback/save?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- orderid  订单id
- content  内容
- score    评分

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```

###8.5 修改接口###

/v1/feedback/update

修改评论接口

### 请求参数 ###
URL /v1/feedback/update?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- id      评论id
- content  内容
- score    评分

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```


##9.商品（服务，求助）模块##
###9.1列表接口
/v1/item[/list]

根据请求条件返回已经发布的列表结果

### 请求参数 ###
GET 请求
- lat 当前纬度
- lng 当前经度
- distance 距离，必须有当前经纬度
- et st  开始创建时间 结束创建时间 成对否则忽略
- minlat maxlat 最小纬度 最大纬度 成对否则忽略
- minlng maxlng 最小经度 最大经度 成对否则忽略
- cid 如果不传或者小于0则忽略
- owner 商品所属用户uid 有owner参数按照创建时间，销售量降序排序
- type 0 服务 1 求助 -1 全部 
- name 为空就忽略
- searchtp 排序类型 0 距离  1时间 2销量 默认为0
- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###
```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 1,
                "name": "1",
                "appid": 1,
                "price": "1000.00",
                "img": "/img",
                "flag": 0,
                "ct": 1520696319,
                "mt": 1521261910,
                "uid": 1,
                "cid": 1,
                "tag": 0,
                "type": 1,
                "aid": 1,
                "aaid": 1,
                "lat": 1,
                "lng": 1,
                "pt": 1520696319,
                "paytp": 0,
                "contact": "contact",
                "salenum": 0,
                "deadline": "2018-05",
                "unit": "ci",
                "pet": 1520696319,
                "itemdetail": {
                    "itemid": 1,
                    "mark": "得到的，个，个，个，个，",
                    "ct": 1520696319,
                    "mt": 0
                },
                "itemimg": [
                    {
                        "id": 1,
                        "itemid": 1,
                        "url": "/itemimg1",
                        "uid": 1,
                        "ct": 1520696319
                    },
                    {
                        "id": 2,
                        "itemid": 1,
                        "url": "/itemimg2",
                        "uid": 1,
                        "ct": 1520696319
                    }
                ]
            },
            {
				......                
            }
        ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/item?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=1&per-page=2"
            },
            "next": {
                "href": "http://devapi.helpe.online/v1/item?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=2&per-page=2"
            },
            "last": {
                "href": "http://devapi.helpe.online/v1/item?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=15&per-page=2"
            }
        },
        "_meta": {
            "totalCount": 29,
            "pageCount": 15,
            "currentPage": 1,
            "perPage": 2
        }
    }
}
```

###9.2我的商品(服务和求助)接口
/v1/item/myitem

根据请求条件返回已经发布的列表结果

### 请求参数 ###
GET 请求

- et st  开始创建时间 结束创建时间 成对否则忽略
- type 0 服务 1 求助 -1 全部 
- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###
```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 1,
                "name": "1",
                "appid": 1,
                "price": "1000.00",
                "img": "/img",
                "flag": 0,
                "ct": 1520696319,
                "mt": 1521261910,
                "uid": 1,
                "cid": 1,
                "tag": 0,
                "type": 1,
                "aid": 1,
                "aaid": 1,
                "lat": 1,
                "lng": 1,
                "pt": 1520696319,
                "paytp": 0,
                "contact": "contact",
                "salenum": 0,
                "deadline": "2018-05",
                "unit": "ci",
                "pet": 1520696319,
                "itemdetail": {
                    "itemid": 1,
                    "mark": "得到的，个，个，个，个，",
                    "ct": 1520696319,
                    "mt": 0
                },
                "itemimg": [
                    {
                        "id": 1,
                        "itemid": 1,
                        "url": "/itemimg1",
                        "uid": 1,
                        "ct": 1520696319
                    },
                    {
                        "id": 2,
                        "itemid": 1,
                        "url": "/itemimg2",
                        "uid": 1,
                        "ct": 1520696319
                    }
                ]
            },
            {
				......                
            }
        ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/item?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=1&per-page=2"
            },
            "next": {
                "href": "http://devapi.helpe.online/v1/item?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=2&per-page=2"
            },
            "last": {
                "href": "http://devapi.helpe.online/v1/item?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=15&per-page=2"
            }
        },
        "_meta": {
            "totalCount": 29,
            "pageCount": 15,
            "currentPage": 1,
            "perPage": 2
        }
    }
}
```


###9.3 发布接口###

/v1/item/pub

提交服务或求助的信息

### 请求参数 ###
URL /v1/item/pub?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- token  登陆后服务器给的token
- uid  登陆后服务器给的uid
- aid  选择的地址名称
- name  商品求助名称
- type   0 商品 1 求助
- cid  分类ID
- price 价格
- unit 单位
- mark  描述
- paytp 支付类型 0 线上支付  1 线下支付 2  线上支付  线下支付
- contact  联系方式  100字节以内 
- itemfile 商品图片，类型文件，请把客户端模拟的form里面file 的那么设为itemfile  支持多个图片上传


###返回结果###
```
{
    "status": 0,
    "data": {
        "uid": 1,
        "aid": "22",
        "appid": 0,
        "name": "test22",
        "type": "0",
        "cid": 0,
        "price": 0,
        "paytp": 0,
        "contact": "testtest11tesxt",
        "flag": 1,
        "tag": "133333",
        "aaid": 0,
        "lat": 1,
        "lng": 1,
        "pt": 1522495828,
        "pet": 0,
        "img": "",
        "ct": 1522495828,
        "mt": 1522495828,
        "id": 351
    },
    "err": ""
}
```

###9.4 更新接口###

/v1/item/update

根据制定的itemid,更新信息

### 请求参数 ###
URL /v1/item/pub?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- id   需要修改的商品id
- aid  选择的地址名称
- name  商品求助名称
- type   0 商品 1 求助
- cid  分类ID
- price 价格
- unit 单位
- paytp 支付类型 0 线上支付  1 线下支付 2  线上支付  线下支付
- contact  联系方式  100字节以内 
- deadline 时间格式

图片 请把客户端模拟的form里面file 的那么设为itemfile  支持多个图片上传


###返回结果###
```
{
    "status": 0,
    "data": {
        "uid": 1,
        "aid": "22",
        "appid": 0,
        "name": "test22",
        "type": "0",
        "cid": 0,
        "price": 0,
        "paytp": 0,
        "contact": "testtest11tesxt",
        "flag": 1,
        "tag": "133333",
        "aaid": 0,
        "lat": 1,
        "lng": 1,
        "pt": 1522495828,
        "pet": 0,
        "img": "",
        "ct": 1522495828,
        "mt": 1522495828,
        "id": 351
    },
    "err": ""
}
```


###9.5 详情接口###

/v1/item/info

根据请求条件返回商品（服务和求助）信息

### 请求参数 ###
URL /v1/item/info?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

GET 请求

- token  登陆后服务器给的token
- uid  登陆后服务器给的uid
- id itemid

###返回结果###
```
{
    "status": "0",
    "err": "success",
    "data": {
        "id": 1,
        "name": "1",
        "appid": 1,
        "price": "1000.00",
        "img": "/img",
        "flag": 0,
        "ct": 1520696319,
        "mt": 1521261910,
        "uid": 1,
        "cid": 1,
        "tag": 0,
        "type": 1,
        "aid": 1,
        "aaid": 1,
        "lat": 1,
        "lng": 1,
        "pt": 1520696319,
        "paytp": 0,
        "contact": "contact",
        "salenum": 0,
        "deadline": "2018-05",
        "unit": "ci",
        "pet": 1520696319,
        "itemdetail": {
            "itemid": 1,
            "mark": "得到的，个，个，个，个，",
            "ct": 1520696319,
            "mt": 0
        },
        "itemimg": [
            {
                "id": 1,
                "itemid": 1,
                "url": "/itemimg1",
                "uid": 1,
                "ct": 1520696319
            },
            {
                "id": 2,
                "itemid": 1,
                "url": "/itemimg2",
                "uid": 1,
                "ct": 1520696319
            }
        ]
    }
}
```

###9.6 上架接口###

/v1/item/online

根据商品id上架

### 请求参数 ###
URL /v1/item/online?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- token  登陆后服务器给的token
- uid  登陆后服务器给的uid
- id  商品id

###返回结果###
```
{
    "status": 0,
    "data": {
        "uid": 1,
        "aid": "22",
        "appid": 0,
        "name": "test22",
        "type": "0",
        "cid": 0,
        "price": 0,
        "paytp": 0,
        "contact": "testtest11tesxt",
        "flag": 1,
        "tag": "133333",
        "aaid": 0,
        "lat": 1,
        "lng": 1,
        "pt": 1522495828,
        "pet": 0,
        "img": "",
        "ct": 1522495828,
        "mt": 1522495828,
        "id": 351
    },
    "err": ""
}
```

###9.7 下架接口###

/v1/item/unline

根据商品id下架

### 请求参数 ###
URL /v1/item/unline?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- token  登陆后服务器给的token
- uid  登陆后服务器给的uid
- id  商品id

###返回结果###
```
{
    "status": 0,
    "data": {
        "uid": 1,
        "aid": "22",
        "appid": 0,
        "name": "test22",
        "type": "0",
        "cid": 0,
        "price": 0,
        "paytp": 0,
        "contact": "testtest11tesxt",
        "flag": 1,
        "tag": "133333",
        "aaid": 0,
        "lat": 1,
        "lng": 1,
        "pt": 1522495828,
        "pet": 0,
        "img": "",
        "ct": 1522495828,
        "mt": 1522495828,
        "id": 351
    },
    "err": ""
}
```

###9.8 更新封面接口###

/v1/item/dimg

根据商品id下架

### 请求参数 ###
URL /v1/item/dimg?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- token  登陆后服务器给的token
- id  商品id
- pid  商品的图片id

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```

##10.地址模块##
###10.1列表接口
/v1/address[/index]

根据请求条件返回当前用户的地址列表结果

### 请求参数 ###
GET 请求

- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###
```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 1,
                "uid": 1,
                "aid": 1,
                "info": "测试地址",
                "ct": 1111,
                "lat": 1,
                "lng": 1
            }
        ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/address/index?orderid=80&t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=1"
            }
        },
        "_meta": {
            "totalCount": 1,
            "pageCount": 1,
            "currentPage": 1,
            "perPage": 20
        }
    }
}
```

###10.2 添加地址接口###

/v1/address/add

添加用户地址

### 请求参数 ###
URL /v1/address/add?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- info  地址信息
- province   区域
- lat   维度
- lng  经度

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```

###10.3 修改地址接口###

/v1/address/update

修改用户地址

### 请求参数 ###
URL /v1/address/add?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- id   地址id
- info  地址信息
- province   区域
- lat   维度
- lng  经度

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```

###10.4 删除地址接口###

/v1/address/del

删除用户地址

### 请求参数 ###
URL /v1/address/del?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- id   地址id

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```



##11. 服务器模块##
###11.1 配置信息接口###

/v1/server/info

返回服务器信息，无需登录

### 请求参数 ###
URL /v1/item/info

GET 请求

- 
###返回结果###

```
{
    "status": 0,
    "data": {
        "f&qUrl": "faq/index.html",
        "staticUrl": "https://testimg.heple.online",
        "version": "1.0.0"
    },
    "err": ""
}
```


###11.2 im签名接口###

/v1/server/imsign

返回服务器信息

### 请求参数 ###
URL /v1/item/imsign?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

GET 请求
- client_id im客户端id
 
###返回结果###

```
{
    "status": 0,
    "data": {
        "str": "YUk7QH8aEBusDod00FYqVxeI-MdYXbMMI:test::1521703449:cs2EV",
        "signature": "0349dbdc6687f32c7af3796b6be9ebed3381b2d8",
        "timestamp": 1521703449,
        "nonce": "cs2EV"
    },
    "err": ""
}
```
##12.交易记录模块##
###12.1列表接口
/v1/mlog[/index]

根据请求条件返回自己的列表

### 请求参数 ###
URL /v1/mlog?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5
GET 请求 

- pid 父分类id
- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###
```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 312,
                "uid": 2,
                "tpid": 1,
                "data": "{\"username\":\"ft20082\",\"itemname\":\"name555\"}",
                "ct": 1522660952
            },
           ......
                   ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/mlog/index?t=anVQYwkJZrPvyJZStDSa6K9AAmkKcydCTHdreTU8&page=1"
            },
            "next": {
                "href": "http://devapi.helpe.online/v1/mlog/index?t=anVQYwkJZrPvyJZStDSa6K9AAmkKcydCTHdreTU8&page=2"
            },
            "last": {
                "href": "http://devapi.helpe.online/v1/mlog/index?t=anVQYwkJZrPvyJZStDSa6K9AAmkKcydCTHdreTU8&page=2"
            }
        },
        "_meta": {
            "totalCount": 33,
            "pageCount": 2,
            "currentPage": 1,
            "perPage": 20
        }
    }
}
```

##13.关注模块##
###13.1我的关注列表
/v1/follow[/index]

返回当前用户添加的关注列表

### 请求参数 ###
GET 请求

- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###
```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 1,
                "uuid": 2,
                "uid": 1,
                "ct": 1523174583,
                "mt": 1523174583,
                "userinfo": {
                    "id": 1,
                    "type": 1,
                    "email": "ft20082@qq.com",
                    "username": null,
                    "face": null,
                    "gender": null,
                    "birthday": null,
                    "career": null,
                    "city": null,
                    "tel": null,
                    "ip": "127.0.0.1",
                    "info": null,
                    "status": 1,
                    "created_at": 1521041986,
                    "updated_at": 1521213114
                },
                "fuserinfo": {
                    "id": 2,
                    "type": 1,
                    "email": "824322790@qq.com",
                    "username": null,
                    "face": null,
                    "gender": null,
                    "birthday": null,
                    "career": null,
                    "city": null,
                    "tel": null,
                    "ip": null,
                    "info": null,
                    "status": 1,
                    "created_at": 1521041986,
                    "updated_at": 1521041986
                }
            }
        ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/follow/index?id=1&t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=1"
            }
        },
        "_meta": {
            "totalCount": 1,
            "pageCount": 1,
            "currentPage": 1,
            "perPage": 20
        }
    }
}
```

###13.2关注我的列表
/v1/follow[/index]

返回当前用户添加的关注列表

### 请求参数 ###
GET 请求

- page 指定页面
- per-page 每页多少个 	

### 返回结果 ###
```
{
    "status": "0",
    "err": "success",
    "data": {
        "data": [
            {
                "id": 1,
                "uuid": 2,
                "uid": 1,
                "ct": 1523174583,
                "mt": 1523174583,
                "userinfo": {
                    "id": 1,
                    "type": 1,
                    "email": "ft20082@qq.com",
                    "username": null,
                    "face": null,
                    "gender": null,
                    "birthday": null,
                    "career": null,
                    "city": null,
                    "tel": null,
                    "ip": "127.0.0.1",
                    "info": null,
                    "status": 1,
                    "created_at": 1521041986,
                    "updated_at": 1521213114
                },
                "fuserinfo": {
                    "id": 2,
                    "type": 1,
                    "email": "824322790@qq.com",
                    "username": null,
                    "face": null,
                    "gender": null,
                    "birthday": null,
                    "career": null,
                    "city": null,
                    "tel": null,
                    "ip": null,
                    "info": null,
                    "status": 1,
                    "created_at": 1521041986,
                    "updated_at": 1521041986
                }
            }
        ],
        "_links": {
            "self": {
                "href": "http://devapi.helpe.online/v1/follow/index?id=1&t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5&page=1"
            }
        },
        "_meta": {
            "totalCount": 1,
            "pageCount": 1,
            "currentPage": 1,
            "perPage": 20
        }
    }
}
```

###10.3 添加关注接口###

/v1/follow/save

添加收藏

### 请求参数 ###
URL /v1/follow/save?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- uid  用户id

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```

###13.4 删除关注接口###

/v1/follow/del

删除用户地址

### 请求参数 ###
URL /v1/follow/del?t=EsKudjqJMjph43zhtM5FYARG47QSmDUP5tIRsHC5

POST 请求

- id   地址id

###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```
















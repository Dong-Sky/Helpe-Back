# Helpe 数据接口API

##服务器接口概览##
1. 商铺列表 此版本不支持
2. 商品类型
3. 认证
	* 登录
   * 注册
   * 修改密码
   * 登出
4. 用户
   * 用户信息
   * 修改
5. 订单
    * 订单详情
    * 我的订单
    * 下单
    * 我的出售订单
    * 订单状态更新()
6. 支付记录
    * 支付记录
  
7. 举报
    * 添加举报
8. 收藏
    * 收藏动作
    * 删除收藏
    * 收藏列表
9. 评价
    * 评价动作
    * 评价列表
10. 商品
    * 发布
    * 上架
    * 下架
    * 设置默认图片
    * 自定义属性 此版本不支持
    * 商品列表
    * 商品详情  
    * 我商品列表  
11. 地址    
    * 增加用户地址
    * 用户地址列表
    * 用户地址修改
    * 用户地址删除
12. 服务器
    * 服务器信息
    * 聊天im认证接口

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


## 注册接口 2个步骤
POST GET 请求
/v1/passport/checkEmail
注册步骤1
根据返回 status 的状态判断,0是正常, 非0是异常

### 请求参数 ###
- email 	客户端检查电子邮件准确性, 如果准确,往服务端检查校验

### 返回结果 ###
```
{
	"code" : 0,
	"message" : null,
	"data" : [],
}
```

POST GET 请求
/v1/passport/register
注册步骤2
说明: 请求内容必须包含电子邮件的校验key

### 请求参数 ###
- username		用户名<电子邮件>
- password		密码
- nickname		昵称
- authtoken 	电子邮件校验key

### 返回结果 ###
```
{
	"status" : 0,
	"err" : null,
	"data" : [],
}
```


##商品（服务，求助）模块##
###列表接口
/v1/item[/list]

根据请求条件返回列表结果，支持字段筛选

### 请求参数 ###
GET 请求

- t
- page=2
- per-page=2 	
- order 
- fields

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


###发布接口###

/v1/item/list/pub

根据请求条件返回列表结果，支持字段筛选

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
- mark  描述
- paytp 支付类型 0 线上支付  1 线下支付 2  线上支付  线下支付
- contact  联系方式  100字节以内 

图片 请把客户端模拟的form里面file 的那么设为itemfile  支持多个图片上传


###返回结果###
```
{
    "status": 0,
    "data": [],
    "err": ""
}
```









<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 11/03/2018
 * Time: 13:56
 */

namespace api\helpers;

class ResponseStatus {

    /**
     * @var array
     * 返回消息结构处理
     */
    public static $status = [
        // 基础信息
        0 => "",                                        // 正常返回
        404 => 'REQUEST_PATH_ERROR',                    // 页面请求的路径错误
        9995 => 'PASSWORD_CHECK_ERROR',                 // 密码检查错误
        9996 => 'SAVE_TO_DATABASE_ERROR',               // 保存到数据库错误
        9997 => 'REQUEST_TYPE_ERROR',                   // 请求类型错误指定get或post
        9998 => 'REQUEST_PARAM_ERROR',                  // 请求参数错误
        9999 => 'UNKNOWN_ERROR',                        // 未知错误
        10000 => 'ACCESS_TOKEN_CHECK_ERROR',            // ACCESS TOKEN 检查错误

        // 注册接口步奏1 错误内容
        10001 => 'EMAIL_ADDRESS_CHECK_ERROR',           // 邮件地址检查错误
        10002 => 'SEND_EMAIL_CHECK_FREQUENTLY',         // 邮件发送太频繁, 要隔一定时间,默认是1分钟
        10003 => 'PASSPORT_EMAIL_EXISTS',               // 通行证表邮件已存在
        10004 => 'SEND_EMAIL_CHECK_FAILURE',            // 电子邮件发送失败

        // 注册接口步奏2 注册错误
        10005 => 'REGISTER_TOKEN_CHECK_ERROR',          // 注册的校验 token 检查错误
        10006 => 'REGISTER_EMAIL_CHECK_ERROR',          // 注册邮件检查错误
        10007 => 'SAVE_TO_DATABASE_ERROR',              // 保存到数据库错误

        // 登录接口
        10008 => 'LOGIN_IN_TYPE_ERROR',                 // 登录类型错误, 在不接受的范围内
        10009 => 'USER_IS_NOT_EXISTS',                  // 用户不存在 默认登录的电子邮件
        10010 => 'USER_PASSWORD_ERROR',                 // 用户名密码错误
        10011 => 'USER_INFO_GET_ERROR',                 // 常规登录用户信息获取错误
        10012 => 'USER_INFO_SAVE_ERROR',                // 常规登录用户信息获取错误
        // 第三方 登录信息
        10012 => 'THIRD_PARTY_USER_TOKEN_CHECK_ERROR',  // 第三方用户登录 token 错误
        10013 => 'THIRD_PARTY_GET_USER_INFO_ERROR',     // 第三方token 获取用户信息错误

        // 用户更新接口
        10014 => 'USERNAME_CHECK_ERROR',                // 用户名检查错误

        // 用户重置密码接口
        10015 => 'THIRD_PARTY_NOT_SUPPORT',             // 第三方登录不支持, 比如重置密码

        10016 => 'AUTH_TOKEN_CHECK_ERROR',              // 校验码检查错误
        10017 => 'ALIYUN_OSS_OPERATE_ERROR',            // 阿里云OSS操作错误
        10018 => 'USER_IMG_UPLOAD_ERROR',               // 用户图片上传错误


        20001 => 'ITEM_NO_EXIST',                        //商品不存在
        20002 => 'SAVE_TO_DATABASE_ERROR',              // 保存到数据库错误
        20003 => 'ITEM_IMAGE_NO_EXIST',                  //商品图片不存在
        20004 => 'ITEM_NO_OWNER',                        //当前用户不是所有者
        20005 => 'ITEM_ON_ONLINE',                         //商品当前发布状态

        30001 => 'ORDER_INVILAD_ITEM',                  // item不存在或者是自己的

        40001 => 'ORDER_INVILAD_ADDRESS',               // 订单地址不存在
        40002 => 'ORDER_NO_EXIST',                      // 订单不存在
        40003 => 'ORDER_NOT_OWNER',                      // 订单用户不是owner
        40004 => 'ORDER_STATUS_VALID',                   // 订单状态无效
        40005 => 'ORDER_NOT_ITEM_OWNER',                   //不是求助商品的所有者
        40006 => 'ORDER_NOT_ORDER_USER',                   //下单用户本人


        50001 => 'FAV_EXIST',                           // 收藏已经存在

        60001 => 'FEEDBACK_REPEAT',                       //评论重复
        60002 => 'FEEDBACK_NOT_BUYER_OR_HELPER',          //评论必须是购买者或者求助者
        60003 => 'FEEDBACK_NO_EXIST',                       //评论不存在

    ];

    /**
     * @param int $code
     * @return mixed
     * 获取错误内容
     */
    public static function getMessage($code = 0) {
        if(isset(self::$status[$code])) {
            return self::$status[$code];
        }
        return self::$status[9999];
    }

}
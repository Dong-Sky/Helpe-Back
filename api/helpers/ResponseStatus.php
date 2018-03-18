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


        20001=> '',
        20002 => 'SAVE_TO_DATABASE_ERROR',              // 保存到数据库错误

        30001 => 'ORDER_INVILAD_ITEM',                  // item不存在或者是自己的

        40001 => 'ORDER_INVILAD_ADDRESS',               // 地址不存在

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
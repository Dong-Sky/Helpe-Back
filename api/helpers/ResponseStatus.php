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
        9999 => 'UNKNOWN_ERROR',                        // 未知错误

        // 注册接口步奏1 错误内容
        10001 => 'EMAIL_ADDRESS_CHECK_ERROR',           // 邮件地址检查错误
        10002 => 'SEND_EMAIL_CHECK_FREQUENTLY',         // 邮件发送太频繁, 要隔一定时间,默认是1分钟
        10003 => 'PASSPORT_EMAIL_EXISTS',               // 通行证表邮件已存在
        10004 => 'SEND_EMAIL_CHECK_FAILURE',            // 电子邮件发送失败

        // 注册接口步奏2 注册错误
        10005 => 'REGISTER_TOKEN_CHECK_ERROR',          // 注册的校验 token 检查错误
        10006 => 'REGISTER_EMAIL_CHECK_ERROR',          // 注册邮件检查错误
        10007 => 'SAVE_TO_DATABASE_ERROR',              // 保存到数据库错误





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
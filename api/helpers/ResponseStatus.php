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
        0 => "",                                        // 正常返回
        9999 => 'UNKNOWN_ERROR',                        // 未知错误
        // 注册接口错误内容
        10001 => 'PASSPORT_CHECK_EMAIL_ERROR',          // 邮件地址检查错误
        10002 => 'PASSPORT_EMAIL_SEND_FREQUENTLY',      // 邮件发送太频繁, 要隔一定时间,默认是1分钟
        10003 => 'PASSPORT_EMAIL_EXISTS',               // 电子邮件已存在




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
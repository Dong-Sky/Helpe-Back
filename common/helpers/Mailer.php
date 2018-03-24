<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 10/03/2018
 * Time: 21:36
 */

namespace common\helpers;

use Yii;
use common\models\MailTemplate;
use Mailgun\Mailgun;

class Mailer
{


    /**
     * 注册发送校验码
     * 文本模板存储在数据库中
     * @param $email
     * @param $checkDigit
     * @return bool
     */
    public static function forgetPassword($email, $checkDigit) {
        $mailTemplate = MailTemplate::findOne('forgetPassword');
        if(!empty($mailTemplate['text'])) {
            $text = str_replace(
                ['{{email}}', '{{checkDigit}}'], [$email, $checkDigit], $mailTemplate['text']
            );
        } else {
            $text = null;
        }
        if(!empty($mailTemplate['html'])) {
            $html = str_replace(
                ['{{email}}', '{{checkDigit}}'], [$email, $checkDigit], $mailTemplate['text']
            );
        } else {
            $html = null;
        }
        return self::sendMailItem($mailTemplate['from'], $email, $mailTemplate['subject'], $text, $html);

    }


    /**
     * 注册发送校验码
     * 文本模板存储在数据库中
     * @param $email
     * @param $checkDigit
     * @return bool
     */
    public static function registerCheckDigit($email, $checkDigit) {
        $mailTemplate = MailTemplate::findOne('registerCheckDigit');
        if(!empty($mailTemplate['text'])) {
            $text = str_replace(
                ['{{email}}', '{{checkDigit}}'], [$email, $checkDigit], $mailTemplate['text']
            );
        } else {
            $text = null;
        }
        if(!empty($mailTemplate['html'])) {
            $html = str_replace(
                ['{{email}}', '{{checkDigit}}'], [$email, $checkDigit], $mailTemplate['text']
            );
        } else {
            $html = null;
        }
        return self::sendMailItem($mailTemplate['from'], $email, $mailTemplate['subject'], $text, $html);

    }

    /**
     * @param $from
     * @param $to
     * @param $subject
     * @param $text
     * @param $html
     * @return bool
     * 返回发送邮件的结果
     */
    public static function sendMailItem($from, $to, $subject, $text, $html) {
        $mgClient = new Mailgun(Yii::$app->params['mailGunApiKey']);
        $domain = Yii::$app->params['mailGunDomainName'];
        $param = [
            'from' => $from,
            'to' => $to,
            'subject' => $subject,
        ];
        if(!empty($text)) {
            $param['text'] = $text;
        }
        if(!empty($html)) {
            $param['html'] = $html;
        }
        try {
            $ret = $mgClient->sendMessage($domain, $param);
        } catch (\Exception $e) {
            $ret = false;
        }
        Yii::info(json_encode($param) . ', return code : ' . $ret->http_response_code, 'api');
        return  $ret ? $ret->http_response_code === 200 : false;
    }
}
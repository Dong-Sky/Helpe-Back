<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 11/03/2018
 * Time: 22:45
 */

namespace common\helpers;

use Yii;

class Cache {

    /**
     * 根据返回结果判断数据是否写入缓存中
     * @param $key
     * @param $callable
     * @param null $duration
     * @param null $dependency
     * @return mixed
     */
    public static function getOrSet($key, $callable, $duration = null, $dependency = null) {
        $cache = Yii::$app->cache;
        $data = $cache->get($key);
        if($data === false) {
            $data = call_user_func($callable);
            if($data !== false && $data !== null) {
                $cache->set($key, $data, $duration, $dependency);
            }
        }
        return $data;
    }



}
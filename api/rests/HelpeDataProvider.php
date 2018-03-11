<?php
namespace api\rests;

use yii\db\QueryInterface;
use yii\base\InvalidConfigException;

class HelpeDataProvider extends \yii\data\ActiveDataProvider
{

    public $cache_timeout = 300;
    /**
     * @var ['key'=>"",'cache_depend'=>""]
     */
    public $cache_rule;

    public function getCacheKey(){
        return $this->cache_rule["key"];
    }

    public function getCacheRule(){
        return $this->cache_rule;
    }

    public function getCacheDepend(){
        return $this->cache_rule['cache_depend'];
    }

    public function getCacheTimeout(){
        return $this->cache_timeout;
    }
}
?>
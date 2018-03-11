<?php
namespace api\rests;

use yii\db\QueryInterface;
use yii\base\InvalidConfigException;

class HelpeDataProvider extends \yii\data\ActiveDataProvider
{

    public $cache_rule;

    public function getCacheKey(){
        return "item_list_1";
    }
}
?>
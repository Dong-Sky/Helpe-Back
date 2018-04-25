<?php
namespace api\rests;

use yii\db\QueryInterface;
use yii\base\InvalidConfigException;

class HelpeDataProvider extends \yii\data\ActiveDataProvider
{
//    public $cache_timeout = 300;
//    /**
//     * @var ['key'=>"",'cache_depend'=>""]
//     */
//    public $cache_rule;
//
//    public function getCacheKey(){
//        return  $this->query;
//    }
//
//    public function getCacheRule(){
//        return $this->cache_rule;
//    }
//
//    public function getCacheDepend(){
//        return $this->cache_rule['cache_depend'];
//    }
//
//    public function getCacheTimeout(){
//        return $this->cache_timeout;
//    }
//
//    public function setIsOne($isOne){
//        return $this->isOne;
//    }
//
//
//    /**
//     * {@inheritdoc}
//     */
//    protected function prepareModels()
//    {
//
//        if (!$this->query instanceof QueryInterface) {
//            throw new InvalidConfigException('The "query" property must be an instance of a class that implements the QueryInterface e.g. yii\db\Query or its subclasses.');
//        }
//        $query = clone $this->query;
//        if (($pagination = $this->getPagination()) !== false) {
//            $pagination->totalCount = $this->getTotalCount();
//            $query->limit($pagination->getLimit())->offset($pagination->getOffset());
//        }
//        if (($sort = $this->getSort()) !== false) {
//            $query->addOrderBy($sort->getOrders());
//        }
//        return \Yii::$app->db->cache(function ($db) use ($query) {
//            return $query->all($db);
//        },$this->getCacheTimeout(),$this->getCacheDepend());
//
//    }
//
//    /**
//     * @inheritdoc
//     */
//    protected function prepareTotalCount()
//    {
//        if (!$this->query instanceof QueryInterface) {
//            throw new InvalidConfigException('The "query" property must be an instance of a class that implements the QueryInterface e.g. yii\db\Query or its subclasses.');
//        }
//        $query = clone $this->query;
//        $db = $this->db;
//        if($db === null){
//            $modelClass = $this->query->modelClass;
//            $db = $modelClass::getDb();
//        }
//        return $db->cache(function($db) use($query){
//            return (int) $query->limit(-1)->offset(-1)->orderBy([])->count('*', $db);
//        },$this->getCacheTimeout(),$this->getCacheDepend());
//    }
}
?>
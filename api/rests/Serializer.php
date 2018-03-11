<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace api\rests;

use Yii;
use yii\base\Arrayable;
use yii\base\Component;
use yii\base\Model;
use yii\data\DataProviderInterface;
use yii\data\Pagination;
use yii\helpers\ArrayHelper;
use yii\web\Link;
use yii\web\Request;
use yii\web\Response;

/**
 * Serializer converts resource objects and collections into array representation.
 *
 * Serializer is mainly used by REST controllers to convert different objects into array representation
 * so that they can be further turned into different formats, such as JSON, XML, by response formatters.
 *
 * The default implementation handles resources as [[Model]] objects and collections as objects
 * implementing [[DataProviderInterface]]. You may override [[serialize()]] to handle more types.
 *
 * @author Qiang Xue <qiang.xue@gmail.com>
 * @since 2.0
 */
class Serializer extends \yii\rest\Serializer
{

    public $cache_rule;

    public function getCacheKey(){
        return "item_list_1";
    }


    protected function __serializeDataProvider($dataProvider){
        if ($this->preserveKeys) {
            $models = $dataProvider->getModels();
        } else {
            $models = array_values($dataProvider->getModels());
        }
        $models = $this->serializeModels($models);
        //var_dump($models);exit;

        if (($pagination = $dataProvider->getPagination()) !== false) {
            $this->addPaginationHeaders($pagination);
        }

        if ($this->request->getIsHead()) {
            return null;
        } elseif ($this->collectionEnvelope === null) {
            return $models;
        } else {
            //var_dump($models);
            $result = [
                $this->collectionEnvelope => $models,
            ];
            if ($pagination !== false) {
                return ['code' => '0', 'message' => 'success', 'data' => array_merge($result, $this->serializePagination($pagination))];
                // return array_merge($result, $this->serializePagination($pagination));
            } else {
                return ['code' => '0', 'message' => 'success', 'data' => $result];
                // return $result;
            }
        }
    }

    /**
     * Serializes a data provider.
     * @param DataProviderInterface $dataProvider
     * @return array the array representation of the data provider.
     */
    protected function serializeDataProvider($dataProvider)
    {

        $cache_key = $dataProvider->getCacheKey();
        //var_dump($cache_key);
        $cache = \Yii::$app->cache;


        $data = $cache->getOrSet($cache_key, function () use($dataProvider) {
            //echo "no cache";
            return $this->__serializeDataProvider($dataProvider);
        },300);

        //var_dump($data);
        return $data;


    }

}
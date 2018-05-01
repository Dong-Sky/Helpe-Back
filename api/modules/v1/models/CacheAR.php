<?php
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use yii\behaviors\TimestampBehavior;
use yii\caching\TagDependency;
use yii\log\Logger;
use api\models\CachedActiveRecord;

class CacheAR extends ActiveRecord
{
    use CachedActiveRecord;

    public function behaviors()
    {
        return [
            'timestamp'=>[
                'class'=>TimestampBehavior::className(),
                'attributes'=>[
                    ActiveRecord::EVENT_BEFORE_INSERT => ['ct', 'mt'],
                    ActiveRecord::EVENT_BEFORE_UPDATE => ['mt']
                ]
            ]
        ];
    }


    /**
     * 如果修改了某条数据，更新list的依赖，并删除对应的key
     * @param bool $runValidation
     * @param null $attributeNames
     * @return bool
     * @throws \Throwable
     * @throws \yii\db\StaleObjectException
     */
    public function save($runValidation = true, $attributeNames = null)
    {
        $saved = parent::save($runValidation, $attributeNames);

        if($saved){
            $pk = $this->getPrimaryKey();
            //单个id
            $key = self::className()."_info_".$pk;
            $modify_tag = self::className()."_list";
            $modify_key = true;

            $modify_tag_dep = new TagDependency(['tags' => $modify_tag]);

            TagDependency::invalidate(Yii::$app->cache, $modify_tag_dep);
            Yii::getLogger()->log("cache TagDependency invalidate ".$modify_tag_dep->tags, Logger::LEVEL_INFO);

            Yii::$app->cache->delete($key);
            Yii::getLogger()->log("cache key delete  ".$key, Logger::LEVEL_INFO);
        }

        return $saved;
    }


    public function delete()
    {
        $deleted = parent::delete();
        if($deleted){
            $pk = $this->getPrimaryKey();
            //单个id
            $key = self::className()."_info_".$pk;
            $modify_tag = self::className()."_list";
            $modify_key = true;

            $modify_tag_dep = new TagDependency(['tags' => $modify_tag]);

            TagDependency::invalidate(Yii::$app->cache, $modify_tag_dep);
            Yii::getLogger()->log("cache TagDependency invalidate ".$modify_tag_dep->tags, Logger::LEVEL_INFO);

            Yii::$app->cache->delete($key);
            Yii::getLogger()->log("cache key delete  ".$key, Logger::LEVEL_INFO);
        }
        return $deleted;
    }


    /**
     * @param $type or=>one_read ow=>one_write list
     * @param null $item_id
     * @return array
     */
    public static function updateCache($modify_tag,$modify_key){

        if($modify_tag){
            $modify_tag = self::className()."_list";
            $modify_tag_dep = new TagDependency(['tags' => $modify_tag]);
            TagDependency::invalidate(Yii::$app->cache, self::class);
            Yii::getLogger()->log("cache TagDependency invalidate ".$modify_tag_dep->tags, Logger::LEVEL_INFO);
        }
        if($modify_key){
            $key = self::className()."_info_".$modify_key;
            Yii::$app->cache->delete($key);
            Yii::getLogger()->log("cache key delete  ".$key, Logger::LEVEL_INFO);
        }


    }

    public static function getOne($pk)
    {
        $key = $key = self::className()."_info_".$pk;
        return \Yii::$app->cache->getOrSet($key,function () use ($pk)  {
            Yii::getLogger()->log("no use cache function one", Logger::LEVEL_INFO);
            return parent::findOne($pk);
        },300, null);
    }


}
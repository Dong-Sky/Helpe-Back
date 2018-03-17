<?php
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use api\modules\v1\models\Itemdetail;
use api\modules\v1\models\Itemimg;
use yii\behaviors\TimestampBehavior;
use yii\caching\TagDependency;
use yii\log\Logger;

class CacheAR extends ActiveRecord
{
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


    /*
     *
     */
    public static function getCacheConfig($element_id=null){
        //有限个
        if($element_id){
            $key = self::className()."_info_".$element_id;
        }else{
         //list
            $qs = \Yii::$app->request->queryParams;
            sort($qs);
            $condition = implode(",",array_values($qs));
            $key = self::className()."_list_".$condition;
        }
        $cache_tag = self::className()."_list";

        return ["key"=>$key,"cache_tag"=>$cache_tag];
    }

    /**
     * @param $type one_read one_write list
     * @param null $item_id
     * @return array
     */
    public static function getCacheRule($type,$element_id=null){
        //$vaid_query_key = ["expand",""]
        $config = self::getCacheConfig($element_id);
        //todo
        $key = $modify_tag = $cache_depend = null;


        $modify_key = false;//是否

        //在这里写cache_rule
        //$modify_tag为是否需要设置失效的缓存依赖,相关依赖的缓存都会更新
        //$key 写入key
        //$cache_depend 需要检查的依赖
        if($type=="or"){ //单个get
            //只要更新key
            $key = $config["key"];
        }elseif($type=="list"){//多个list
            //有依赖，有读写key
            $key = $config["key"];
            $cache_depend = $config["cache_tag"];
        }elseif($type=="ow") { //单个修改
            //有读写可以，有要设置失效的缓存依赖
            $key = $config["key"];
            $modify_tag = $config["cache_tag"];
            $modify_key = true;
        }

        $rule = [];
        $rule["key"] = $key;
        if($modify_tag){
            $rule["modify_tag"] = new TagDependency(['tags' => $modify_tag]);
        }else{
            $rule["modify_tag"] = $modify_tag;
        }
        if($cache_depend){
            $rule["cache_depend"] =  new TagDependency(['tags' => $cache_depend]);
        }else{
            $rule["cache_depend"] = $cache_depend;
        }

        if($modify_key){
            $rule["modify_key"] =  true;
        }

        return $rule;
    }

    public static function getOne($element_id){
        //var_dump($cache_key);
        $cache_config = self::getCacheConfig($element_id);
        $cache = \Yii::$app->cache;

        $data = $cache->get($cache_config['key']);
    }


    /**
     * @param $type or=>one_read ow=>one_write list
     * @param null $item_id
     * @return array
     */
    public static function updateCache($type,$element_id=null){
        $rule = self::getCacheRule($type,$element_id);

        if($rule){
            if(isset($rule["modify_tag"])){
                TagDependency::invalidate(Yii::$app->cache, $rule["modify_tag"]);
                Yii::getLogger()->log("cache TagDependency invalidate ".$rule["modify_tag"]->tags, Logger::LEVEL_INFO);
            }
            if(isset($rule["modify_key"]) && $rule["modify_key"] == true){
                Yii::$app->cache->delete($rule["key"]);
                Yii::getLogger()->log("cache key delete  ".$rule["key"], Logger::LEVEL_INFO);
            }

        }
    }
}
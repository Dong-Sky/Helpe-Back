<?php
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use api\modules\v1\models\Itemdetail;
use api\modules\v1\models\Itemimg;
use api\modules\v1\models\Fav;
use api\modules\v1\models\CacheAR;
use yii\behaviors\TimestampBehavior;
use yii\caching\TagDependency;
use yii\log\Logger;

class Item extends CacheAR
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


    private $_favnum;

    public function setFavnum($count)
    {
        $this->_favnum = (int) $count;
    }

    public static function tableName()
    {
        return '{{%item}}';
    }

    public function getItemdetail(){
        return $this->hasOne(Itemdetail::className(), ['itemid' => 'id']);
    }

    public function getUserInfo(){
        return $this->hasOne(UserInfo::className(), ['id' => 'uid']);
    }

    public function getItemimg(){
        return $this->hasMany(Itemimg::className(), ['itemid' => 'id']);
    }

    public function getFav(){
        return $this->hasMany(Fav::className(), ['itemid' => 'id']);
    }

    public function getIsfav(){
        if ($this->isNewRecord) {
            return 0; // 这样可以避免调用空主键进行查询
        }
        $isfav = 0;
        if(Yii::$app->controller->userId > 0){
            $fav = Fav::find(['uid=:uid and itemid=:itemid',[":uid"=>Yii::$app->controller->userId,":item"=>$this->id]]);
            if($fav->count()){
                $isfav = 1;
            }
        }

        return $isfav;
    }

    public function getFavnum()
    {
        if ($this->isNewRecord) {
            return null; // 这样可以避免调用空主键进行查询
        }

        if ($this->_favnum === null) {
            $this->setFavnum($this->getFav()->count());
        }

        return $this->_favnum;
    }


    public function scenarios()
    {
        $default_scenarios = parent::scenarios();
        return [
            'default'=>$default_scenarios["default"],
            'online'=>[''],
            'update'=>['teacher_id', 'name', 'price', 'address', 'class_time', 'limit_num', 'description', 'update_time'],
        ];
    }


    public function rules(){
        return [
            //[['username','password'],'required','message'=>'不能为空']
            [['uid','name','appid','type','cid','price','paytp','contact','img','flag','tag','aid','aaid','lat','lng',
                'pt','pet'],
                'required','message' => '字段不能为空'],
            ['cid', 'in', 'range' => array(0, 1)],
            ['uid', 'integer'],
        ];
    }

    public function fields()
    {
        $action_id = Yii::$app->controller->action->id;
        $fields = parent::fields();
        if($action_id=="index"){
            $fields += ['itemdetail','itemimg'];
        }elseif($action_id=="info"){
            $fields += ['itemdetail','itemimg','isfav','favnum','userInfo'];
        }

        // 删除一些包含敏感信息的字段
        //unset($fields['auth_key'], $fields['password_hash'], $fields['password_reset_token']);
        //$fields += ['itemdetail','itemimg'];
        return $fields;
    }

    public function extraFields()
    {
        return ['itemdetail','itemimg'];
    }


//    /*
//     *
//     */
//    public static function getCacheConfig($element_id=null){
//        //有限个
//        if($element_id){
//            $key = self::className()."_info_".$element_id;
//        }else{
//         //list
//            $qs = \Yii::$app->request->queryParams;
//            sort($qs);
//            $condition = implode(",",array_values($qs));
//            $key = self::className()."_list_".$condition;
//        }
//        $cache_tag = self::className()."_list";
//
//        return ["key"=>$key,"cache_tag"=>$cache_tag];
//    }
//
//    /**
//     * @param $type one_read one_write list
//     * @param null $item_id
//     * @return array
//     */
//    public static function getCacheRule($type,$element_id=null){
//        //$vaid_query_key = ["expand",""]
//        $config = self::getCacheConfig($element_id);
//        //todo
//        $key = $modify_tag = $cache_depend = null;
//
//
//        $modify_key = false;//是否
//
//        //在这里写cache_rule
//        //$modify_tag为是否需要设置失效的缓存依赖,相关依赖的缓存都会更新
//        //$key 写入key
//        //$cache_depend 需要检查的依赖
//        if($type=="or"){ //单个get
//            //只要更新key
//            $key = $config["key"];
//        }elseif($type=="list"){//多个list
//            //有依赖，有读写key
//            $key = $config["key"];
//            $cache_depend = $config["cache_tag"];
//        }elseif($type=="ow") { //单个修改
//            //有读写可以，有要设置失效的缓存依赖
//            $key = $config["key"];
//            $modify_tag = $config["cache_tag"];
//            $modify_key = true;
//        }
//
//        $rule = [];
//        $rule["key"] = $key;
//        if($modify_tag){
//            $rule["modify_tag"] = new TagDependency(['tags' => $modify_tag]);
//        }else{
//            $rule["modify_tag"] = $modify_tag;
//        }
//        if($cache_depend){
//            $rule["cache_depend"] =  new TagDependency(['tags' => $cache_depend]);
//        }else{
//            $rule["cache_depend"] = $cache_depend;
//        }
//
//        if($modify_key){
//            $rule["modify_key"] =  true;
//        }
//
//        return $rule;
//    }
//
//
//    /**
//     * @param $type or=>one_read ow=>one_write list
//     * @param null $item_id
//     * @return array
//     */
//    public static function updateCache($type,$element_id=null){
//        $rule = self::getCacheRule($type,$element_id);
//
//        if($rule){
//            if(isset($rule["modify_tag"])){
//                TagDependency::invalidate(Yii::$app->cache, $rule["modify_tag"]);
//                Yii::getLogger()->log("cache TagDependency invalidate ".$rule["modify_tag"]->tags, Logger::LEVEL_INFO);
//            }
//            if(isset($rule["modify_key"]) && $rule["modify_key"] == true){
//                Yii::$app->cache->delete($rule["key"]);
//                Yii::getLogger()->log("cache key delete  ".$rule["key"], Logger::LEVEL_INFO);
//            }
//
//        }
//    }
}
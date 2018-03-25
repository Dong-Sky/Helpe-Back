<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 24/03/2018
 * Time: 21:34
 */

namespace api\models;



use common\behaviors\TimestampBehavior;
use yii\base\Model;

class UserAvatar extends Model {


    public $face;

    public function behaviors() {
        return [
            [
                'class' => 'api\helpers\ApiImagesUploaderBehavior',
                'attribute' => 'face',
                'filePath' => '@webroot/images/avatars/[[random_string]].[[extension]]',
                'webroot' => '@webroot',
            ]
        ];

    }

    public function rules(){
        return [
            ['face', 'file', 'extensions' => 'jpeg, jpg, gif, png']
        ];
    }

}
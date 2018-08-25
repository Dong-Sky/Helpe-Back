<?php
/**
 * Created by IntelliJ IDEA.
 * User: jake
 * Date: 2018/8/25
 * Time: 18:13
 */

namespace backend\models;


use yii\base\Model;

class RecommendImg extends Model {


    public $uploadimg;

    public function behaviors() {
        return [
            [
                'class' => 'api\helpers\ApiImagesUploaderBehavior',
                'attribute' => 'uploadimg',
                'filePath' => '@webroot/images/recommend/[[random_string]].[[extension]]',
                'webroot' => '@webroot',
            ]
        ];

    }

    public function rules(){
        return [
            ['uploadimg', 'file', 'extensions' => 'jpeg, jpg, gif, png']
        ];
    }

}
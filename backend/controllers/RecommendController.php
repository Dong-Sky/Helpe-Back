<?php

namespace backend\controllers;


use backend\models\RecommendImg;
use Yii;
use backend\models\AdminLog;
use common\helpers\Helper;
use common\helpers\AliyunOss;

/**
 * Class RecommendController 推荐管理 执行操作控制器
 * @package backend\controllers
 */
class RecommendController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\Recommend';
     
    /**
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'ct_start' => function($value) {
                return ['>=', 'ct', strtotime($value)];
            },
            'ct_end' => function($value) {
                return ['<=', 'ct', strtotime($value)];
            },
        ];
    }


    /**
     * 处理文件上传操作
     * @return mixed|string
     * @see afterUpload()
     */
    public function actionUpload()
    {
        $recommendImg = new RecommendImg();
        $aliyunOss = new AliyunOss();
        $imagePath = "";
        $imageUrl = "";
        try {

            if($recommendImg->validate() && $recommendImg->upload('uploadimg')) {
                $imagePath = $recommendImg->imagePath;
                $imageUrl = $recommendImg->imageUrl;


                //var_dump('<pre>', $recommendImg);

                $ossFile = trim($imageUrl, '/');
                $aliyunOss->uploadFile("helpe-avatar", $ossFile, $imagePath);



                $mixReturn = [
                    'sFilePath' => trim($imageUrl, '.'),
                    'sFileName' => $imagePath,
                ];

                $this->handleJson($mixReturn);


                AdminLog::create(AdminLog::TYPE_UPLOAD, $mixReturn, "img");
            } else {
                $this->setCode(204);
            }

            return $this->returnJson();
        } catch (\Exception $e) {
            Yii::warning("upload image error, " . $e->getMessage(), 'backend');
            return $this->error(203, $e->getMessage());
        }

    }





}

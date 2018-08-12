<?php

namespace backend\controllers;
use backend\models\Category;
use backend\models\Itemdetail;
use backend\models\Itemimg;
use backend\models\Address;
use backend\models\User;
use Yii;

/**
 * Class ItemController 服务求助管理 执行操作控制器
 * @package backend\controllers
 */
class ItemController extends Controller
{
    /**
     * @var string 定义使用的model
     */
    public $modelClass = 'backend\models\Item';
     
    /**
     * 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'id' => '=',
            'name' => 'like',
            'flag' => '=',
            'uid' => '=',
            'cid' => '=',
            'tag' => 'like',
            'type' => '=',
        ];
    }

    /**
     * 处理服务/求助详情
     * @return mixed|string
     */
    public function actionIteminfo() {
        $request = Yii::$app->request;
        $itemid = $request->get('itemid');

        if (empty($itemid)) {
            return $this->error(201);
        }

        $model = $this->modelClass;
        $model = $model::findOne($itemid);

        $itemData = $model->attributes;

        // 处理
        //var_dump($model);
        if (!$model) {
            return $this->error(220, "服务/求助没找到");
        }

        // 处理商品图片数据
        $itemImgAll = Itemimg::find()->where(['itemid' => $itemData['id']])->all();
        $itemImg = [];
        foreach ($itemImgAll as $val) {
            $itemImg[] = $val->attributes;
        }


        // 处理商品详情
        $itemDetail = Itemdetail::findOne(['itemid' => $itemData['id']])->attributes;


        // 处理商品我的地址信息
        $itemAddress = Address::findOne(['id' => $itemData['aid']])->attributes;

        // 处理分类的数据
        $itemCategory = Category::findOne(['id' => $itemData['cid']])->attributes;

        // 处理用户数据
        $itemUserInfo = User::findOne(['id' => $itemData['uid']])->attributes;


        return $this->render('iteminfo', ['item' => $itemData, 'itemimg' => $itemImg, 'itemdetail' => $itemDetail, 'itemaddress' => $itemAddress, 'itemcategory' => $itemCategory, 'itemuserinfo' => $itemUserInfo]);
    }


}

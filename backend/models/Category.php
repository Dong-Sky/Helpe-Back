<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 2018/4/7
 * Time: 15:37
 */

namespace backend\models;


use common\models\AdminModel;
use common\behaviors\TimestampMtBehavior;

class Category extends AdminModel {

    /**
     * @return array
     */
    public function behaviors()
    {
        return [
            TimestampMtBehavior::className(),
        ];
    }

    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%category}}';
    }

    /**
     * 定义验证场景需要验证的字段
     * @return array
     */
    public function scenarios()
    {
        return [
            'default' => ['jp_name', 'cn_name', 'pid', 'sort', 'flag'],
            'update' => ['jp_name', 'cn_name', 'pid', 'sort', 'flag']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'jp_name' => '日本名称',
            'cn_name' => '中文名称',
            'pid' => '父类编号',
            'sort' => '排序',
            'flag' => '状态',
            'ct' => '创建时间',
            'ut' => '修改时间',
        ];
    }

}
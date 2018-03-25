<?php
namespace api\modules\v1\models;

use Yii;
use yii\db\ActiveRecord;
use yii\helpers\FileHelper;
use yii\web\UploadedFile;
use yii\helpers\ArrayHelper;
use yii\behaviors\TimestampBehavior;

class Itemimg extends ActiveRecord
{
    private  $filePath = '@webroot/images/itemfiles/[[random_string]].[[extension]]';
    private  $webroot = '@webroot';
    private  $uploadFile;
    private  $attribute = "itmefile";
    public $imageUrl;
    public $imagePath;

    public function behaviors()
    {
        return [
            'timestamp'=>[
                'class'=>TimestampBehavior::className(),
                'attributes'=>[
                    ActiveRecord::EVENT_BEFORE_INSERT => ['ct']
                ]
            ]
        ];
    }

    public static function tableName()
    {
        return '{{%itemimg}}';
    }


    public function rules(){
        return [
            ['url', 'file', 'extensions' => 'jpeg, jpg, gif, png']
        ];
    }

    /**
     * 保存到文件, 并返回一个随机的文件名
     * @param $attribute
     * @return bool
     * @throws \yii\base\Exception
     */
    public function upload($file) {
        $this->uploadFile = $file;

        if ($file instanceof UploadedFile !== true) {
            return false;
        }

        //getUploadedFilePath
        $this->imagePath = $this->resolvePath($this->filePath);

        FileHelper::createDirectory(pathinfo($this->imagePath, PATHINFO_DIRNAME), 0775, true);

        if (!$file->saveAs($this->imagePath)) {
            throw new FileUploadException($file->error, 'File saving error.');
        }

        $webroot = $this->resolvePath($this->webroot);
        $this->imageUrl = str_replace($webroot, '',$this->imagePath);

        return true;
    }


    /**
     * 添加随机文件名作为保存文件名称
     * @param string $path
     * @return string|void
     */
    public function resolvePath($path) {


        $path = Yii::getAlias($path);

        $pi = pathinfo($this->uploadFile);
        $fileName = ArrayHelper::getValue($pi, 'filename');
        $extension = strtolower(ArrayHelper::getValue($pi, 'extension'));

        return preg_replace_callback('|\[\[([\w\_/]+)\]\]|', function ($matches) use ($fileName, $extension) {
            $name = $matches[1];
            switch ($name) {
                case 'extension':
                    return $extension;
                case 'filename':
                    return $fileName;
                case 'basename':
                    return implode('.', array_filter([$fileName, $extension]));
                case 'app_root':
                    return Yii::getAlias('@app');
                case 'web_root':
                    return Yii::getAlias('@webroot');
                case 'base_url':
                    return Yii::getAlias('@web');
                case 'model':
                    return lcfirst($this->getShortName());
                case 'attribute':
                    return lcfirst($this->attribute);
                case 'id':
                case 'pk':
                    $pk = implode('_', $this->getPrimaryKey(true));
                    return lcfirst($pk);
                case 'id_path':
                    return static::makeIdPath($this->getPrimaryKey());
                case 'parent_id':
                    return $this->parentRelationAttribute;
                case 'random_string':
                    return substr(str_replace(['-', '_', '0', 'o', 'O', 'l', 'L', '1'], '', Yii::$app->security->generateRandomString(70)),0, 15) . '_' . time();
            }
            if (preg_match('|^attribute_(\w+)$|', $name, $am)) {
                $attribute = $am[1];
                return $this->attribute;
            }
            if (preg_match('|^md5_attribute_(\w+)$|', $name, $am)) {
                $attribute = $am[1];
                return md5($this->attribute);
            }
            return '[[' . $name . ']]';
        }, $path);

    }
}
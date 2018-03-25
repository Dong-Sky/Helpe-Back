<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 25/03/2018
 * Time: 00:45
 */

namespace api\helpers;


use yiidreamteam\upload\ImageUploadBehavior;
use Yii;
use yii\helpers\ArrayHelper;
use yii\web\UploadedFile;
use yii\helpers\FileHelper;

class ApiImagesUploaderBehavior extends ImageUploadBehavior {

    public $imagePath;

    public $webroot;

    public $imageUrl;

    public function getImagePath() {
        return $this->imagePath;
    }

    public function getImageUrl() {
        return $this->imageUrl;
    }

    /**
     * 保存到文件, 并返回一个随机的文件名
     * @param $attribute
     * @return bool
     * @throws \yii\base\Exception
     */
    public function upload($attribute) {
        $this->attribute = $attribute;

        if ($this->file instanceof UploadedFile !== true) {
            return false;
        }

        $this->imagePath = $this->getUploadedFilePath($this->attribute);

        FileHelper::createDirectory(pathinfo($this->imagePath, PATHINFO_DIRNAME), 0775, true);

        if (!$this->file->saveAs($this->imagePath)) {
            throw new FileUploadException($this->file->error, 'File saving error.');
        }
        $this->owner->trigger(static::EVENT_AFTER_FILE_SAVE);

        $behavior = static::getInstance($this->owner, $attribute);
        $webroot = $behavior->resolvePath($this->webroot);
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

        $pi = pathinfo($this->owner->{$this->attribute});
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
                    $r = new \ReflectionClass($this->owner->className());
                    return lcfirst($r->getShortName());
                case 'attribute':
                    return lcfirst($this->attribute);
                case 'id':
                case 'pk':
                    $pk = implode('_', $this->owner->getPrimaryKey(true));
                    return lcfirst($pk);
                case 'id_path':
                    return static::makeIdPath($this->owner->getPrimaryKey());
                case 'parent_id':
                    return $this->owner->{$this->parentRelationAttribute};
                case 'random_string':
                    return substr(str_replace(['-', '_', '0', 'o', 'O', 'l', 'L', '1'], '', Yii::$app->security->generateRandomString(70)),0, 15) . '_' . time();
            }
            if (preg_match('|^attribute_(\w+)$|', $name, $am)) {
                $attribute = $am[1];
                return $this->owner->{$attribute};
            }
            if (preg_match('|^md5_attribute_(\w+)$|', $name, $am)) {
                $attribute = $am[1];
                return md5($this->owner->{$attribute});
            }
            return '[[' . $name . ']]';
        }, $path);

    }


}
<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 24/03/2018
 * Time: 18:20
 */

namespace common\helpers;



use api\controllers\ApiException;
use OSS\Core\OssException;
use OSS\OssClient;
use Yii;

class AliyunOss {

    public $accessKeyId = "";
    public $accessKeySecret = "";
    public $endpoint = "";

    private $ossClient;

    public function __construct() {
        try {
            $this->ossClient = new OssClient($this->accessKeyId, $this->accessKeySecret, $this->endpoint, true);
            $this->ossClient->setTimeout(3600);
        } catch (OssException $e) {
            Yii::warning("linked to aliyun oss error, error : " . $e->getMessage(), 'api');
            throw new ApiException(10017);
        }
    }


    /**
     * @return OssClient
     */
    public function getOssClient()
    {
        return $this->ossClient;
    }


    /**
     * OSS 上传到指定文件夹的
     * @param $bucket
     * @param $ossFile
     * @param $localFile
     * @throws ApiException
     */
    public function uploadFile($bucket, $ossFile, $localFile) {
        try {
            $this->ossClient->uploadFile($bucket, $ossFile, $localFile);
        } catch (OssException $e) {
            Yii::warning("upload file error : " . $e->getMessage(), 'api');
            throw new ApiException(10017);
        }
    }








































}
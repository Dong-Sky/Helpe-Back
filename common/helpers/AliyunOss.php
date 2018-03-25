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

    public $accessKeyId;
    public $accessKeySecret;
    public $endpoint;

    private $ossClient;

    public function __construct($accessKeyId = null, $accessKeySecret = null, $endpoint = null) {
        try {
            if($accessKeyId) {
                $this->accessKeyId = $accessKeyId;
            } else {
                $this->accessKeyId = Yii::$app->params['aliyunOssAppId'];
            }
            if($accessKeySecret) {
                $this->accessKeySecret = $accessKeySecret;
            } else {
                $this->accessKeySecret = Yii::$app->params['aliyunOssAppSecret'];
            }
            if($endpoint) {
                $this->endpoint = $endpoint;
            } else {
                $this->endpoint = Yii::$app->params['aliyunOssEndpoint'];
            }
            $this->ossClient = new OssClient($this->accessKeyId, $this->accessKeySecret, $this->endpoint);
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
     * OSS 上传到指定bucket 的 文件, ossFile 是包含目录信息的
     * @param $bucket
     * @param $ossFile
     * @param $localFile
     * @throws ApiException
     */
    public function uploadFile($bucket, $ossFile, $localFile) {
        try {
            Yii::info("upload file info : bucket : " . $bucket . ", ossFile : " . $ossFile . ', localFile : ' . $localFile, 'api');
            $this->ossClient->uploadFile($bucket, $ossFile, $localFile);
        } catch (OssException $e) {
            Yii::warning("upload file error : " . $e->getMessage(), 'api');
            throw new ApiException(10017);
        }
    }


    /**
     * OSS 创建目录
     * @param $bucket
     * @param $dir
     * @throws ApiException
     */
    public function createObjectDir($bucket, $dir) {
        try {
            $this->ossClient->createObjectDir($bucket, $dir);
        } catch (OssException $e) {
            Yii::warning("create object dir error : " . $e->getMessage(), 'api');
            throw new ApiException(10017);
        }
    }








































}
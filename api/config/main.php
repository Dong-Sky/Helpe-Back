<?php
$params = array_merge(
    require(__DIR__ . '/../../common/config/params.php'),
    require(__DIR__ . '/params.php')
);

return [
    'id' => 'helpe-api',
    'basePath' => dirname(__DIR__),
    'bootstrap' => ['log'],
    'controllerNamespace' => 'api\controllers',

    'modules' => [
        'v1' => [
            'class' => 'api\modules\v1\Module',
        ],
        'v2' => [
            'class' => 'api\modules\v2\Module',
        ],
        'debug' => [
            'class' => 'yii\debug\Module',
            'allowedIPs' => ['127.0.0.1', '::1', '*']
        ],
    ],

    'components' => [

        'session' => [
            'class' => 'yii\redis\Session',
            'redis' => 'redis'
        ],

        'cache' => [
            'class' => 'yii\redis\Cache',
            'redis' => 'redis',
        ],

        'redis' => [
            'class' => 'yii\redis\Connection',
            'hostname' => '127.0.0.1',
            'port' => '6379',
            'database' => 0,
            'password' => 'F2hsXBRdbqSx2DGD',
        ],
        // 用户配置
        'user' => [
            'identityClass'   => 'common\models\User',
            'enableAutoLogin' => true,
            'enableSession' => false,
            'loginUrl' => null,
        ],

        // 需要检查 严格校验对 UrlRule 的规则问题
        'urlManager' => [
            'enablePrettyUrl' => true,
            'showScriptName' => false,
            //'enableStrictParsing' => true,
            'rules' => [
                [
                    'class' => 'yii\rest\UrlRule',
                    'controller' => ['v1/user'],
                    //'pluralize' => false,
                ],
                //['class' => 'yii\rest\UrlRule', 'controller' => ['v2/site']]
            ],
        ],

        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning', 'info'],
                ],
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning', 'info'],
                    'categories' => ['api'],
                    'logVars' => ['*'],
                    'logFile' => '@runtime/logs/api.log',
                ]
            ]
        ],


        'response' => [

            'class' => 'yii\web\Response',
            'on beforeSend' => function ($event) {
                $response = $event->sender;
                $response->format = yii\web\Response::FORMAT_JSON;
                if($response->data !== null) {
                    //var_dump($response->data);exit;
                    //var_dump('<pre>', $response);
                    if(isset($response->data['name']) && $response->data['name'] === 'Exception') {
                        //var_dump($response->data, 'ccc');
                        $debug = unserialize($response->data['message']);
                        $response->data = [
                            'status' => $response->data['code'],
                            'err' => \api\helpers\ResponseStatus::getMessage($response->data['code']),
                            'data' => [],
                        ];
                        if(YII_DEBUG){
                            $response->data['debug'] = [$debug];
                        };
                    } else if($response->statusCode !== 200) {
                        if(isset($response->data['message'])) {
                            $debug = unserialize($response->data['message']);
                        } else {
                            $debug = "";
                        }
                        $response->data = [
                            'status' => $response->statusCode,
                            'err' => \api\helpers\ResponseStatus::getMessage($response->statusCode),
                            'data' => [],
                        ];
                        if(YII_DEBUG){
                            $response->data['debug'] = [$debug];
                        };

                    }
                    //var_dump($response);
                }
            },
//
//            'formatters' => [
//                \yii\web\ApiResponse::FORMAT_JSON => [
//                    'class' => 'yii\web\JsonResponseFormatter',
//                    'prettyPrint' => YII_DEBUG,
//                    'encodeOptions' => JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE,
//                ],
//            ],
        ],

    ],



    'params' => $params,
];

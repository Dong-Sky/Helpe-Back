<?php
return [
    'vendorPath' => dirname(dirname(__DIR__)) . '/vendor',
    'components' => [

        // 缓存配置
        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],

        // 数据库配置
        'db' => [
            'class' => 'yii\db\Connection',
            'dsn' => 'mysql:host=127.0.0.1;dbname=db_helpe',
            'username' => 'helpe',
            'password' => 'Y6RZPOtMfa4!^@ww',
            'charset' => 'utf8',
            'tablePrefix' => 'helpe_',
        ],

        'mailer' => [
            'class' => 'yii\swiftmailer\Mailer',
            'viewPath' => '@common/mail',
            // false : 非测试状态, 发送真实邮件而非存储为文件
            'useFileTransport' => false,
            'transport' => [
                'class' => 'Swift_SmtpTransport',
                'host' => 'smtp.mailgun.org',
                'username' => 'postmaster@helpe.online',
                'password' => '306af0f636827d4fa5238e58f548995d-2b4c5a6c-fb008b00',
                'port' => '25',
                'encryption' => 'tls',
            ],
        ],

        // 路由配置
        'urlManager' => [
            'enablePrettyUrl' => true,
            'showScriptName' => false,
            'rules' => [
                '<controller:\w+>/<id:\d+>' => '<controller>/view',
                '<controller:\w+>/<action:\w+>/<id:\d+>' => '<controller>/<action>',
                '<controller:\w+>/<action:\w+>' => '<controller>/<action>',
            ],
        ],

        // 多语言配置
        'i18n' => [
            'translations' => [
                '*' => [
                    'class' => 'yii\i18n\PhpMessageSource',
                    'fileMap' => [
                        'app' => 'app.php',
                        'app/error' => 'error.php',
                    ],
                ],
            ],
        ],

        // 日志
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
    ],
];

<?php
// 定义标题和面包屑信息
$this->title = '用户详情';
//var_dump('<pre>', $this);
use yii\helpers\Html;
?>
<div class="row">
    <div class="col-xs-12 col-sm-12">

        <h4 class="blue">
            <span class="middle"><i class="ace-icon glyphicon glyphicon-user light-blue bigger-110"></i></span>
            用户详细信息
        </h4>

        <div class="profile-user-info">
            <div class="profile-info-row">
                <div class="profile-info-name"> 编号  </div>
                <div class="profile-info-value">
                    <span><?=$user["id"]?></span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 类型  </div>
                <div class="profile-info-value">
                    <span><?php if ($user["type"] == 1) {echo "系统登录";} else {echo "Facebook 登录";}?></span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 电子邮件  </div>
                <div class="profile-info-value">
                    <span><?=$user['email']?></span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 用户名  </div>
                <div class="profile-info-value">
                    <span><?=$user['username']?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 登录token  </div>
                <div class="profile-info-value">
                    <span><?=$user['access_token']?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 重置密码token  </div>
                <div class="profile-info-value">
                    <span><?=$user['password_reset_token']?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 用户头像  </div>
                <div class="profile-info-value">
                    <span><image src="<?=Yii::$app->params["avatarImageBaseUrl"]?><?=$user['face']?>" /></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 性别  </div>
                <div class="profile-info-value">
                    <span><?=$user['gender']?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 生日  </div>
                <div class="profile-info-value">
                    <span><?=$user['birthday']?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 职业  </div>
                <div class="profile-info-value">
                    <span><?=$user['career']?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 城市名称  </div>
                <div class="profile-info-value">
                    <span><?=$user['cityinfo']?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 电话  </div>
                <div class="profile-info-value">
                    <span><?=$user['tel']?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 最后登录IP  </div>
                <div class="profile-info-value">
                    <span><?=$user['ip']?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 详情  </div>
                <div class="profile-info-value">
                    <span><?=Html::encode($user['info'])?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 状态  </div>
                <div class="profile-info-value">
                    <span><?php if ($user["status"] == 1) { echo "正常";} else { echo "禁用";}?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 创建时间  </div>
                <div class="profile-info-value">
                    <span><?=date('Y-m-d H:i:s', $user['created_at'])?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 最后登录时间  </div>
                <div class="profile-info-value">
                    <span><?=date('Y-m-d H:i:s', $user['updated_at'])?></span>
                </div>
            </div>
        </div>

        <div class="hr hr16 dotted"></div>
    </div>
</div>
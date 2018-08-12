<?php
// 定义标题和面包屑信息
$this->title = '服务求助详情';
use yii\helpers\Html;
?>
<div class="row">
    <div class="col-xs-12 col-sm-12">

        <h4 class="blue">
            <span class="middle"><i class="ace-icon glyphicon glyphicon-user light-blue bigger-110"></i></span>
            服务求助详细
        </h4>

        <div class="profile-user-info">
            <div class="profile-info-row">
                <div class="profile-info-name"> 编号  </div>
                <div class="profile-info-value">
                    <span><?=$item["id"]?></span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 名称  </div>
                <div class="profile-info-value">
                    <span><?=$item["name"]?></span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 价格  </div>
                <div class="profile-info-value">
                    <span><?=$item["price"]?></span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 封面图  </div>
                <div class="profile-info-value">
                    <span><image src="<?=Yii::$app->params["avatarImageBaseUrl"]?><?=$item['img']?>" /></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 状态  </div>
                <div class="profile-info-value">
                    <span><?php if ($item["status"] == 0) { echo "上架";} else { echo "下架";}?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 用户相关信息  </div>
                <div class="profile-info-value">
                    <span>用户ID: <?=$item['uid']?>, 用户名: <?=$itemuserinfo['username']?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 分类相关信息  </div>
                <div class="profile-info-value">
                    <span>分类ID: <?=$item['cid']?>, 分类名称: <?=$itemcategory['jp_name']?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 标签  </div>
                <div class="profile-info-value">
                    <span><?=$item["tag"]?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 类型  </div>
                <div class="profile-info-value">
                    <span><?php if ($item["status"] == 0) { echo "商品";} else { echo "求助";}?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 地址相关信息  </div>
                <div class="profile-info-value">
                    <span>地址ID: <?=$item['aid']?>, 地址详情: <?=$itemaddress['info']?>, 地址经度: <?=$itemaddress['lat']?>, 地址纬度: <?=$itemaddress['lng']?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 经度  </div>
                <div class="profile-info-value">
                    <span><?=$item["lat"]?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 纬度  </div>
                <div class="profile-info-value">
                    <span><?=$item["lng"]?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 发布时间  </div>
                <div class="profile-info-value">
                    <span><?=date('Y-m-d H:i:s', $item["pt"])?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 联系方式  </div>
                <div class="profile-info-value">
                    <span><?=$item["contact"]?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 过期文字描述  </div>
                <div class="profile-info-value">
                    <span><?=$item["deadline"]?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 单位  </div>
                <div class="profile-info-value">
                    <span><?=$item["unit"]?></span>
                </div>
            </div>


            <div class="profile-info-row">
                <div class="profile-info-name"> 发布过期时间  </div>
                <div class="profile-info-value">
                    <span><?=date('Y-m-d H:i:s', $item['pet'])?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 创建时间  </div>
                <div class="profile-info-value">
                    <span><?=date('Y-m-d H:i:s', $item['ct'])?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 修改时间  </div>
                <div class="profile-info-value">
                    <span><?=date('Y-m-d H:i:s', $item['mt'])?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 发布详情  </div>
                <div class="profile-info-value">
                    <span><?=$itemdetail["mark"]?></span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 图片详情  </div>
                <div class="profile-info-value">

                    <?php
                        foreach($itemimg as $val) {
                            echo '<span><image src="', Yii::$app->params["avatarImageBaseUrl"], $val["url"], '" /></span><br />';
                        }
                    ?>
                </div>
            </div>

        </div>

        <div class="hr hr16 dotted"></div>
    </div>
</div>
<?php //var_dump('<pre>', $item, $itemimg, $itemdetail, $itemaddress, $itemcategory, $itemuserinfo); ?>
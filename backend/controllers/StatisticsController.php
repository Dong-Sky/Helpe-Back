<?php

namespace backend\controllers;


use backend\models\User;
use yii\db\Query;
use Yii;


/**
 * Class FollowController follow 执行操作控制器
 * @package backend\controllers
 */
class StatisticsController extends Controller
{


    public function actionIndex() {
        date_default_timezone_set("Asia/Shanghai");
        $request = Yii::$app->request;
        date('Y-m-d', time() - 24 * 3600);
        $dateTime = $request->get('date_time', "");
        $dateType = $request->get('date_type', 1);
        $dataType = $request->get('data_type', 1);
        $limit = $request->get('size', 10);
        $limit = $request->get('size', 10);

        $retData = [];

        // 处理商品排行数据
        if (!empty($dateTime)) {
            $dataTypeWhere = " ";
            // 数据类型, 1是全部, 2是服务, 3是求助, 对应的item表 type 字段 是 0 是服务, 1是求助
            if ($dataType == 2) {
                $dataTypeWhere = " and type = 0 ";
            } else if ($dataType == 3) {
                $dataTypeWhere = " and type = 1 ";
            }

            // 按照选择的日期为基准日期
            $dateTimestamp = strtotime($dateTime);

            // 数据类型, 1天, 2周, 3月
            // 处理开始时间和结束时间
            // 包含逻辑部分
            // >=  && <
            // 不包含下个时间段
            if ($dateType == 1) {

                // 结束日期是选择天 + 1天
                $endDateTime = $dateTimestamp + 24 * 3600;

                $startDateTime = $endDateTime - 7 * 24 * 3600;

                $groupSelect = "FROM_UNIXTIME(o.ct, '%Y-%m-%d') dates";
                $groupByItem = "FROM_UNIXTIME(o.ct, '%Y-%m-%d')";

                $query = (new Query())->select("FROM_UNIXTIME(`o`.`ct`, '%Y-%m-%d') as `dates`, o.itemid as item_id, i.name as item_name, count(o.id) as item_count, sum(o.cash) as item_amount ")->from("helpe_orderinfo o")->leftJoin("helpe_item i", "o.itemid = i.id")->where(" o.status = 40 and o.ct >= $dateTimestamp and o.ct < $endDateTime ") ->groupBy("dates, item_id");
                $total = $query->count();

                if ($total) {
                    $array = $query->offset($offset)->limit($limit)->all();
                }


                var_dump('<pre>', $query, $total);


//                $query = Yii::$app->db->createCommand("select $groupSelect, o.itemid as item_id, i.name as item_name, count(o.id) as item_count, sum(o.cash) as item_amount from helpe_orderinfo as o left join helpe_item as i on o.itemid = i.id where o.status = 40 and o.ct >= $dateTimestamp and o.ct < $endDateTime group by $groupByItem,  o.itemid ");
//                $count = $query->c
//
//                $retData = ->queryAll();




            } else if ($dateType == 2) {
                // 一周按照周一的事件作为开始, 然后计算按照date('W')计算每周的数据
                // 选择天所在的周的结束的1天 + 1天
                $weekday = date('w', $dateTimestamp);
                if ($weekday == 0) {
                    // 某一周的最后1天
                    $endDateTime = $dateTimestamp + 24 * 3600;
                } else {
                    // 如果是周1的话, 每周的最新的一天
                    $endDateTime = $dateTimestamp + (7 - $weekday + 1) * 24 * 3600;
                }
                $startDateTime = $endDateTime - 4 * 7 * 24 * 3600;

                $groupSelect = "weekofyear(FROM_UNIXTIME(o.ct, '%Y-%m-%d')) as dates";
                $groupByItem = "weekofyear(FROM_UNIXTIME(o.ct, '%Y-%m-%d'))";

            } else if ($dateType == 3) {
                // 选择天所在的自然月的结束1天 + 1天
                // 当前月的第一个天
                $currentMonthStart = strtotime(date('Y-m-01', $dateTimestamp));
                $endDateTime = strtotime(date('Y-m-01', $currentMonthStart + 31 * 24 * 3600));
                $lastMonthStart = strtotime(date('Y-m-01', $currentMonthStart - 24 * 3600));
                $startDateTime = strtotime(date('Y-m-01', $lastMonthStart - 24 * 3600));

                $groupSelect = "FROM_UNIXTIME(o.ct, '%Y%m') as dates";
                $groupByItem = "FROM_UNIXTIME(o.ct, '%Y%m')";

            }
            // 结算的规则是订单结束, 即订单完成后才算结算, status = 40
            $retData = Yii::$app->db->createCommand("select $groupSelect, o.itemid as item_id, i.name as item_name, count(o.id) as item_count, sum(o.cash) as item_amount from helpe_orderinfo as o left join helpe_item as i on o.itemid = i.id where o.status = 40 and o.ct >= $startDateTime and o.ct < $endDateTime group by $groupByItem,  o.itemid ")->queryAll();
            var_dump('<pre>', Yii::$app->db->createCommand("select $groupSelect, o.itemid as item_id, i.name as item_name, count(o.id) as item_count, sum(o.cash) as item_amount from helpe_orderinfo as o left join helpe_item as i on o.itemid = i.id where o.status = 40 and o.ct >= $startDateTime and o.ct < $endDateTime group by $groupByItem, o.itemid ")->sql);


        }

        return $this->render('index', ['retData' => $retData, 'date_time' => $dateTime, 'date_type' => $dateType, 'data_type' => $dataType]);
    }

    /**
     * 某个用户的商品排行数据, 按照订单
     * @return string
     */
    public function actionTopn() {
        $request = Yii::$app->request;
        $uid = $request->get('uid', 0);
        $limit = $request->get('size', 20);
        $retData = [];

        // 处理用户的商品排行数据
        if (!empty($uid)) {
            // 处理的规则是订单结束,即 订单完成后,才算结算
            $retData['top'] = Yii::$app->db->createCommand("select o.itemid, i.name as item_name, count(1) as item_count, sum(cash) as item_amount from helpe_orderinfo as o left join helpe_item as i on o.itemid = i.id where o.uid = :uid and o.status = 40 group by o.itemid order by item_count desc limit :limit")->bindParam("uid", intval($uid))->bindParam("limit", intval($limit))->queryAll();
//            var_dump('<pre>', Yii::$app->db->createCommand("select o.itemid, i.name as item_name, count(1) as item_count, sum(cash) as item_amount from helpe_orderinfo as o left join helpe_item as i on o.itemid = i.id where o.uid = :uid group by o.itemid order by item_count desc limit :limit")->bindParam("uid", intval($uid))->bindParam("limit", intval($limit))->sql, $ordern);
            $retData['fav'] = Yii::$app->db->createCommand("select f.itemid, t.name as item_name, count(distinct f.uid) as fav_top from helpe_fav as f  left join (select id, name from helpe_item where uid = :uid) t on f.itemid = t.id where itemid in (select id from helpe_item where uid = :uid) group by f.itemid order by fav_top desc limit :limit")->bindParam("uid", intval($uid))->bindParam("limit", intval($limit))->queryAll();
//            var_dump('<pre>', Yii::$app->db->createCommand("select f.itemid, t.name, count(distinct f.uid) as fav_top from helpe_fav as f  left join (select id, name from helpe_item where uid = :uid) t on f.itemid = t.id where itemid in (select id from helpe_item where uid = :uid) group by f.itemid order by fav_top desc limit :limit")->bindParam("uid", intval($uid))->bindParam("limit", intval($limit))->sql, $retData);
        }
        return $this->render('topn', ['retData' => $retData, 'uid' => $uid, 'size' => $limit]);
    }
}

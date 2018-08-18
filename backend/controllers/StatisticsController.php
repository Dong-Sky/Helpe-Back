<?php

namespace backend\controllers;


use backend\models\User;
use yii\data\Pagination;
use yii\db\Query;
use Yii;


/**
 * Class FollowController follow 执行操作控制器
 * @package backend\controllers
 */
class StatisticsController extends Controller
{

    /**
     * 改变数据保存结构
     */
    private function changeData($source) {
        $ret = array();
        foreach($source as $item) {
            $ret[$item['dates']][$item['item_id']] = $item;
        }
        return $ret;
    }

    /**
     * 获取结构里面的item列表
     * @param $source
     * @return array
     */
    private function getItemIdArr($source) {
        $ret = array();
        foreach($source as $item) {
            $ret[] = $item['item_id'];
        }
        return $ret;
    }

    /**
     * 处理流程
     * 先把要计算某一天、周、月的数据获取出来，
     * 做好排序分页， 然后， 再根据时间段， 往前获取所需要的数据。
     * @return string
     * @throws \yii\db\Exception
     */
    public function actionIndex()
    {
        date_default_timezone_set("Asia/Shanghai");
        $request = Yii::$app->request;
        $dateTime = $request->get('date_time', date('Y-m-d', time() - 24 * 3600));
        $dateType = $request->get('date_type', 1);
        $itemType = $request->get('item_type', 1);
        $pageSize = $request->get('per-page', 10);
        $isExport = $request->get('is_export', "false");

        $retData = [];

        $pages = new Pagination([
            'totalCount' => 0,
            'pageSize' => $pageSize,
        ]);

        // 处理商品排行数据
        if (!empty($dateTime)) {
            $dataTypeWhere = " ";
            // 数据类型, 1是全部, 2是服务, 3是求助, 对应的item表 type 字段 是 0 是服务, 1是求助
            if ($itemType == 2) {
                $dataTypeWhere = " and `i`.`type` = 0 ";
            } else if ($itemType == 3) {
                $dataTypeWhere = " and `i`.`type` = 1 ";
            }

            // 按照选择的日期为基准日期
            $dateTimestamp = strtotime($dateTime);

            // 数据类型, 1天, 2周, 3月
            // 处理开始时间和结束时间
            // 包含逻辑部分
            // >=  && <
            // 不包含下个时间段
            // 结算的规则是订单结束, 即订单完成后才算结算, status = 40
            if ($dateType == 1) {

                // 结束日期是选择天 + 1天
                $endDateTime = $dateTimestamp + 24 * 3600;
                $startDateTime = $endDateTime - 7 * 24 * 3600;

                $query = (new Query())->select("FROM_UNIXTIME(`o`.`ct`, '%Y-%m-%d') as `dates`, o.itemid as item_id, i.name as item_name, count(o.id) as item_count, sum(o.cash) as item_amount ")->from("helpe_orderinfo o")->leftJoin("helpe_item i", "o.itemid = i.id")->where(" o.status = 40 and o.ct >= $dateTimestamp and o.ct < $endDateTime $dataTypeWhere ")->groupBy("dates, item_id")->orderBy("dates DESC, item_count DESC, item_id DESC");
                $total = $query->count();

                $retData['day']['startTime'] = $startDateTime;
                $retData['day']['endTime'] = $endDateTime;

                if ($total) {
                    // 处理分页
                    $pages = new Pagination([
                        'totalCount' => $total,
                        'pageSize' => $pageSize,
                    ]);
                    $currentData = $query->offset($pages->offset)->limit($pages->limit)->all();

                    // 获取前面7天的数据, 不包含当天的数据
                    $oldDayData = (new Query())->select("FROM_UNIXTIME(`o`.`ct`, '%Y-%m-%d') as `dates`, o.itemid as item_id, i.name as item_name, count(o.id) as item_count, sum(o.cash) as item_amount ")->from("helpe_orderinfo o")->leftJoin("helpe_item i", "o.itemid = i.id")->where(" o.status = 40 and o.ct >= $startDateTime and o.ct < $dateTimestamp $dataTypeWhere and o.itemid in (".implode(",", $this->getItemIdArr($currentData)).") ")->groupBy("dates, item_id")->orderBy("dates DESC, item_count DESC, item_id DESC")->all();

                    $retData['day']['current'] = $this->changeData($currentData);
                    $retData['day']['old'] = $this->changeData($oldDayData);
                }

                //var_dump('<pre>', $total, "------\n", $currentData, "------\n", $oldDayData); exit();

            } else if ($dateType == 2) {
                // 一周按照周一的事件作为开始, 然后计算按照date('W')计算每周的数据
                // 选择天所在的周的结束的1天 + 1天
                $weekday = date('w', $dateTimestamp);
                // w 为0时，是周日
                if ($weekday == 0) {
                    // 某一周的最后1天
                    $endDateTime = $dateTimestamp + 24 * 3600;
                } else {
                    // 如果是周1的话, 每周的最新的一天
                    $endDateTime = $dateTimestamp + (7 - $weekday + 1) * 24 * 3600;
                }
                // 结束时间为周一 0 点的的时间戳， 开始时间是少4周的时间， 按照每周的数量开始减
                $lastWeekStartTime = $endDateTime - 1 * 7 * 24 * 3600;
                $startDateTime = $endDateTime - 4 * 7 * 24 * 3600;


                $query = (new Query())->select(["YEARWEEK(FROM_UNIXTIME(`o`.`ct`, '%Y-%m-%d'), 3) as `dates`", "o.itemid as item_id", "i.name as item_name", "count(o.id) as item_count", "sum(o.cash) as item_amount"])->from("helpe_orderinfo o")->leftJoin("helpe_item i", "o.itemid = i.id")->where(" o.status = 40 and o.ct >= $lastWeekStartTime and o.ct < $endDateTime $dataTypeWhere ")->groupBy("dates, item_id")->orderBy("dates DESC, item_count DESC, item_id DESC");
                $total = $query->count();


                $retData['week']['startTime'] = $startDateTime;
                $retData['week']['endTime'] = $endDateTime;

                //var_dump('<pre>', $total, "------\n", $query, "------\n"); exit();

                if ($total) {
                    // 处理分页
                    $pages = new Pagination([
                        'totalCount' => $total,
                        'pageSize' => $pageSize,
                    ]);
                    $currentData = $query->offset($pages->offset)->limit($pages->limit)->all();

                    // 获取前面7天的数据, 不包含当天的数据
                    $oldDayData = (new Query())->select(["YEARWEEK(FROM_UNIXTIME(`o`.`ct`, '%Y-%m-%d'), 3) as `dates`", "o.itemid as item_id", "i.name as item_name", "count(o.id) as item_count", "sum(o.cash) as item_amount"])->from("helpe_orderinfo o")->leftJoin("helpe_item i", "o.itemid = i.id")->where(" o.status = 40 and o.ct >= $startDateTime and o.ct < $lastWeekStartTime $dataTypeWhere and o.itemid in (".implode(",", $this->getItemIdArr($currentData)).") ")->groupBy("dates, item_id")->orderBy("dates DESC, item_count DESC, item_id DESC")->all();

                    $retData['week']['current'] = $this->changeData($currentData);
                    $retData['week']['old'] = $this->changeData($oldDayData);
                }

            } else if ($dateType == 3) {
                // 选择天所在的自然月的结束1天 + 1天
                // 当前月的第一个天
                $currentMonthStart = strtotime(date('Y-m-01', $dateTimestamp));
                // 最后一个月的第一天
                $endDateTime = strtotime(date('Y-m-01', $currentMonthStart + 31 * 24 * 3600));
                // 上个月的第一天
                $lastMonthStart = strtotime(date('Y-m-01', $currentMonthStart - 24 * 3600));
                // 三个月前的第一天
                $startDateTime = strtotime(date('Y-m-01', $lastMonthStart - 24 * 3600));


                $query = (new Query())->select(["FROM_UNIXTIME(o.ct, '%Y%m') as dates", "o.itemid as item_id", "i.name as item_name", "count(o.id) as item_count", "sum(o.cash) as item_amount"])->from("helpe_orderinfo o")->leftJoin("helpe_item i", "o.itemid = i.id")->where(" o.status = 40 and o.ct >= $currentMonthStart and o.ct < $endDateTime $dataTypeWhere ")->groupBy("dates, item_id")->orderBy("dates DESC, item_count DESC, item_id DESC");
                $total = $query->count();


                $retData['month']['startTime'] = $startDateTime;
                $retData['month']['endTime'] = $endDateTime;

                //var_dump('<pre>', $total, "------\n", $query, "------\n"); exit();

                if ($total) {
                    // 处理分页
                    $pages = new Pagination([
                        'totalCount' => $total,
                        'pageSize' => $pageSize,
                    ]);
                    $currentData = $query->offset($pages->offset)->limit($pages->limit)->all();

                    // 获取前面7天的数据, 不包含当天的数据
                    $oldDayData = (new Query())->select(["FROM_UNIXTIME(o.ct, '%Y%m') as dates", "o.itemid as item_id", "i.name as item_name", "count(o.id) as item_count", "sum(o.cash) as item_amount"])->from("helpe_orderinfo o")->leftJoin("helpe_item i", "o.itemid = i.id")->where(" o.status = 40 and o.ct >= $startDateTime and o.ct < $currentMonthStart $dataTypeWhere and o.itemid in (".implode(",", $this->getItemIdArr($currentData)).") ")->groupBy("dates, item_id")->orderBy("dates DESC, item_count DESC, item_id DESC")->all();

                    $retData['month']['current'] = $this->changeData($currentData);
                    $retData['month']['old'] = $this->changeData($oldDayData);
                }

            }

        }

        // 检测是否为导出
        if ($isExport == "true") {
            $this->processExport($retData, $dateTime, $dateType, $itemType);
        }

        return $this->render('index', ['retData' => $retData, 'date_time' => $dateTime, 'date_type' => $dateType, 'data_type' => $itemType, 'per_page' => $pageSize, 'pagination' => $pages]);
    }

    /**
     * 处理Excel文件导出功能
     * @param $retData
     * @param $dateTime
     * @param $dateType
     * @param $itemType
     */
    private function processExport($retData, $date_time, $date_type, $itemType) {
        $str = "<html xmlns:o=\"urn:schemas-microsoft-com:office:office\"\r\nxmlns:x=\"urn:schemas-microsoft-com:office:excel\"\r\nxmlns=\"http://www.w3.org/TR/REC-html40\">\r\n<head>\r\n<meta http-equiv=Content-Type content=\"text/html; charset=utf-8\">\r\n</head>\r\n<body>";

        // 处理导出的类型
        $str .= "<table border=1>";

        // 处理导出开始..............................

        $body = "";
        $headOne = '<th colspan="2" style="text-align: center;">商品</th>';
        $headTwo = '<th style="text-align: center;">ID</th><th style="text-align: center;">名称</th>';

        // 解析结果分为处理头，和数据内容2部分
        // 按照天解析数据
        if($date_type == 1) {
            // 解析表头1
            // 解析表头2

            for($i = $retData['day']['startTime']; $i < $retData['day']['endTime']; $i = $i + 24 * 3600) {
                $headOne .= '<th colspan="2" align="center" style="text-align: center;">'.date('Y-m-d', $i).'(天)</th>';
                $headTwo .= '<th style="text-align: center;">销量</th><th style="text-align: center;">销售额</th>';
            }

            if (isset($retData['day']['current']) && !empty($retData['day']['current'])) {
                // 解析报表内容
                foreach($retData['day']['current'] as $idates => $iv) {
                    foreach($iv as $itemId => $iArr) {
                        $body .= "<tr>";
                        $body .= '<td style="text-align: center;">'.$itemId.'</td><td style="text-align: center;">'.$iArr['item_name'].'</td>';
                        for($i = $retData['day']['startTime']; $i < $retData['day']['endTime']; $i = $i + 24 * 3600) {
                            $curDateTime = date('Y-m-d', $i);
                            if($curDateTime == $date_time) {
                                $itemCount = empty($retData['day']['current'][$curDateTime][$itemId]['item_count']) ? 0 : $retData['day']['current'][$curDateTime][$itemId]['item_count'];
                                $itemAmount = empty($retData['day']['current'][$curDateTime][$itemId]['item_amount']) ? 0 : $retData['day']['current'][$curDateTime][$itemId]['item_amount'];
                            } else {
                                $itemCount = empty($retData['day']['old'][$curDateTime][$itemId]['item_count']) ? 0 : $retData['day']['old'][$curDateTime][$itemId]['item_count'];
                                $itemAmount = empty($retData['day']['old'][$curDateTime][$itemId]['item_amount']) ? 0 : $retData['day']['old'][$curDateTime][$itemId]['item_amount'];
                            }
                            $body .= '<td style="text-align: center;">'.$itemCount.'</td><td style="text-align: center;">'.$itemAmount.'</td>';
                        }
                        $body .= "</tr>";
                    }
                }
            } else {
                $body .= '<tr><td colspan="16" style="text-align: center;">没有找到记录</td></tr>';
            }



        } else if ($date_type == 2) {   // 按照周解析数据

            // 按照周的话，是返回4周的数据
            // 解析表头1
            // 解析表头2

            for($i = $retData['week']['startTime']; $i < $retData['week']['endTime']; $i = $i + 7 * 24 * 3600) {
                $headOne .= '<th colspan="2" style="text-align: center;">'.date('o-W', $i).'(周)</th>';
                $headTwo .= '<th style="text-align: center;">销量</th><th style="text-align: center;">销售额</th>';
            }


            if (isset($retData['week']['current']) && !empty($retData['week']['current'])) {
                // 解析报表内容
                foreach($retData['week']['current'] as $idates => $iv) {
                    foreach($iv as $itemId => $iArr) {
                        $body .= "<tr>";
                        $body .= '<td style="text-align: center;">'.$itemId.'</td><td style="text-align: center;">'.$iArr['item_name'].'</td>';
                        for($i = $retData['week']['startTime']; $i < $retData['week']['endTime']; $i = $i + 7 * 24 * 3600) {
                            $curDateTime = date('oW', $i);
                            if($curDateTime == date('oW', strtotime($date_time))) {
                                $itemCount = empty($retData['week']['current'][$curDateTime][$itemId]['item_count']) ? 0 : $retData['week']['current'][$curDateTime][$itemId]['item_count'];
                                $itemAmount = empty($retData['week']['current'][$curDateTime][$itemId]['item_amount']) ? 0 : $retData['week']['current'][$curDateTime][$itemId]['item_amount'];
                            } else {
                                $itemCount = empty($retData['week']['old'][$curDateTime][$itemId]['item_count']) ? 0 : $retData['week']['old'][$curDateTime][$itemId]['item_count'];
                                $itemAmount = empty($retData['week']['old'][$curDateTime][$itemId]['item_amount']) ? 0 : $retData['week']['old'][$curDateTime][$itemId]['item_amount'];
                            }
                            $body .= '<td style="text-align: center;">'.$itemCount.'</td><td style="text-align: center;">'.$itemAmount.'</td>';
                        }
                        $body .= "</tr>";
                    }
                }
            } else {
                $body .= '<tr><td colspan="10" style="text-align: center;">没有找到记录</td></tr>';
            }

        } else if ($date_type == 3) {   // 按照月解析数据

            // 按照月返回的话，是返回3个的数据
            // 解析表头1
            // 解析表头2

            for($i = $retData['month']['startTime']; $i < $retData['month']['endTime']; $i = $i + 32 * 24 * 3600) {
                $headOne .= '<th colspan="2" align="center" style="text-align: center;">'.date('Y-m', $i).'(月)</th>';
                $headTwo .= '<th style="text-align: center;">销量</th><th style="text-align: center;">销售额</th>';
                $i = strtotime(date('Y-m-01', $i));
            }


            if (isset($retData['month']['current']) && !empty($retData['month']['current'])) {
                // 解析报表内容
                foreach($retData['month']['current'] as $idates => $iv) {
                    foreach($iv as $itemId => $iArr) {
                        $body .= "<tr>";
                        $body .= '<td style="text-align: center;">'.$itemId.'</td><td style="text-align: center;">'.$iArr['item_name'].'</td>';
                        for($i = $retData['month']['startTime']; $i < $retData['month']['endTime']; $i = $i + 32 * 24 * 3600) {
                            $curDateTime = date('Ym', $i);
                            if($curDateTime == date('Ym', strtotime($date_time))) {
                                $itemCount = empty($retData['month']['current'][$curDateTime][$itemId]['item_count']) ? 0 : $retData['month']['current'][$curDateTime][$itemId]['item_count'];
                                $itemAmount = empty($retData['month']['current'][$curDateTime][$itemId]['item_amount']) ? 0 : $retData['month']['current'][$curDateTime][$itemId]['item_amount'];
                            } else {
                                $itemCount = empty($retData['month']['old'][$curDateTime][$itemId]['item_count']) ? 0 : $retData['month']['old'][$curDateTime][$itemId]['item_count'];
                                $itemAmount = empty($retData['month']['old'][$curDateTime][$itemId]['item_amount']) ? 0 : $retData['month']['old'][$curDateTime][$itemId]['item_amount'];
                            }
                            $body .= '<td style="text-align: center;">'.$itemCount.'</td><td style="text-align: center;">'.$itemAmount.'</td>';
                            $i = strtotime(date('Y-m-01', $i));
                        }
                        $body .= "</tr>";
                    }
                }
            } else {
                $body .= '<tr><td colspan="10" style="text-align: center;">没有找到记录</td></tr>';
            }

        }


        $str .= "<tr>".$headOne."</tr>";
        $str .= "<tr>".$headTwo."</tr>";
        $str .= $body;

        $str .= "</table></body></html>";

        // 处理导出结束..............................

        $filename = "经营概况导出-".$date_time."-".$itemType."-".$date_type.".xls";
        header( "Content-Type: application/vnd.ms-excel; name='excel'" );
        header( "Content-type: application/octet-stream" );
        header( "Content-Disposition: attachment; filename=".$filename );
        header( "Cache-Control: must-revalidate, post-check=0, pre-check=0" );
        header( "Pragma: no-cache" );
        header( "Expires: 0" );
        header("Content-Type:application/force-download");
        header("Content-Type:application/download");
        header("Content-Transfer-Encoding:binary");
        exit( $str );
    }

    /**
     * 某个用户的商品排行数据, 按照订单
     * @return string
     */
    public function actionTopn()
    {
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

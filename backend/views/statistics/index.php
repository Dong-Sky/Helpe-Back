<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 2018/8/12
 * Time: 17:41
 */

$this->title = '经营概况';

use yii\widgets\LinkPager;
?>

<div class="row">
    <div class="col-xs-12">
        <p id="me-table-buttons">
            <button class="btn btn-white btn-success btn-bold" id="show-table-refresh">
                <i class="ace-icon fa  fa-refresh"></i>刷新
            </button>
            <button class="btn btn-white btn-warning btn-bold" id="show-table-export">
                <i class="ace-icon glyphicon glyphicon-export"></i>导出
            </button>
        </p>

        <div id="show-table_wrapper" class="dataTables_wrapper form-inline no-footer">
            <div class="row">
                <div class="col-xs-2">
                </div>
                <div class="col-xs-10">
                    <div id="show-table_filter" class="dataTables_filter">
                        <form id="search-form" method="get" action="/statistics/index">
                            <label>选择时间: <input type="text" name="date_time" title="选择时间" value="<?=$date_time ?>" id="search-date_time"></label>
                            <label for="search-date_type"> 时间类型:
                                <select type="select" name="date_type" title="时间类型" id="search-date_type">
                                    <option value="1" <?php if($date_type == 1) {echo 'selected="selected"';} ?>>天</option>
                                    <option value="2" <?php if($date_type == 2) {echo 'selected="selected"';} ?>>周</option>
                                    <option value="3" <?php if($date_type == 3) {echo 'selected="selected"';} ?>>月</option>
                                </select>
                            </label>
                            <label for="search-item_type"> 商品类型:
                                <select type="select" name="item_type" atitle="商品类型" id="search-item_type">
                                    <option value="1" <?php if($data_type == 1) {echo 'selected="selected"';} ?>>综合</option>
                                    <option value="2" <?php if($data_type == 2) {echo 'selected="selected"';} ?>>服务</option>
                                    <option value="3" <?php if($data_type == 3) {echo 'selected="selected"';} ?>>求助</option>
                                </select>
                            </label>
                            <label for="search-per-page"> 分页数量:
                                <select type="select" name="per-page" atitle="分页数量" id="search-per-page">
                                    <option value="10" <?php if($per_page == 10) {echo 'selected="selected"';} ?>>10</option>
                                    <option value="20" <?php if($per_page == 20) {echo 'selected="selected"';} ?>>20</option>
                                    <option value="50" <?php if($per_page == 50) {echo 'selected="selected"';} ?>>50</option>
                                    <option value="100" <?php if($per_page == 100) {echo 'selected="selected"';} ?>>100</option>
                                </select>
                            </label>
                            <input type="hidden" name="is_export" title="导出" value="false" id="search-is_export">
                        </form>
                    </div>
                </div>
            </div>
            <table id="show-table" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="show-table_info">
                <thead>

                <?php

                $body = "";
                $headOne = '<th class="sorting_disabled" colspan="2" align="center" style="text-align: center;">商品</th>';
                $headTwo = '<th class="sorting_disabled" align="center" style="text-align: center;">ID</th><th class="sorting_disabled" align="center" style="text-align: center;">名称</th>';

                // 解析结果分为处理头，和数据内容2部分
                // 按照天解析数据
                if($date_type == 1) {
                    // 解析表头1
                    // 解析表头2

                    for($i = $retData['day']['startTime']; $i < $retData['day']['endTime']; $i = $i + 24 * 3600) {
                        $headOne .= '<th class="sorting_disabled" colspan="2" align="center" style="text-align: center;">'.date('Y-m-d', $i).'(天)</th>';
                        $headTwo .= '<th class="sorting_disabled" align="center" style="text-align: center;">销量</th><th class="sorting_disabled" align="center" style="text-align: center;">销售额</th>';
                    }

                    if (isset($retData['day']['current']) && !empty($retData['day']['current'])) {
                        // 解析报表内容
                        foreach($retData['day']['current'] as $idates => $iv) {
                            foreach($iv as $itemId => $iArr) {
                                $body .= "<tr>";
                                $body .= '<td class="sorting_disabled" align="center" style="text-align: center;">'.$itemId.'</td><td class="sorting_disabled" align="center" style="text-align: center;">'.$iArr['item_name'].'</td>';
                                for($i = $retData['day']['startTime']; $i < $retData['day']['endTime']; $i = $i + 24 * 3600) {
                                    $curDateTime = date('Y-m-d', $i);
                                    if($curDateTime == $date_time) {
                                        $itemCount = empty($retData['day']['current'][$curDateTime][$itemId]['item_count']) ? 0 : $retData['day']['current'][$curDateTime][$itemId]['item_count'];
                                        $itemAmount = empty($retData['day']['current'][$curDateTime][$itemId]['item_amount']) ? 0 : $retData['day']['current'][$curDateTime][$itemId]['item_amount'];
                                    } else {
                                        $itemCount = empty($retData['day']['old'][$curDateTime][$itemId]['item_count']) ? 0 : $retData['day']['old'][$curDateTime][$itemId]['item_count'];
                                        $itemAmount = empty($retData['day']['old'][$curDateTime][$itemId]['item_amount']) ? 0 : $retData['day']['old'][$curDateTime][$itemId]['item_amount'];
                                    }
                                    $body .= '<td class="sorting_disabled" align="center" style="text-align: center;">'.$itemCount.'</td><td class="sorting_disabled" align="center" style="text-align: center;">'.$itemAmount.'</td>';
                                }
                                $body .= "</tr>";
                            }
                        }
                    } else {
                        $body .= '<tr><td class="sorting_disabled" align="center" colspan="16" style="text-align: center;">没有找到记录</td></tr>';
                    }



                } else if ($date_type == 2) {   // 按照周解析数据

                    // 按照周的话，是返回4周的数据
                    // 解析表头1
                    // 解析表头2

                    for($i = $retData['week']['startTime']; $i < $retData['week']['endTime']; $i = $i + 7 * 24 * 3600) {
                        $headOne .= '<th class="sorting_disabled" colspan="2" align="center" style="text-align: center;">'.date('o-W', $i).'(周)</th>';
                        $headTwo .= '<th class="sorting_disabled" align="center" style="text-align: center;">销量</th><th class="sorting_disabled" align="center" style="text-align: center;">销售额</th>';
                    }


                    if (isset($retData['week']['current']) && !empty($retData['week']['current'])) {
                        // 解析报表内容
                        foreach($retData['week']['current'] as $idates => $iv) {
                            foreach($iv as $itemId => $iArr) {
                                $body .= "<tr>";
                                $body .= '<td class="sorting_disabled" align="center" style="text-align: center;">'.$itemId.'</td><td class="sorting_disabled" align="center" style="text-align: center;">'.$iArr['item_name'].'</td>';
                                for($i = $retData['week']['startTime']; $i < $retData['week']['endTime']; $i = $i + 7 * 24 * 3600) {
                                    $curDateTime = date('oW', $i);
                                    if($curDateTime == date('oW', strtotime($date_time))) {
                                        $itemCount = empty($retData['week']['current'][$curDateTime][$itemId]['item_count']) ? 0 : $retData['week']['current'][$curDateTime][$itemId]['item_count'];
                                        $itemAmount = empty($retData['week']['current'][$curDateTime][$itemId]['item_amount']) ? 0 : $retData['week']['current'][$curDateTime][$itemId]['item_amount'];
                                    } else {
                                        $itemCount = empty($retData['week']['old'][$curDateTime][$itemId]['item_count']) ? 0 : $retData['week']['old'][$curDateTime][$itemId]['item_count'];
                                        $itemAmount = empty($retData['week']['old'][$curDateTime][$itemId]['item_amount']) ? 0 : $retData['week']['old'][$curDateTime][$itemId]['item_amount'];
                                    }
                                    $body .= '<td class="sorting_disabled" align="center" style="text-align: center;">'.$itemCount.'</td><td class="sorting_disabled" align="center" style="text-align: center;">'.$itemAmount.'</td>';
                                }
                                $body .= "</tr>";
                            }
                        }
                    } else {
                        $body .= '<tr><td class="sorting_disabled" align="center" colspan="10" style="text-align: center;">没有找到记录</td></tr>';
                    }

                } else if ($date_type == 3) {   // 按照月解析数据

                    // 按照月返回的话，是返回3个的数据
                    // 解析表头1
                    // 解析表头2

                    for($i = $retData['month']['startTime']; $i < $retData['month']['endTime']; $i = $i + 32 * 24 * 3600) {
                        $headOne .= '<th class="sorting_disabled" colspan="2" align="center" style="text-align: center;">'.date('Y-m', $i).'(月)</th>';
                        $headTwo .= '<th class="sorting_disabled" align="center" style="text-align: center;">销量</th><th class="sorting_disabled" align="center" style="text-align: center;">销售额</th>';
                        $i = strtotime(date('Y-m-01', $i));
                    }


                    if (isset($retData['month']['current']) && !empty($retData['month']['current'])) {
                        // 解析报表内容
                        foreach($retData['month']['current'] as $idates => $iv) {
                            foreach($iv as $itemId => $iArr) {
                                $body .= "<tr>";
                                $body .= '<td class="sorting_disabled" align="center" style="text-align: center;">'.$itemId.'</td><td class="sorting_disabled" align="center" style="text-align: center;">'.$iArr['item_name'].'</td>';
                                for($i = $retData['month']['startTime']; $i < $retData['month']['endTime']; $i = $i + 32 * 24 * 3600) {
                                    $curDateTime = date('Ym', $i);
                                    if($curDateTime == date('Ym', strtotime($date_time))) {
                                        $itemCount = empty($retData['month']['current'][$curDateTime][$itemId]['item_count']) ? 0 : $retData['month']['current'][$curDateTime][$itemId]['item_count'];
                                        $itemAmount = empty($retData['month']['current'][$curDateTime][$itemId]['item_amount']) ? 0 : $retData['month']['current'][$curDateTime][$itemId]['item_amount'];
                                    } else {
                                        $itemCount = empty($retData['month']['old'][$curDateTime][$itemId]['item_count']) ? 0 : $retData['month']['old'][$curDateTime][$itemId]['item_count'];
                                        $itemAmount = empty($retData['month']['old'][$curDateTime][$itemId]['item_amount']) ? 0 : $retData['month']['old'][$curDateTime][$itemId]['item_amount'];
                                    }
                                    $body .= '<td class="sorting_disabled" align="center" style="text-align: center;">'.$itemCount.'</td><td class="sorting_disabled" align="center" style="text-align: center;">'.$itemAmount.'</td>';
                                    $i = strtotime(date('Y-m-01', $i));
                                }
                                $body .= "</tr>";
                            }
                        }
                    } else {
                        $body .= '<tr><td class="sorting_disabled" align="center" colspan="10" style="text-align: center;">没有找到记录</td></tr>';
                    }

                }
                ?>


                <tr role="row">
                    <?=$headOne ?>
                </tr>
                <tr role="row">
                    <?=$headTwo ?>
                </tr>
                </thead>
                <tbody>
                    <?=$body ?>
                </tbody>
            </table>

            <!-- 处理分页 -->
            <div class="row">
                <div class="col-xs-6">
                    <div class="dataTables_info" id="show-table_info" role="status" aria-live="polite">
                        显示 <?=$pagination->offset ?> 到 <?=($pagination->offset + $pagination->pageSize) ?> 共有 <?=$pagination->totalCount ?> 条数据
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="dataTables_paginate paging_full_numbers" id="show-table_paginate">
                        <?php
                        echo LinkPager::widget([
                            'pagination' => $pagination,
                            'nextPageLabel' => '下一页',
                            'prevPageLabel' => '上一页',
                            'firstPageLabel' => '首页',
                            'lastPageLabel' => '尾页',
                        ]);
                        ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!--    --><?php //var_dump('<pre>', $retData); ?>
</div>

<script type="text/javascript">
    window.jQuery || document.write("<script src='/public/assets/js/jquery.min.js'>"+"<"+"/script>");
</script>
<script src="/public/assets/js/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript">

    $(document).ready(function() {
        $("#search-date_time").blur(function() {
            $("#search-is_export").val("false");
            $("#search-form").submit();
        });

        $("#search-date_type").change(function() {
            $("#search-is_export").val("false");
            $("#search-form").submit();
        });

        $("#search-item_type").change(function() {
            $("#search-is_export").val("false");
            $("#search-form").submit();
        });

        $("#search-per-page").change(function() {
            $("#search-is_export").val("false");
            $("#search-form").submit();
        });

        $("#show-table-refresh").click(function() {
            $("#search-is_export").val("false");
            window.location.reload();
        });

        $("#show-table-export").click(function () {
            $("#search-is_export").val("true");
            $("#search-form").submit();
        });

        $("#search-date_time").datetimepicker({
            timepicker:false,
            format:'Y-m-d',
            formatDate:'Y-m-d'
        });
    })

</script>


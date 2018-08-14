<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 2018/8/12
 * Time: 17:41
 */

$this->title = '经营概况';
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
                            <label for="search-size"> 时间类型:
                                <select type="select" name="date_type" title="排名个数" id="search-date_type">
                                    <option value="1" <?php if($date_type == 1) {echo 'selected="selected"';} ?>>天</option>
                                    <option value="2" <?php if($date_type == 2) {echo 'selected="selected"';} ?>>周</option>
                                    <option value="3" <?php if($date_type == 3) {echo 'selected="selected"';} ?>>月</option>
                                </select>
                            </label>
                            <label for="search-size"> 商品类型:
                                <select type="select" name="data_type" atitle="商品类型" id="search-data_type">
                                    <option value="1" <?php if($data_type == 1) {echo 'selected="selected"';} ?>>全部</option>
                                    <option value="2" <?php if($data_type == 2) {echo 'selected="selected"';} ?>>服务</option>
                                    <option value="3" <?php if($data_type == 3) {echo 'selected="selected"';} ?>>求助</option>
                                </select>
                            </label>
                        </form>
                    </div>
                </div>
            </div>
            <table id="show-table" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="show-table_info">
                <thead>
                <tr role="row">
                    <th class="sorting_disabled" rowspan="1" colspan="5" aria-label="商品销售" align="center" style="text-align: center; border-right: solid 2px #00dd1c;">商品销售排行</th>
                    <th class="sorting_disabled" rowspan="1" colspan="4" aria-label="商品关注排行" align="center" style="text-align: center;">商品关注排行</th>
                </tr>
                </thead>
                <tbody>
                <tr role="row" class="odd">
                    <td>排名</td>
                    <td>商品编号</td>
                    <td>商品名称</td>
                    <td>销量</td>
                    <td style="border-right: solid 2px #00dd1c;">销售额</td>
                    <td>排名</td>
                    <td>商品编号</td>
                    <td>商品名称</td>
                    <td>关注数量</td>
                </tr>
                <?php
                if ($uid > 0 && (count($retData['top']) > 0 || count($retData['fav']) > 0)) {
                    for($i = 0; $i < $size; $i ++) {
                        if (isset($retData['top'][$i]) || isset($retData['fav'][$i])) {
                            echo '<tr role="row" class="', $i % 2 == 0 ? 'even' : 'odd', '"> ';
                            echo '<td>', ($i + 1), '</td> ';
                            echo '<td>', $retData['top'][$i]['itemid'], '</td> ';
                            echo '<td>', $retData['top'][$i]['item_name'], '</td> ';
                            echo '<td>', $retData['top'][$i]['item_count'], '</td> ';
                            echo '<td style="border-right: solid 2px #00dd1c;">', $retData['top'][$i]['item_amount'], '</td> ';
                            echo '<td>', ($i + 1), '</td> ';
                            echo '<td>', $retData['fav'][$i]['itemid'], '</td> ';
                            echo '<td>', $retData['fav'][$i]['item_name'], '</td> ';
                            echo '<td>', $retData['fav'][$i]['fav_top'], '</td> ';
                            echo '</tr>';
                        } else {
                            break;
                        }
                    }
                } else {
                    echo '<tr role="row" class="even"><td colspan="9" style="text-align: center;">没有找到记录</td></tr>';
                }


                ?>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript">
    window.jQuery || document.write("<script src='/public/assets/js/jquery.min.js'>"+"<"+"/script>");
</script>
<script src="/public/assets/js/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript">

    $(document).ready(function() {
        $("#search-date_time").blur(function() {
            $("#search-form").submit();
        });

        $("#search-date_type").change(function() {
            $("#search-form").submit();
        });

        $("#search-data_type").change(function() {
            $("#search-form").submit();
        });

        $("#show-table-refresh").click(function() {
            window.location.reload();
        });

        $("#search-date_time").datetimepicker({
            timepicker:false,
            format:'Y-m-d',
            formatDate:'Y-m-d'
        });
    })

</script>


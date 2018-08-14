<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 2018/8/12
 * Time: 17:41
 */

$this->title = '服务求助排行';
?>

<div class="row">
    <div class="col-xs-12">
        <p id="me-table-buttons">
            <button class="btn btn-white btn-success btn-bold" id="show-table-refresh">
                <i class="ace-icon fa  fa-refresh"></i>刷新
            </button>
        </p>

        <div id="show-table_wrapper" class="dataTables_wrapper form-inline no-footer">
            <div class="row">
                <div class="col-xs-2">
                </div>
                <div class="col-xs-10">
                    <div id="show-table_filter" class="dataTables_filter">
                        <form id="search-form" method="get" action="/statistics/topn">
                            <label>用户ID: <input type="text" name="uid" title="用户ID" value="<?php if($uid > 0) {echo $uid;} ?>" id="search-uid"></label>
                            <label for="search-size"> 排名个数:
                                <select type="select" name="size" title="排名个数" id="search-size">
                                    <option value="20" <?php if($size == 20) {echo 'selected="selected"';} ?>>20</option>
                                    <option value="40" <?php if($size == 40) {echo 'selected="selected"';} ?>>40</option>
                                    <option value="60" <?php if($size == 60) {echo 'selected="selected"';} ?>>60</option>
                                    <option value="80" <?php if($size == 80) {echo 'selected="selected"';} ?>>80</option>
                                    <option value="100" <?php if($size == 100) {echo 'selected="selected"';} ?>>100</option>
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
<script type="text/javascript">

    $(document).ready(function() {
        $("#search-uid").blur(function() {
            $("#search-form").submit();
        });

        $("#search-size").change(function() {
            $("#search-form").submit();
        });

        $("#show-table-refresh").click(function() {
            window.location.reload();
        })
    })

</script>


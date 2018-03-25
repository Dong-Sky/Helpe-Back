<?php
/**
 * Created by IntelliJ IDEA.
 * User: Jake
 * Date: 11/03/2018
 * Time: 00:02
 */

namespace api\modules\v1\controllers;

use api\controllers\ApiException;
use api\modules\v1\models\Report;
use api\controllers\BaseActiveController;
use api\models\ApiResponse;


class ReportController extends BaseActiveController {

    /**
     * 根据类型提交举报功能
     * @return ApiResponse
     * @throws ApiException
     */
    public function actionAdd() {
        $report = new Report();
        if($report->load($this->get, '') && $report->validate()) {
            $report->user_id = $this->userId;
            $report->save();
        } else {
            throw new ApiException(9998);
        }
        return new ApiResponse(0, []);
    }

}
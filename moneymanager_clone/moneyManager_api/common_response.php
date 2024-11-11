<?php
trait CommonResponce
{
    public function sendResponse($statusCode, $status, $message, $data = null)
    {
        http_response_code($statusCode);
        echo json_encode([
            'statusCode' => $statusCode,
            'status' => $status,
            'message' => $message,
            'data' => $data
        ]);
    }
}

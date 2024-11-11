<?php
include_once 'dbconnection.php';
include_once 'common_response.php';

class FetchRecords
{
    use CommonResponce;

    private $conn;

    public function __construct($db)
    {
        $this->conn = $db->conn;

        if ($this->conn->connect_error) {
            $this->sendResponse(500, false, "Connection failed: " . $this->conn->connect_error);
            die("Connection failed: " . $this->conn->connect_error);
        }
    }

    public function getRecords($token)
    {
        $token = $this->conn->real_escape_string($token);

        $stmt = $this->conn->prepare("SELECT user_id FROM tokens WHERE token = ?");
        if (!$stmt) {
            $this->sendResponse(500, false, "Failed to prepare statement: " . $this->conn->error);
            return;
        }

        $stmt->bind_param("s", $token);
        $stmt->execute();
        $stmt->store_result();

        if ($stmt->num_rows > 0) {
            $stmt->bind_result($user_id);
            $stmt->fetch();
            $stmt->close();

            $stmt = $this->conn->prepare("SELECT * FROM income_expens_table WHERE user_id = ?");
            if (!$stmt) {
                $this->sendResponse(500, false, "Failed to prepare statement: " . $this->conn->error);
                return;
            }

            $stmt->bind_param("i", $user_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $records = [];
            while ($row = $result->fetch_assoc()) {
                $records[] = $row;
            }
            $this->sendResponse(200, true, "Records fetched successfully", ['records' => $records]);
        } else {
            $this->sendResponse(401, false, "Invalid token");
        }

        $stmt->close();
    }
}

$headers = apache_request_headers();
$authHeader = '';

foreach ($headers as $key => $value) {
    if (strcasecmp($key, 'Authorization') == 0) {
        $authHeader = $value;
        break;
    }
}

error_log("Authorization Header: " . $authHeader);

if (preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
    $token = $matches[1];
    error_log("Extracted Token: " . $token);
    $db = new DBConnection();
    $fetchRecords = new FetchRecords($db);
    $fetchRecords->getRecords($token);
} else {
    error_log("No token provided in the Authorization header");
    $db = new DBConnection();

    $fetchRecords = new FetchRecords($db);
    $fetchRecords->sendResponse(400, false, 'No token provided');
}

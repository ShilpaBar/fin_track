<?php
include_once 'dbconnection.php';
include_once 'common_response.php';

class InsertRecord
{
    use CommonResponce;

    private $conn;

    public function __construct($db)
    {
        $this->conn = $db->conn;
        if ($this->conn->connect_error) {
            $this->sendResponse(500, false, "Connection failed: " . $this->conn->connect_error);
            exit;
        }
    }

    public function insertRecord($token, $category, $date, $time, $amount, $type, $title, $note)
    {
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

            $stmt = $this->conn->prepare("INSERT INTO income_expens_table (category, date, time, amount, type, title, note, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            if (!$stmt) {
                $this->sendResponse(500, false, "Failed to prepare insert statement: " . $this->conn->error);
                return;
            }

            $stmt->bind_param("sssssssi", $category, $date, $time, $amount, $type, $title, $note, $user_id);
            if ($stmt->execute()) {
                $this->sendResponse(200, true, "Record inserted successfully");
            } else {
                $this->sendResponse(500, false, "Failed to insert record");
            }
            $stmt->close();
        } else {
            $this->sendResponse(401, false, "Invalid token");
        }
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

if (preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
    $token = $matches[1];

    // Decode JSON input
    $input = json_decode(file_get_contents('php://input'), true);

    // Check if required JSON fields are set
    if (isset($input['category'], $input['date'], $input['time'], $input['amount'], $input['type'], $input['title'], $input['note'])) {
        $db = new DBConnection();
        $insertRecord = new InsertRecord($db);
        $insertRecord->insertRecord(
            $token,
            $input['category'],
            $input['date'],
            $input['time'],
            $input['amount'],
            $input['type'],
            $input['title'],
            $input['note']
        );
    } else {
        $insertRecord = new InsertRecord(new DBConnection());
        $insertRecord->sendResponse(400, false, "Missing required fields in JSON input");
    }
} else {
    $insertRecord = new InsertRecord(new DBConnection());
    $insertRecord->sendResponse(400, false, "No Token Provided");
}

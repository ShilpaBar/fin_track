<?php
include_once 'dbconnection.php';
include_once 'common_response.php';

class UserAuth
{
    use CommonResponce;

    private $conn;

    public function __construct($dbConnection)
    {
        $this->conn = $dbConnection->conn;

        if ($this->conn->connect_error) {
            $this->sendResponse(500, false, "Connection failed: " . $this->conn->connect_error);
            die("Connection failed: " . $this->conn->connect_error);
        } else {
            error_log("Database connected successfully.");
        }
    }

    public function registerOrLogin($username, $password)
    {
        if (empty($username) || empty($password)) {
            $this->sendResponse(400, false, "Username or password cannot be empty");
            return;
        }

        error_log("Received request for user: $username");

        $stmt = $this->conn->prepare("SELECT id, password FROM users WHERE username = ?");
        if (!$stmt) {
            error_log("Failed to prepare statement: " . $this->conn->error);
            $this->sendResponse(500, false, "Failed to prepare statement: " . $this->conn->error);
            return;
        }

        $stmt->bind_param("s", $username);
        if (!$stmt->execute()) {
            error_log("Failed to execute statement: " . $stmt->error);
            $this->sendResponse(500, false, "Failed to execute statement: " . $stmt->error);
            $stmt->close();
            return;
        }

        $stmt->store_result();
        error_log("Number of rows found: " . $stmt->num_rows);

        if ($stmt->num_rows > 0) {

            $stmt->bind_result($user_id, $hashed_password);
            $stmt->fetch();
            if (password_verify($password, $hashed_password)) {
                $token = bin2hex(random_bytes(16));
                $stmt->close();

                $stmt = $this->conn->prepare("INSERT INTO tokens (token, user_id) VALUES (?, ?)");
                if (!$stmt) {
                    error_log("Failed to prepare token statement: " . $this->conn->error);
                    $this->sendResponse(500, false, "Failed to prepare statement: " . $this->conn->error);
                    return;
                }

                $stmt->bind_param("si", $token, $user_id);
                if (!$stmt->execute()) {
                    error_log("Failed to execute token statement: " . $stmt->error);
                    $this->sendResponse(500, false, "Failed to execute statement: " . $stmt->error);
                    $stmt->close();
                    return;
                }

                $this->sendResponse(200, true, "Login successful, token generated", ['token' => $token]);
            } else {
                $stmt->close();
                $this->sendResponse(401, false, "Invalid credentials");
            }
        } else {
            $hashed_password = password_hash($password, PASSWORD_BCRYPT);
            $stmt->close();

            $stmt = $this->conn->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
            if (!$stmt) {
                error_log("Failed to prepare user registration statement: " . $this->conn->error);
                $this->sendResponse(500, false, "Failed to prepare statement: " . $this->conn->error);
                return;
            }

            $stmt->bind_param("ss", $username, $hashed_password);
            if (!$stmt->execute()) {
                error_log("Failed to execute user registration statement: " . $stmt->error);
                $this->sendResponse(500, false, "Failed to execute statement: " . $stmt->error);
                $stmt->close();
                return;
            }

            $user_id = $stmt->insert_id; // Get the user ID of the newly created user
            $stmt->close();

            $token = bin2hex(random_bytes(16));
            $stmt = $this->conn->prepare("INSERT INTO tokens (token, user_id) VALUES (?, ?)");
            if (!$stmt) {
                error_log("Failed to prepare token statement: " . $this->conn->error);
                $this->sendResponse(500, false, "Failed to prepare statement: " . $this->conn->error);
                return;
            }

            $stmt->bind_param("si", $token, $user_id);
            if (!$stmt->execute()) {
                error_log("Failed to execute token statement: " . $stmt->error);
                $this->sendResponse(500, false, "Failed to execute statement: " . $stmt->error);
                $stmt->close();
                return;
            }

            $this->sendResponse(200, true, "User registered and token generated successfully", ['token' => $token]);
        }

        $stmt->close();
        error_log("Finished processing request for user: $username");
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    if (isset($input['username']) && isset($input['password'])) {
        $username = $input['username'];
        $password = $input['password'];

        $db = new DBConnection();
        $userAuth = new UserAuth($db);
        $userAuth->registerOrLogin($username, $password);
    } else {
        $db = new DBConnection();
        $userAuth = new UserAuth($db);
        $userAuth->sendResponse(400, false, 'Invalid request');
    }
} else {
    $db = new DBConnection();
    $userAuth = new UserAuth($db);
    $userAuth->sendResponse(400, false, 'Invalid request method');
}

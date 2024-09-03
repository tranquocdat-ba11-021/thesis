<?php 
session_start(); // Khởi động session

require('connection.php'); // Kết nối cơ sở dữ liệu

// Kiểm tra xem người dùng đã đăng nhập chưa
if (!isset($_SESSION['user_logged_in'])) {
    header('Location: login.php');
    exit;
}

// Kiểm tra xem ID thú cưng có tồn tại không
if (!isset($_GET['id'])) {
    header('Location: inforpets.php');
    exit;
}

$pet_id = $_GET['id'];
$user_id = $_SESSION['user_id'];

// Chuẩn bị và thực thi truy vấn xóa dữ liệu
$sql_delete = "DELETE FROM user_pets WHERE id = ? AND user_id = ?";
$stmt = $con->prepare($sql_delete);
$stmt->bind_param('ii', $pet_id, $user_id);

if ($stmt->execute()) {
    // Chuyển hướng đến trang thông tin thú cưng sau khi xóa thành công
    header('Location: inforpets.php');
    exit;
} else {
    echo "Error: " . $stmt->error;
}

$stmt->close();
?>



<!-- Ví dụ: Trong tệp login.php, sau khi người dùng đăng nhập thành công, hãy đảm bảo rằng bạn thiết lập 
$_SESSION['user_logged_in'] và $_SESSION['user_id']: -->

<!-- session_start();: Đảm bảo rằng phiên làm việc được khởi động trước khi kiểm tra bất kỳ biến phiên nào.
Kiểm tra đăng nhập: Kiểm tra xem người dùng có đăng nhập hay không bằng cách kiểm tra biến phiên user_logged_in. -->
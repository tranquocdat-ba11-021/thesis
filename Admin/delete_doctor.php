<?php
// Import connection.php để kết nối cơ sở dữ liệu
require('../connection.php');

// Kiểm tra xem có dữ liệu id của bác sĩ được gửi từ form không
if(isset($_GET["id"])) {
    // Lấy id của bác sĩ từ URL
    $id = $_GET["id"];

    // Chuẩn bị câu truy vấn DELETE cho bảng doctor_services
    $deleteDoctorServicesQuery = "DELETE FROM `doctor_services` WHERE doctor_id = $id";

    // Thực thi câu truy vấn xóa các dịch vụ của bác sĩ
    if ($con->query($deleteDoctorServicesQuery) === TRUE) {
        // Xóa bác sĩ từ bảng doctor
        $deleteDoctorQuery = "DELETE FROM `doctor` WHERE id_doctor = $id";
        if ($con->query($deleteDoctorQuery) === TRUE) {
            // Cập nhật lại ID của các bản ghi còn lại
            $updateIdsQuery = "SET @new_id := 0; UPDATE `doctor` SET id_doctor = @new_id := @new_id + 1; ALTER TABLE `doctor` AUTO_INCREMENT = 1;";
            if ($con->multi_query($updateIdsQuery) === TRUE) {
                // Chuyển hướng người dùng đến trang danh sách bác sĩ
                header("location: doctor.php");
                exit;
            } else {
                // Nếu có lỗi khi cập nhật ID, hiển thị thông báo lỗi
                echo "Error updating IDs: " . $con->error;
            }
        } else {
            // Nếu có lỗi khi xóa bác sĩ, hiển thị thông báo lỗi
            echo "Error deleting doctor record: " . $con->error;
        }
    } else {
        // Nếu có lỗi khi xóa dịch vụ của bác sĩ, hiển thị thông báo lỗi
        echo "Error deleting doctor services: " . $con->error;
    }
} else {
    // Nếu không có id được gửi, chuyển hướng người dùng đến trang danh sách bác sĩ
    header("location: doctor.php");
    exit;
}

// Đóng kết nối cơ sở dữ liệu
$con->close();
?>

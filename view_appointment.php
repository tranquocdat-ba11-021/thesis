<?php
require('head.php');

// Đảm bảo người dùng đã đăng nhập
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit;
}

// Đảm bảo ID cuộc hẹn được cung cấp
if (!isset($_GET['id'])) {
    header('Location: appointment_history.php');
    exit;
}

$user_id = $_SESSION['user_id'];
$appointment_id = intval($_GET['id']);


// Lấy thông tin chi tiết cuộc hẹn bao gồm thông tin thanh toán và tên bác sĩ
$sql = "SELECT a.appointment_date, a.appointment_time, a.additional_info, a.doctor_id, s.name_service, s.type, p.pet_name, a.status, pay.payment_status
        FROM appointments a
        JOIN services s ON a.service = s.id_service
        JOIN user_pets p ON a.pet_id = p.id
        LEFT JOIN payments pay ON a.id = pay.appointment_id
        WHERE a.user_id = ? AND a.id = ?";

$stmt = $con->prepare($sql);
$stmt->bind_param("ii", $user_id, $appointment_id);
$stmt->execute();
$stmt->bind_result($appointment_date, $appointment_time, $additional_info,$doctor_id, $service_name,$type, $pet_name, $status, $payment_status);
$stmt->fetch();
$stmt->close();

if($doctor_id) {
$doctorSql  = "SELECT name_doctor FROM doctor WHERE id_doctor = ?";
$stmt = $con->prepare($doctorSql);
$stmt->bind_param("i", $doctor_id);
$stmt->execute();
$stmt->bind_result($name_doctor);
$stmt->fetch();
$stmt->close();
}
?>

<div class="main-content">
    <div class="container d-flex">
        <?php require('sidebar.php'); ?>

        <div class="content">
            <?php if ($type == 2) { ?>
                <h3>Service Scheduling Details</h3>
            <?php } else { ?>
                <h3>Details of Scheduling Medical Examination</h3>
                
            <?php } ?> 
           
            <div class="card mx-5" style="width: 100%; max-width: 800px;">
                <div class="card-body">
                    <p><strong>Day:</strong> <?php echo htmlspecialchars($appointment_date ?? ''); ?></p>
                    <p><strong>Time:</strong> <?php echo htmlspecialchars($appointment_time ?? ''); ?></p>
                    <p><strong>Service:</strong> <?php echo htmlspecialchars($service_name ?? ''); ?></p>
                    <p><strong>Pet:</strong> <?php echo htmlspecialchars($pet_name ?? ''); ?></p>
                    <p><strong>More information:</strong> <?php echo htmlspecialchars($additional_info ?? ''); ?></p>
                    <?php if($type == 1) { ?>
                    <p><strong>Docter:</strong> <?php echo htmlspecialchars($name_doctor ?? ''); ?></p>
                    <?php } ?>
                    <p><strong>Schedule status:</strong> <?php echo htmlspecialchars($status ?? ''); ?></p>
                    <p><strong>Payment status:</strong> <span id="payment-status"><?php echo htmlspecialchars($payment_status ?? ''); ?></span>
                    <?php if($type == 2) { ?>
                    <?php } ?>
                    </p>
                    <a href="appointment_history.php?type=<?php echo $type; ?>" class="btn d_btn btn-secondary">Back</a>
                </div>
            </div>
        </div>
    </div>
</div>


<?php require('footer.php'); ?>
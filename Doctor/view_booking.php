<?php
require('headdoctor.php');
ob_start();
?>

<body>
    <div class="wrapper">
        <?php require('navbardoctor.php'); ?>

        <div id="content2" class="container mt-4">
            <?php
            $appointment_id = intval($_GET['id']);

            // Fetch the booking details including payment information
            $sql = "SELECT a.id, u.full_name, u.email, u.phone, p.pet_name, s.name_service, a.appointment_date, a.appointment_start_time, a.appointment_end_time, a.additional_info
                FROM appointments a
                JOIN registered_users u ON a.user_id = u.id
                JOIN user_pets p ON a.pet_id = p.id
                JOIN services s ON a.service = s.id_service
                WHERE a.id = ?";
            $stmt = $con->prepare($sql);
            if ($stmt === false) {
                die("Error preparing statement: " . $con->error);
            }
            $stmt->bind_param('i', $appointment_id);
            $stmt->execute();
            $stmt->bind_result($id, $full_name, $email, $phone, $pet_name, $name_service, $appointment_date, $appointment_start_time, $appointment_end_time, $additional_info);
            $stmt->fetch();
            $stmt->close();

            ob_end_flush();
            ?>

            <h2>Booking Details</h2>
            <div class="row">
                <!-- Column 1 -->
                <div class="col-md-6 mb-3">
                    <h3>Customer Information</h3>
                    <p><strong>Full Name:</strong> <?php echo htmlspecialchars($full_name ?? ''); ?></p>
                    <p><strong>Email:</strong> <?php echo htmlspecialchars($email ?? ''); ?></p>
                    <p><strong>Phone:</strong> <?php echo htmlspecialchars($phone ?? ''); ?></p>
                    <p><strong>Pet Name:</strong> <?php echo htmlspecialchars($pet_name ?? ''); ?></p>
                    <p><strong>Additional Info:</strong> <?php echo htmlspecialchars($additional_info ?? ''); ?></p>
                </div>

                <!-- Column 2 -->
                <div class="col-md-6 mb-3">
                    <h3>Booking Details</h3>
                    <p><strong>Appointment Date:</strong> <?php echo htmlspecialchars($appointment_date ?? ''); ?></p>
                    <p><strong>Start Time:</strong> <?php echo htmlspecialchars($appointment_start_time ?? ''); ?></p>
                    <p><strong>End Time:</strong> <?php echo htmlspecialchars($appointment_end_time ?? ''); ?></p>
                    <p><strong>Service Name:</strong> <?php echo htmlspecialchars($name_service ?? ''); ?></p>
                </div>
            </div>

            <!-- Back Button -->
            <a href="history_appointments_doctor.php" class="btn btn-secondary mt-3">Back</a>
        </div>
    </div>

    <?php require('footerdoctor.php'); ?>
</body>
</html>

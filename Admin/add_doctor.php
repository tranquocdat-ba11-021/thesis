<?php
require('headadmin.php');
if (isset($_SESSION['role']) && $_SESSION['role'] == 2) {
    header('Location: restricted.php'); // Redirect to a restricted access page or a different page
    exit();
}
ob_start();
?>
<body>
<div class="wrapper">
<?php require('navbaradmin.php') ?>

<div id="content2">

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Phương thức POST: Thêm bác sĩ mới
    $username = $_POST["username"];
    $password = $_POST["password"];
    $name_doctor = $_POST["name"];
    $email_doctor = $_POST["email"];
    $phone_doctor = $_POST["phone"];
    $address_doctor = $_POST["address"];
    $intro_doctor = $_POST["intro"];
    $facebook_link = $_POST["facebook"];
    $instagram_link = $_POST["instagram"];
    $twitter_link = $_POST["twitter"];
    $services_doctor = isset($_POST["service"]) ? $_POST["service"] : null; // Updated to match the new field name

    if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK && $_FILES['image']['size'] > 0) {
        $fileTmpPath = $_FILES['image']['tmp_name'];
        $fileName = $_FILES['image']['name'];
        $fileExtension = pathinfo($fileName, PATHINFO_EXTENSION);
        $allowedfileExtensions = array('jpg', 'gif', 'png', 'jpeg');

        if (in_array($fileExtension, $allowedfileExtensions)) {
            $uploadFileDir = '../uploads/doctor/';
            $newFileName = time() . '_' . uniqid() . '.' . $fileExtension;
            $dest_path = $uploadFileDir . $newFileName;

            if (move_uploaded_file($fileTmpPath, $dest_path)) {
                $image_doctor = $newFileName;
            } else {
                $errorMessage = "There was an error moving the uploaded file.";
            }
        } else {
            $errorMessage = "Upload failed. Allowed file types: " . implode(',', $allowedfileExtensions);
        }
    }

    do {
        if (empty($username) || empty($name_doctor) || empty($email_doctor) || empty($phone_doctor) || empty($address_doctor)) {
            $errorMessage = "All the fields are required";
            break;
        }

        // Mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        // Thêm bác sĩ vào cơ sở dữ liệu
        $sql = "INSERT INTO `doctor` (username, password, name_doctor, email_doctor, phone_doctor, address_doctor, image_doctor, intro_doctor, facebook_link, instagram_link, twitter_link, services_doctor) 
                VALUES ('$username', '$hashed_password', '$name_doctor', '$email_doctor', '$phone_doctor', '$address_doctor', '$image_doctor', '$intro_doctor', '$facebook_link', '$instagram_link', '$twitter_link', '$services_doctor')";

        $result = $con->query($sql);

        if (!$result) {
            $errorMessage = "Invalid query: " . $con->error;
            break;
        }

        $successMessage = "Doctor added successfully";
        header("location: doctor.php");
        exit();
    } while (false);
}
ob_end_flush();
?>

            <h2>Add Doctor</h2>

            <?php
            if (!empty($errorMessage)) {
                echo "
            <div class='alert alert-warning alert-dismissible fade show' role='alert'>
                <strong>$errorMessage</strong>
                <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
            </div>
            ";
            }

            if (!empty($successMessage)) {
                echo "
            <div class='alert alert-success alert-dismissible fade show' role='alert'>
                <strong>$successMessage</strong>
                <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
            </div>
            ";
            }
            ?>

            <form method="POST" enctype="multipart/form-data">

                <!-- Username -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label"> Username </label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="username" value="<?php echo htmlspecialchars($username ?? '') ?>">
                    </div>
                </div>

                <!-- Password -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label"> Password </label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" name="password" placeholder="Enter new password">
                    </div>
                </div>

                <!-- Name -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label"> Name </label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="name" value="<?php echo htmlspecialchars($name_doctor ?? '') ?>">
                    </div>
                </div>
                <!-- Email -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label"> Email </label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="email" value="<?php echo htmlspecialchars($email_doctor ?? '') ?>">
                    </div>
                </div>
                <!-- Phone -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label"> Phone </label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="phone" value="<?php echo htmlspecialchars($phone_doctor ?? '') ?>">
                    </div>
                </div>
                <!-- Address -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label"> Address </label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="address" value="<?php echo htmlspecialchars($address_doctor ?? '') ?>">
                    </div>
                </div>
                <!-- Image -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label"> Image </label>
                    <div class="col-sm-6">
                        <input type="file" class="form-control" name="image">
                    </div>
                </div>
                <!-- Introduction -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label"> Introduction </label>
                    <div class="col-sm-6">
                        <textarea class="form-control" name="intro" rows="4"><?php echo htmlspecialchars($intro_doctor ?? '') ?></textarea>
                    </div>
                </div>
                <!-- Facebook -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label"> Facebook </label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="facebook" value="<?php echo htmlspecialchars($facebook_link ?? '') ?>">
                    </div>
                </div>
                <!-- Instagram -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label"> Instagram </label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="instagram" value="<?php echo htmlspecialchars($instagram_link ?? '') ?>">
                    </div>
                </div>
                <!-- Twitter -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label"> Twitter </label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="twitter" value="<?php echo htmlspecialchars($twitter_link ?? '') ?>">
                    </div>
                </div>
                <!-- Service -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label"> Service </label>
                    <div class="col-sm-6">
                        <?php
                        $sql = "SELECT * FROM `services` WHERE type = 1";
                        $result = $con->query($sql);
                        echo "<select class='form-select' name='service'>";
                        while ($service = $result->fetch_assoc()) {
                            $selected = ($services_doctor == $service['id_service']) ? 'selected' : '';
                            echo "<option value='{$service['id_service']}' $selected>{$service['name_service']}</option>";
                        }
                        echo "</select>";
                        ?>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-sm-6">
                        <button type="submit" class="btn btn-primary">Add Doctor</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

</body>
</html>

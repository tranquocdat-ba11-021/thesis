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
    // Khởi tạo biến lưu thông tin người dùng
    $user_id = $_GET['id']; // Lấy ID của người dùng cần sửa từ URL

    // Truy vấn cơ sở dữ liệu để lấy thông tin của người dùng cần chỉnh sửa
    $stmt = $con->prepare("SELECT * FROM `registered_users` WHERE id = ?");
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        die("User not found.");
    }

    // Lấy dữ liệu người dùng từ kết quả truy vấn
    $row = $result->fetch_assoc();
    $full_name = $row['full_name'];
    $email = $row['email'];
    $username = $row['username'];
    $phone = $row['phone'];
    $image_url = $row['image_url'];
    $role = $row['role']; // Thêm biến role

    // Biến thông báo lỗi và thành công
    $errorMessage = "";
    $successMessage = "";

    // Kiểm tra xem có dữ liệu được gửi từ form không
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Lấy các giá trị từ form
        $full_name = $_POST["full_name"];
        $email = $_POST["email"];
        $username = $_POST["username"];
        $phone = $_POST["phone"];
        $role = $_POST["role"]; // Lấy giá trị role từ form

        // Xử lý upload hình ảnh nếu có sự thay đổi
        if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
            // Lấy thông tin về file được upload
            $fileTmpPath = $_FILES['image']['tmp_name'];
            $fileName = $_FILES['image']['name'];
            $fileSize = $_FILES['image']['size'];
            $fileType = $_FILES['image']['type'];
            // Tách phần mở rộng của tên file
            $fileNameCmps = explode(".", $fileName);
            $fileExtension = strtolower(end($fileNameCmps));

            // Danh sách các phần mở rộng file được phép upload
            $allowedfileExtensions = array('jpg', 'gif', 'png', 'jpeg');
            // Kiểm tra xem phần mở rộng của file có trong danh sách được phép không
            if (in_array($fileExtension, $allowedfileExtensions)) {
                // Thư mục để lưu file đã upload
                $uploadFileDir = '../uploads/user/';
                // Tạo tên file mới để đảm bảo tính duy nhất
                $newFileName = time() . '_' . uniqid() . '.' . $fileExtension;
                // Đường dẫn đến file sau khi upload
                $dest_path = $uploadFileDir . $newFileName;

                // Di chuyển file vào thư mục upload
                if (move_uploaded_file($fileTmpPath, $dest_path)) {
                    $image_url = $newFileName;
                } else {
                    $errorMessage = "There was an error moving the uploaded file.";
                }
            } else {
                $errorMessage = "Upload failed. Allowed file types: " . implode(',', $allowedfileExtensions);
            }
        }

        // Kiểm tra các trường thông tin có bị bỏ trống không
        if (empty($full_name) || empty($email) || empty($username) || empty($phone) || empty($role)) {
            $errorMessage = "All fields are required";
        } else {
            // Cập nhật thông tin người dùng vào cơ sở dữ liệu
            $stmt_update = $con->prepare("UPDATE `registered_users` SET full_name = ?, email = ?, username = ?, phone = ?, image_url = ?, role = ? WHERE id = ?");
            $stmt_update->bind_param("ssssssi", $full_name, $email, $username, $phone, $image_url, $role, $user_id);
            $result_update = $stmt_update->execute();

            if (!$result_update) {
                $errorMessage = "Update failed: " . $con->error;
            } else {
                $successMessage = "User updated successfully";
                // Sau khi cập nhật thành công, chuyển hướng về trang danh sách người dùng
                header("Location: user.php");
                exit;
            }
        }
    }
    ob_end_flush();
    ?>

    <!-- Hiển thị thông báo lỗi nếu có -->
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

    <h2>Edit User</h2>
    <form method="POST" enctype="multipart/form-data">
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Full Name</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" name="full_name" value="<?php echo htmlspecialchars($full_name); ?>">
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Email</label>
            <div class="col-sm-6">
                <input type="email" class="form-control" name="email" value="<?php echo htmlspecialchars($email); ?>">
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Username</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" name="username" value="<?php echo htmlspecialchars($username); ?>">
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Phone</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" name="phone" value="<?php echo htmlspecialchars($phone); ?>">
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Role</label>
            <div class="col-sm-6">
                <select class="form-control" name="role">
                    <option value="1" <?php echo $role == 0 ? 'selected' : ''; ?>>Admin</option>
                    <option value="2" <?php echo $role == 1 ? 'selected' : ''; ?>>User</option>
                    <option value="3" <?php echo $role == 2 ? 'selected' : ''; ?>>Staff</option>
                </select>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Current Image</label>
            <div class="col-sm-6">
                <img src="../uploads/user/<?php echo htmlspecialchars($image_url); ?>" class="img-thumbnail" style="width: 100px; height: 100px;" alt="User Image">
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">New Image</label>
            <div class="col-sm-6">
                <input type="file" class="form-control" name="image">
            </div>
        </div>
        <div class="row mb-3">
            <div class="offset-sm-3 col-sm-3 d-grid">
                <button type="submit" class="btn btn-primary">Update</button>
            </div>
        </div>
    </form>
    </div>
</div>

<?php require('footeradmin.php') ?>

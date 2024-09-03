<?php require('headadmin.php');
if (isset($_SESSION['role']) && $_SESSION['role'] == 2) {
    header('Location: restricted.php'); // Redirect to a restricted access page or a different page
    exit();
} ?>

<body>
    <div class="wrapper">
        <?php require('navbaradmin.php') ?>

        <div id="content2">
            <h2>Manage Services</h2>
            <div class="row mb-3">
                <div class="col">
                    <a href="add_services.php" class="btn btn-primary mt-3">Add New Services</a>
                </div>
            </div>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Type</th>
                        <th>Description</th>
                        <th>Title Content</th> <!-- Thêm cột Title Content -->
                        <th>Image</th>
                        <th>Price</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    // Truy vấn SQL để lấy dữ liệu từ bảng 'services'
                    $sql = "SELECT * FROM `services`";
                    $stmt = $con->prepare($sql);
                    $stmt->execute();
                    $result = $stmt->get_result();

                    // Kiểm tra nếu có dữ liệu trả về
                    if ($result && $result->num_rows > 0) {
                        // Lặp qua các hàng kết quả và hiển thị dữ liệu trong bảng
                        while ($row = $result->fetch_assoc()) {
                            // Hiển thị tên loại dịch vụ dựa trên giá trị của 'type'
                            $type_name = ($row['type'] == 1) ? 'Khám bệnh' : 'Dịch vụ';
                            echo "
                            <tr>
                                <td>" . $row['id_service'] . "</td>
                                <td>" . $row['name_service'] . "</td>
                                <td>" . $type_name . "</td>
                                <td>" . $row['description'] . "</td>
                                <td>" . $row['title_content'] . "</td> <!-- Hiển thị Title Content -->
                                <td><img src='../uploads/Services/" . $row['image_url'] . "' alt='' width='100'></td>
                                <td>" . ($row['price'] ? $row['price'] : 'N/A') . "</td>
                                <td>
                                    <a href='edit_services.php?id=" . $row['id_service'] . "' class='btn btn-warning btn-sm'>Edit</a>
                                    <a href='delete_services.php?id=" . $row['id_service'] . "' class='btn btn-danger btn-sm'>Delete</a>
                                </td>
                            </tr>";
                        }
                    } else {
                        echo "<tr><td colspan='8'>No services found.</td></tr>"; // Cập nhật colspan để bao gồm cột Title Content
                    }

                    // Đóng kết nối đến cơ sở dữ liệu
                    $con->close();
                    ?>
                </tbody>
            </table>
        </div>
    </div>
    </div>

    <?php require('footeradmin.php') ?>
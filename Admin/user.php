<?php require('headadmin.php') ?>
<body>
<div class="wrapper">
<?php require('navbaradmin.php') ?>

<div id="content2">
    <h2>Manage Users</h2>
    <?php if (!isset($_SESSION['role']) || $_SESSION['role'] != 2) : ?>
    <div class="row mb-3">
                <div class="col">
                    <a href="add_user.php" class="btn btn-primary mt-3">Add User</a>
                </div>
            </div>
    <?php endif; ?>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Username</th>
                <th>Phone</th>
                <th>Image</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php
            // Truy vấn cơ sở dữ liệu từ bảng registered_users
            $sql = "SELECT * FROM `registered_users`";
            $result = $con->query($sql);

            if (!$result) {
                die("Invalid query: " . $con->error);
            }

            // Hiển thị dữ liệu cho từng dòng
            while ($row = $result->fetch_assoc()) {
                echo "
                    <tr>
                        <td>{$row['id']}</td>
                        <td>{$row['full_name']}</td>
                        <td>{$row['email']}</td>
                        <td>{$row['username']}</td>
                        <td>{$row['phone']}</td>
                        <td><img src='../uploads/user/{$row['image_url']}'  style='width: 50px; height: 50px;' alt='User Image'></td>
                        <td>";
                    if (!isset($_SESSION['role']) || $_SESSION['role'] != 2){
                    echo "<a class='btn btn-warning btn-sm' href='edit_user.php?id={$row['id']}'>Edit</a> ";
                    echo "<a class='btn btn-danger btn-sm' href='delete_user.php?id={$row['id']}'>Delete</a>";
                }

                echo "</td>
                    </tr>
                ";
            }
            ?>
        </tbody>
    </table>
</div>
</div>

<?php require('footeradmin.php') ?>
</body>

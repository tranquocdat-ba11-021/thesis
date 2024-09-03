<?php require('headadmin.php');
if (isset($_SESSION['role']) && $_SESSION['role'] == 2) {
    header('Location: restricted.php'); // Redirect to a restricted access page or a different page
    exit();
} ?>

<body>
    <div class="wrapper">
        <?php require('navbaradmin.php') ?>

        <div id="content2">
            <h2>Manage Doctors</h2>
            <div class="row mb-3">
                <div class="col">
                    <a href="add_doctor.php" class="btn btn-primary mt-3">Add New Doctor</a>
                </div>
            </div>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Image</th>
                        <th>Created At</th>
                        <th>Services</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    // Fetch all doctors with their service information
                    $sql = "SELECT d.*, GROUP_CONCAT(s.name_service SEPARATOR ', ') AS services
                            FROM doctor d
                            LEFT JOIN services s ON FIND_IN_SET(s.id_service, d.services_doctor)
                            GROUP BY d.id_doctor";
                    $result = $con->query($sql);

                    if (!$result) {
                        die("Invalid query: " . $con->error);
                    }

                    // Counter for row numbering
                    $counter = 1;

                    // Display each doctor
                    while ($row = $result->fetch_assoc()) {
                        $image_url = '../uploads/doctor/' . $row['image_doctor'];
                        echo "
                        <tr>
                            <td>{$counter}</td>
                            <td>{$row['id_doctor']}</td>
                            <td>{$row['name_doctor']}</td>
                            <td>{$row['email_doctor']}</td>
                            <td>{$row['phone_doctor']}</td>
                            <td><img src='{$image_url}' alt='Doctor Image' class='img-fluid' width='80'></td>
                            <td>{$row['created_at']}</td>
                            <td>{$row['services']}</td>
                            <td>
                                <a href='edit_doctor.php?id={$row['id_doctor']}' class='btn btn-warning btn-sm'>Edit</a>
                                <a href='delete_doctor.php?id={$row['id_doctor']}' class='btn btn-danger btn-sm'>Delete</a>
                            </td>
                        </tr>";
                        $counter++;
                    }
                    ?>
                </tbody>
            </table>
        </div>
    </div>
    </div>

    <?php require('footeradmin.php') ?>
</body>
</html>

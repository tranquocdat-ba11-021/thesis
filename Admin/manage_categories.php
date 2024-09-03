<?php require('headadmin.php');
if (isset($_SESSION['role']) && $_SESSION['role'] == 2) {
    header('Location: restricted.php'); // Redirect to a restricted access page or a different page
    exit();
} ?>

<body>
    <div class="wrapper">
        <?php require('navbaradmin.php') ?>

        <div id="content2">
            <h2>Manage Categories </h2>

            <!-- Add Category Link -->
            <a href="add_categories.php" class="btn btn-primary mb-3">Add Category</a>

            <!-- Category Table -->
            <h3>Categories</h3>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    // Fetch categories from the database
                    $categorySql = "SELECT * FROM categories";
                    $categoryResult = $con->query($categorySql);

                    if ($categoryResult->num_rows > 0) {
                        while ($category = $categoryResult->fetch_assoc()) {
                            echo "
                            <tr>
                                <td>{$category['id']}</td>
                                <td>{$category['name']}</td>
                                <td>
                                    <a href='delete_categories.php?id={$category['id']}' class='btn btn-danger btn-sm'>Delete</a>
                                </td>
                            </tr>
                            ";
                        }
                    } else {
                        echo "<tr><td colspan='3'>No categories found</td></tr>";
                    }
                    ?>
                </tbody>
            </table>
        </div>
    </div>
    </div>

    <?php require('footeradmin.php'); ?>
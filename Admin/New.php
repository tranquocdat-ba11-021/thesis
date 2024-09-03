<?php 
require('headadmin.php'); 

// Check if the user is logged in and has role = 2
if (isset($_SESSION['role']) && $_SESSION['role'] == 2) {
    header('Location: restricted.php'); // Redirect to a restricted access page or a different page
    exit();
}
?>

<body>
    <div class="wrapper">
        <?php require('navbaradmin.php'); ?>

        <div id="content2">
            <h2>Manage Posts</h2>
            <div class="row mb-3">
                <div class="col">
                    <a href="add_post.php" class="btn btn-primary mt-3">Add New Post</a>
                </div>
            </div>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Date</th>
                        <th>Image</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    // Number of posts per page
                    $posts_per_page = 5;

                    // Get current page number from URL, default to page 1 if not set
                    $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;

                    // Calculate the offset for the SQL query
                    $offset = ($page - 1) * $posts_per_page;

                    // Query total number of posts to calculate total pages
                    $total_posts_sql = "SELECT COUNT(*) FROM posts";
                    $total_posts_result = $con->query($total_posts_sql);
                    $total_posts = $total_posts_result->fetch_row()[0];
                    $total_pages = ceil($total_posts / $posts_per_page);

                    // Query to get posts for the current page
                    $sql = "SELECT * FROM posts ORDER BY date DESC LIMIT $posts_per_page OFFSET $offset";
                    $result = $con->query($sql);

                    // Check if there are results
                    if ($result && $result->num_rows > 0) {
                        // Loop through each result and display in table
                        while ($row = $result->fetch_assoc()) {
                            echo "
                            <tr>
                                <td>" . htmlspecialchars($row['id']) . "</td>
                                <td>" . htmlspecialchars($row['title']) . "</td>
                                <td>" . htmlspecialchars($row['date']) . "</td>
                                <td><img src='../uploads/New/" . htmlspecialchars($row['image_url']) . "' alt='Post Image' class='img-fluid' width='100'></td>
                                <td>
                                    <a href='edit_post.php?id=" . $row['id'] . "' class='btn btn-warning btn-sm'>Edit</a>
                                    <a href='delete_post.php?id=" . $row['id'] . "' class='btn btn-danger btn-sm'>Delete</a>
                                </td>
                            </tr>";
                        }
                    } else {
                        echo "<tr><td colspan='5'>No posts found.</td></tr>";
                    }

                    // Close the database connection
                    $con->close();
                    ?>
                </tbody>
            </table>

            <div class="blog-pagination">
                <ul class="pagination justify-content-center">
                    <?php if ($page > 1): ?>
                        <li class="page-item">
                            <a class="page-link" href="?page=<?= $page - 1 ?>" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    <?php endif; ?>
                    <?php for ($i = 1; $i <= $total_pages; $i++): ?>
                        <li class="page-item <?= $i == $page ? 'active' : '' ?>">
                            <a class="page-link" href="?page=<?= $i ?>"><?= $i ?></a>
                        </li>
                    <?php endfor; ?>
                    <?php if ($page < $total_pages): ?>
                        <li class="page-item">
                            <a class="page-link" href="?page=<?= $page + 1 ?>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    <?php endif; ?>
                </ul>
            </div>
        </div>
    </div>

    <?php require('footeradmin.php'); ?>
</body>

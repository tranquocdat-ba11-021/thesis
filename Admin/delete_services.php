<?php
require('../connection.php');

if (isset($_GET["id"])) {
    $id = $_GET["id"];

    // Prepare the statement to get the image URL from the database
    $getImageQuery = $con->prepare("SELECT image_url FROM `services` WHERE id_service = ?");
    $getImageQuery->bind_param("i", $id);
    $getImageQuery->execute();
    $getImageQuery->store_result();
    $getImageQuery->bind_result($image_url);
    $getImageQuery->fetch();

    if ($getImageQuery->num_rows > 0 && !empty($image_url)) {
        // Construct the image path
        $image_path = "../uploads/Services/" . $image_url;

        // Check if the image file exists and delete it
        if (file_exists($image_path)) {
            unlink($image_path);
        }
    }

    // Close the getImageQuery
    $getImageQuery->close();

    // Prepare the statement to delete services related to the service
    $deleteServicesQuery = $con->prepare("DELETE FROM `doctor_services` WHERE service_id = ?");
    $deleteServicesQuery->bind_param("i", $id);

    // Execute the delete query for services related to the service
    if ($deleteServicesQuery->execute()) {  
        // Prepare the statement to delete the service itself
        $deleteServiceQuery = $con->prepare("DELETE FROM `services` WHERE id_service = ?");
        $deleteServiceQuery->bind_param("i", $id);

        // Execute the delete query for the service
        if ($deleteServiceQuery->execute()) {
            header("location: manage_services.php");
            exit;
        } else {
            echo "Error deleting service record: " . $deleteServiceQuery->error;
        }
    } else {
        echo "Error deleting related services records: " . $deleteServicesQuery->error;
    }

    $deleteServicesQuery->close();
    $deleteServiceQuery->close();
} else {
    // If the service ID is not set, redirect to the manage services page
    header("location: manage_services.php");
    exit;
}
$con->close();
?>

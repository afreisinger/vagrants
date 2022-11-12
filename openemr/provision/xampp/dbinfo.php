<?php
$mysqli = new mysqli("localhost", "dev_user", "dev_password", "dev_db");

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

/* print server version */
printf("Server version: %s\n", $mysqli->server_info);

/* print host information */
printf("Host info: %s\n", $mysqli->host_info);

// prints e.g. 'Current PHP version: 4.1.1'
echo 'Current PHP version: ' . phpversion();

$mysqli->close();
?>
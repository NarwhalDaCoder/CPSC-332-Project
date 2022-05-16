<?php
    $host = 'localhost';
    $user = 'root';
    $password = '';
    $database = 'myjob';
    $link = new mysqli();
    $mysqli = new mysqli($host, $user, $password, $database);
    if (mysqli_connect_errno()) {
        exit('Connect failed: '. mysqli_connect_error());
    }
?>

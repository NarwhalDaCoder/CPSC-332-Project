<?php
// Prepare an insert statement
$sql1 = "INSERT INTO UserAccount (FirstName, LastName, Phone, Password) VALUES (?, ?,?,?)";
$sql2 = "INSERT INTO UserEmail (UserID, Email) VALUES (?, ?)";

if($stmt = mysqli_prepare($mysqli, $sql1)){
    // Bind variables to the prepared statement as parameters
    mysqli_stmt_bind_param($stmt, "ssss", $param_firstname, $param_lastname,$param_phonenumber,$param_password);

    // Set parameters
    $param_password = $password; // Creates a password hash
    $param_firstname = $firstname;
    $param_lastname = $lastname;
    $param_phonenumber = $phonenumber;
    // Attempt to execute the prepared statement
    if(mysqli_stmt_execute($stmt)){
        $userid = $mysqli->insert_id;
        // Redirect to login page
        //header("location: login.php");
    } else{
        echo "Oops! Something went wrong. Please try again later.";
    }

    // Close statement
    mysqli_stmt_close($stmt);
}
if($stmt = mysqli_prepare($mysqli, $sql2)){
    // Bind variables to the prepared statement as parameters
    mysqli_stmt_bind_param($stmt, "ss", $param_userid, $param_email);

    // Set parameters
    $param_userid = $userid; // Creates a password hash
    $param_email = $username;
    // Attempt to execute the prepared statement
    if(mysqli_stmt_execute($stmt)){

        // Redirect to login page
        //header("location: login.php");
    } else{
        echo "Oops! Something went wrong. Please try again later.";
    }

    // Close statement
    mysqli_stmt_close($stmt);
}
 ?>

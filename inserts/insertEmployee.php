<?php

        $sql = "INSERT INTO Employee (EmployeeID, EducationID) VALUES (?,?)";
        if($stmt = mysqli_prepare($mysqli, $sql)){
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt, "ss", $param_employeeid,$param_education);

            // Set parameters
            $param_employeeid= $userid; // Creates a password hash
            $param_education = $education; // Creates a password hash
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

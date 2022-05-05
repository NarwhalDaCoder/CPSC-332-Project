<?php

        // Prepare an insert statement

        $sql1 = "INSERT INTO Employer (EmployerID, EmployerName,EmployerPhone) VALUES (?,?,?)";
        $sql2 = "INSERT INTO EmployerEmail (EmployerID,Email) VALUES (?, ?)";
        $sql3 = "INSERT INTO RoleToEmployerUser (EmployerID, RoleID) VALUES (?,?)";

        if($stmt = mysqli_prepare($mysqli, $sql1)){
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt, "sss", $param_employerid, $param_employername,$param_employerphone);

            // Set parameters
            $param_employerid = $userid; // Creates a password hash
            $param_employername = $employername;
            $param_employerphone = $employerphonenumber;
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
        if($stmt = mysqli_prepare($mysqli, $sql2)){
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt, "ss", $param_employerid , $param_employeremail);

            // Set parameters
            $param_employerid = $userid; // Creates a password hash
            $param_employeremail = $employeremail;
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
        if($stmt = mysqli_prepare($mysqli, $sql3)){
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt, "ss", $param_employerid,$param_role);

            // Set parameters
            $param_employerid = $userid; // Creates a password hash
            $param_role = $role; // Creates a password hash
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

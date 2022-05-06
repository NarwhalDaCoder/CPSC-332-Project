<?php
        $zipExists = False;
        $sql1 = "INSERT INTO Address (StreetAddress) VALUES (?)";
        $sql2 = "SELECT ZipCode FROM ZipCodes WHERE ZipCode = ?";
        $sql3 = "INSERT INTO City(CityName) VALUES (?)";
        $sql4 = "INSERT INTO CityToState(CityID,StateID) VALUES (?,?)";
        $sql5 = "INSERT INTO ZipCodes (ZipCode,CityID) VALUES (?,?)";
        $sql6 = "INSERT INTO ZipCodeToAddress(AddressID,ZipCode) VALUES (?,?)";

        if($stmt = mysqli_prepare($mysqli, $sql1)){
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt, "s", $param_address);

            // Set parameters
            $param_address= $address; // Creates a password hash

            // Attempt to execute the prepared statement
            if(mysqli_stmt_execute($stmt)){
                $addressid = $mysqli->insert_id;
                // Redirect to login page
                //header("location: login.php");
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            // Close statement
            mysqli_stmt_close($stmt);
        }
        //sql 2 statement-check for zipcode
        if ($stmt = mysqli_prepare($mysqli, $sql2))
        {
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt, "s", $param_username);

            // Set parameters
            $param_username = trim($_POST["zipcode"]);

            // Attempt to execute the prepared statement
            if (mysqli_stmt_execute($stmt))
            {
                /* store result */
                mysqli_stmt_store_result($stmt);

                if (mysqli_stmt_num_rows($stmt) == 1)
                {
                    $zipExists = True;
                }
            }
            else
            {
                echo "Oops! Something went wrong. Please try again later.";
            }

            // Close statement
            mysqli_stmt_close($stmt);
        }
        if(!$zipExists){
          if($stmt = mysqli_prepare($mysqli, $sql3)){
              // Bind variables to the prepared statement as parameters
              mysqli_stmt_bind_param($stmt, "s", $param_city);

              // Set parameters
              $param_city= $city; // Creates a password hash
              // Attempt to execute the prepared statement
              if(mysqli_stmt_execute($stmt)){
                  $cityid = $mysqli->insert_id;
                  // Redirect to login page
                  //header("location: login.php");
              } else{
                  echo "Oops! Something went wrong. Please try again later.";
              }

              // Close statement
              mysqli_stmt_close($stmt);
          }
          if($stmt = mysqli_prepare($mysqli, $sql4)){
              // Bind variables to the prepared statement as parameters
              mysqli_stmt_bind_param($stmt, "ss", $param_cityid,$param_state);

              // Set parameters
              $param_state= $states; // Creates a password hash
              $param_cityid = $cityid;
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
          if($stmt = mysqli_prepare($mysqli, $sql5)){
              // Bind variables to the prepared statement as parameters
              mysqli_stmt_bind_param($stmt, "ss", $param_zipcode,$param_cityid);

              // Set parameters
              $param_zipcode= $zipcode; // Creates a password hash
              $param_cityid= $cityid; // Creates a password hash
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
        }
        if($stmt = mysqli_prepare($mysqli, $sql6)){
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt, "ss", $param_addressid,$param_zipcode);

            // Set parameters
            $param_addressid= $addressid; // Creates a password hash
            $param_zipcode = $zipcode; // Creates a password hash
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

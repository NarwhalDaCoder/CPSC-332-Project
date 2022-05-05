<?php
// Validate username
if (empty(trim($_POST["username"])))
{
    $username_err = "Please enter a email.";
}
elseif (!filter_var(trim($_POST["username"]) , FILTER_VALIDATE_EMAIL))
{
    $username_err = "Email can only contain letters, numbers, and underscores.";
}
else
{
    // Prepare a select statement
    $sql = "SELECT Email FROM UserEmail WHERE Email = ?";

    if ($stmt = mysqli_prepare($mysqli, $sql))
    {
        // Bind variables to the prepared statement as parameters
        mysqli_stmt_bind_param($stmt, "s", $param_username);

        // Set parameters
        $param_username = trim($_POST["username"]);

        // Attempt to execute the prepared statement
        if (mysqli_stmt_execute($stmt))
        {
            /* store result */
            mysqli_stmt_store_result($stmt);

            if (mysqli_stmt_num_rows($stmt) == 1)
            {
                $username_err = "This username is already taken.";
            }
            else
            {
                $username = trim($_POST["username"]);
            }
        }
        else
        {
            echo "Oops! Something went wrong. Please try again later.";
        }

        // Close statement
        mysqli_stmt_close($stmt);
    }
}

// Validate password
if (empty(trim($_POST["password"])))
{
    $password_err = "Please enter a password.";
}
elseif (strlen(trim($_POST["password"])) < 8)
{
    $password_err = "Password must have atleast 8 characters.";
}
elseif (!preg_match("#[0-9]+#", trim($_POST["password"])))
{
    $password_err = "Your Password Must Contain At Least 1 Number!";
}
elseif (!preg_match("#[A-Z]+#", trim($_POST["password"])))
{
    $password_err = "Your Password Must Contain At Least 1 Capital Letter!";
}
elseif (!preg_match("#[a-z]+#", trim($_POST["password"])))
{
    $password_err = "Your Password Must Contain At Least 1 Lowercase Letter!";
}
else
{
    $password = trim($_POST["password"]);
}

// Validate confirm password
if (empty(trim($_POST["confirm_password"])))
{
    $confirm_password_err = "Please confirm password.";
}
else
{
    $confirm_password = trim($_POST["confirm_password"]);
    if (empty($password_err) && ($password != $confirm_password))
    {
        $confirm_password_err = "Password did not match.";
    }
}

//validate phone
if (!preg_match("/^[0-9]{3}[0-9]{3}[0-9]{4}$/", trim($_POST["phonenumber"])))
{
    $phonenumber_err = "Please enter valid phonenumber of 10 digits.";
}
else
{
    $phonenumber = trim($_POST["phonenumber"]);
}

//validate names
if (!preg_match("/^([a-zA-Z' ]+)$/", trim($_POST["firstname"])))
{
    $firstname_err = "Please enter a valid first name.";
}
else
{
    $firstname = trim($_POST["firstname"]);
}
if (!preg_match("/^([a-zA-Z' ]+)$/", trim($_POST["lastname"])))
{
    $lastname_err = "Please enter a valid last name.";
}
else
{
    $lastname = trim($_POST["lastname"]);
}
//validate checkbox
if(!isset($_POST['employee']) && !isset($_POST['employer']) ) {
  $employ_err = "Please select at least one value";
}
else{
  isset($_POST['employee']) ? $employee = True:$employee = False;
  isset($_POST['employer']) ? $employer = True:$employer = False;
}
 ?>

<?php
// Validate username
if (empty(trim($_POST["employeremail"])))
{
    $employeremail_err = "Please enter a email.";
}
elseif (!filter_var(trim($_POST["employeremail"]) , FILTER_VALIDATE_EMAIL))
{
    $employeremail_err = "Email can only contain letters, numbers, and underscores.";
}
else
{
    // Prepare a select statement
    $sql = "SELECT Email FROM EmployerEmail WHERE Email = ?";

    if ($stmt = mysqli_prepare($mysqli, $sql))
    {
        // Bind variables to the prepared statement as parameters
        mysqli_stmt_bind_param($stmt, "s", $param_email);

        // Set parameters
        $param_email = trim($_POST["employeremail"]);

        // Attempt to execute the prepared statement
        if (mysqli_stmt_execute($stmt))
        {
            /* store result */
            mysqli_stmt_store_result($stmt);

            if (mysqli_stmt_num_rows($stmt) == 1)
            {
                $employeremail_err = "This email is already taken.";
            }
            else
            {
                $employeremail = trim($_POST["employeremail"]);
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
//validate phone
if (!preg_match("/^[0-9]{3}[0-9]{3}[0-9]{4}$/", trim($_POST["employerphonenumber"])))
{
    $employerphonenumber_err = "Please enter valid phonenumber of 10 digits.";
}
else
{
    $employerphonenumber = trim($_POST["employerphonenumber"]);
}
//validate name
if (!preg_match("/^([a-zA-Z' ]+)$/", trim($_POST["employername"])))
{
    $employername_err = "Please enter a valid first name.";
}
else
{
    $employername = trim($_POST["employername"]);
}
  //validate role
  if (!isset($_POST['role']) || $_POST['role'] == '0')
  {
    $role_err = "Please select a dropdown option";
  }
  else
  {
    $role = trim($_POST["role"]);
  }
  include 'validateAddress.php'

 ?>

<?php
// Include config file
require_once "config.php";

// Define variables and initialize with empty values
$username = $password = $confirm_password = $firstname = $lastname = $phonenumber = $education = $employee = $employer = $role = $employername = $employeremail = $employerphonenumber = $address = $city = $states = $zipcode = "";
$username_err = $password_err = $confirm_password_err = $firstname_err = $lastname_err = $phonenumber_err = $education_err = $employ_err = $role_err = $employername_err = $employeremail_err = $employerphonenumber_err = $address_err = $city_err = $states_err = $zipcode_err = "";

// Processing form data when form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST")
{

    include 'validation/validateUser.php';
    if ($employee)
    {
        //validate Employee
        if (!isset($_POST['education']) || $_POST['education'] == '0')
        {
            $education_err = "Please select a dropdown option";
        }
        else
        {
            $education = trim($_POST["education"]);
        }
    }
    //validate Employer in file
    if ($employer)
    {
        if(isset($_POST['includeaddress'])) {
          include 'validation/validateAddress.php';
        }

        include 'validation/validateEmployer.php';
    }

    // Check input errors before inserting in database
    if (empty($username_err) && empty($password_err) && empty($confirm_password_err) && empty($lastname_err) && empty($firstname_err) && empty($phonenumber_err) && ($employee || ($employer&& (!isset($_POST['includeaddress']) || (isset($_POST['includeaddress']) && empty ($address_err) ) )   )    ) )
    {
        include 'inserts/insertUser.php';
        if ($employee && empty($education_err))
        {
            include 'inserts/insertEmployee.php';
        }
        if ($employer && empty($role_err) && empty($employername_err) && empty($employeremail_err) && empty($employerphonenumber_err))
        {
            include 'inserts/insertEmployer.php';
            if (isset($_POST['includeaddress']))
            {
                include 'inserts/insertAddress.php';
                $sql = "INSERT INTO EmployerToAddress (EmployerID, AddressID) VALUES (?,?)";
                if ($stmt = mysqli_prepare($mysqli, $sql))
                {
                    // Bind variables to the prepared statement as parameters
                    mysqli_stmt_bind_param($stmt, "ss", $param_employerid, $param_addressid);

                    // Set parameters
                    $param_addressid = $addressid; // Creates a password hash
                    $param_employerid = $userid; // Creates a password hash
                    // Attempt to execute the prepared statement
                    if (mysqli_stmt_execute($stmt))
                    {
                        // Redirect to login page
                        //header("location: login.php");

                    }
                    else
                    {
                        echo "Oops! Something went wrong. Please try again later.";
                    }

                    // Close statement
                    mysqli_stmt_close($stmt);
                }
            }
        }

    }

    // Close connection
    mysqli_close($mysqli);
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <style>
        body{ font: 14px sans-serif; }
        .wrapper{ width: 360px; padding: 20px; }
    </style>
</head>
<body>
    <div class="wrapper">
        <h2>Sign Up</h2>
        <p>Please fill this form to create an account.</p>
        <div class="d-grid gap-3">

        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
          <div class="form-group">
              <label>First Name</label>
              <input type="text" name="firstname" class="form-control <?php echo (!empty($firstname_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $firstname; ?>">
              <span class="invalid-feedback"><?php echo $firstname_err; ?></span>
          </div>
          <div class="form-group">
              <label>Last Name</label>
              <input type="text" name="lastname" class="form-control <?php echo (!empty($lastname_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $lastname; ?>">
              <span class="invalid-feedback"><?php echo $lastname_err; ?></span>
          </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="username" class="form-control <?php echo (!empty($username_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $username; ?>">
                <span class="invalid-feedback"><?php echo $username_err; ?></span>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" class="form-control <?php echo (!empty($password_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $password; ?>">
                <span class="invalid-feedback"><?php echo $password_err; ?></span>
            </div>
            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirm_password" class="form-control <?php echo (!empty($confirm_password_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $confirm_password; ?>">
                <span class="invalid-feedback"><?php echo $confirm_password_err; ?></span>
            </div>
            <div class="form-group">
                <label>Phone Number</label>
                <input type="password" name="phonenumber" class="form-control <?php echo (!empty($phonenumber_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $phonenumber; ?>">
                <span class="invalid-feedback"><?php echo $phonenumber_err; ?></span>
            </div>
            <script type="text/javascript">
              function valueChanged() {
                if (document.getElementById('employee').checked) {
                  document.getElementById("displayemployee").style.display = 'block';
                } else {
                  document.getElementById("displayemployee").style.display = 'none';
                }
              }

            </script>
            <script type="text/javascript">
              function empChanged() {
                if (document.getElementById('employer').checked) {
                  document.getElementById("displayemployer").style.display = 'block';
                } else {
                  document.getElementById("displayemployer").style.display = 'none';
                }
              }

            </script>

            <div class="form-group">
                <label>Employee and/or Employer</label>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="employee"  onchange="valueChanged()" value="" id="employee">
                  <label class="form-check-label" for="flexCheckDefault">
                    Employee
                  </label>
                </div>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="employer"  onchange="empChanged()" value="" id="employer">
                  <label class="form-check-label" for="flexCheckDefault">
                    Employer
                  </label>
                </div>
                  <span class="invalid-feedback"><?php echo $employ_err ?></span>
            </div>
            <div class="form-group">
                <div id="displayemployee" style="display:none;">
                <label>Employee Education Level</label>
                <select name="education" class ="form-control <?php echo (!empty($education_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $education; ?>">
	                 <option value="0">--- Choose a education ---</option>
	                 <option value="1">No Education Required</option>
	                 <option value="2">High School Degree</option>
	                 <option value="3">Associate’s Degree</option>
                   <option value="4">Bachelor’s Degree</option>
	                 <option value="5">Master’s Degree</option>
                   <option value="6">Doctoral Degree</option>
                 </select>
                 <span class="invalid-feedback"><?php echo $education_err; ?></span>
               </div>
            </div>
            <div id="displayemployer" style="display:none;">
            <div class="form-group">
                <label>Employer Name</label>
                <input type="text" name="employername" class="form-control <?php echo (!empty($employername_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $employername; ?>">
                <span class="invalid-feedback"><?php echo $lastname_err; ?></span>
            </div>
              <div class="form-group" id=>
                  <label>Employer Email</label>
                  <input type="email" name="employeremail" class="form-control <?php echo (!empty($employeremail_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $employeremail; ?>">
                  <span class="invalid-feedback"><?php echo $employeremail_err; ?></span>
              </div>
              <div class="form-group">
                  <label>Employer Phone Number</label>
                  <input type="password" name="employerphonenumber" class="form-control <?php echo (!empty($employerphonenumber_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $employerphonenumber; ?>">
                  <span class="invalid-feedback"><?php echo $employerphonenumber_err; ?></span>
              </div>
              <div class="form-group">
                   <select name="role" class ="form-control <?php echo (!empty($role_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $role; ?>">
                     <option value="0">--- Choose a role ---</option>
                     <option value="1">Owner</option>
                     <option value="2">CEO</option>
                     <option value="3">Assistant or Manager</option>
                     <option value="4">Human Resources Generalist</option>
                     <option value="5">Hiring Manager</option>
                     <option value="6">Recruiter</option>
                     <option value="7">Other</option>
                   </select>
                 <span class="invalid-feedback"><?php echo $role_err; ?></span>
              </div>
              <script type="text/javascript">
                function addressChanged() {
                  if (document.getElementById('includeaddress').checked) {
                    document.getElementById("displayaddress").style.display = 'block';
                  } else {
                    document.getElementById("displayaddress").style.display = 'none';
                  }
                }

              </script>

              <div class="form-group">
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="includeaddress"  onchange="addressChanged()" id="includeaddress">
                  <label class="form-check-label" for="flexCheckDefault">
                    include Address?
                  </label>
                </div>
                    <span class="invalid-feedback"><?php echo $employ_err ?></span>
              </div>
              </div>
              <div id="displayaddress" style="display:none;">
              <div class="form-group">
                  <label>Street Address</label>
                  <input type="text" name="address" class="form-control <?php echo (!empty($address_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $address; ?>">
                  <span class="invalid-feedback"><?php echo $address_err; ?></span>
              </div>
              <div class="form-group">
                  <label>Zipcode</label>
                  <input type="text" name="zipcode" class="form-control <?php echo (!empty($zipcode_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $zipcode; ?>">
                  <span class="invalid-feedback"><?php echo $zipcode_err; ?></span>
              </div>
              <div class="form-group">
                  <label>City</label>
                  <input type="text" name="city" class="form-control <?php echo (!empty($city_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $city; ?>">
                  <span class="invalid-feedback"><?php echo $city_err; ?></span>
              </div>
              <label for="states"class="form-label">State</label>
              <select name = "states" id="states" class ="form-select <?php echo (!empty($states_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $states; ?>">
                 <option value="0">Choose</option>
                 <?php include 'states.php';
                    foreach ($state as $key => $value)
                    { ?>
                 <option value="<?php echo $key; ?>"><?php echo $value; ?></option>
                 <?php
                    } ?>
              </select>
              <span class="invalid-feedback"><?php echo $states_err; ?></span>
               </div>
            <br>
            </div>
            <div class="form-group">
                <input type="submit" class="btn btn-primary" value="Submit">
            </div>
            <p>Already have an account? <a href="login.php">Login here</a>.</p>
        </form>
    </div>
    </div>
</body>
</html>

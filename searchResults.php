<?php
session_start();
// Check if the user is logged in, if not then redirect him to login page
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true)
{
    header("location: login.php");
    exit;
}
//redirect if not employee
if (!isset($_SESSION["employee"]) && !$_SESSION["employee"] === true)
{
    header("location: createJobPost.php");
    exit;
}
if (isset($_GET['pageno']))
{
    $pageno = $_GET['pageno'];
}
else
{
    $pageno = 1;
}
$no_of_records_per_page = 10;
$offset = ($pageno - 1) * $no_of_records_per_page;
require_once "config.php";
$sql = "SELECT COUNT(*) FROM JobPosts Where Deadline >= CURDATE()";
if ($stmt = mysqli_prepare($mysqli, $sql))
{
    // Bind variables to the prepared statement as parameters
    //mysqli_stmt_bind_param($stmt, "");
    // Set parameters
    //$param_address= $address; // Creates a password hash
    // Attempt to execute the prepared statement
    if (mysqli_stmt_execute($stmt))
    {
        $total_rows = mysqli_stmt_num_rows($stmt);
        $total_pages = ($total_rows / $no_of_records_per_page) + 1;
        //$addressid = $mysqli->insert_id;
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
$sql = "SELECT Title,
  (Select EmployerName From Employer Where Employer.EmployerID =
  (Select EmployerID From employerposts Where employerposts.JobPostID = Jobposts.JobpostID limit 1)),
  (Select Title From educationlevels WHERE educationlevels.EducationID = jobposts.EducationID),
  (Select Title From salaryrange WHERE salaryrange.SalaryID = jobposts.SalaryID),
  (Select Title From jobtypes WHERE jobtypes.JobTypeID = jobposts.JobTypeID),
  (Select Title From experiencerequired WHERE experiencerequired.ExpReqID = jobposts.ExpReqID),
  StateName,CityName
  From Jobposts
  				join addresstojobpost on jobposts.JobPostID = addresstojobpost.JobPostID
   				join zipcodetoaddress on zipcodetoaddress.AddressID = addresstojobpost.AddressID
   				join zipcodes on zipcodetoaddress.ZipCode = zipcodes.ZipCode
                join city on city.CityID = zipcodes.CityID
   				join citytostate on city.CityID = citytostate.CityID
   				join state on citytostate.StateID = state.StateID

  Where Deadline >= CURDATE()
  LIMIT  ? ,  ?";
if ($stmt = mysqli_prepare($mysqli, $sql))
{
    // Bind variables to the prepared statement as parameters
    //mysqli_stmt_bind_param($stmt, "");
    // Set parameters
    //$param_address= $address; // Creates a password hash
    // Attempt to execute the prepared statement
    mysqli_stmt_bind_param($stmt, "ss", $param_offset, $param_limit);
    $param_limit = $no_of_records_per_page;
    $param_offset = $offset;
    /* bind result variables */
    mysqli_stmt_bind_result($stmt, $title, $name, $education, $salaryrange, $jobtype, $experiencelevel, $states, $city);
    // Attempt to execute the prepared statement
    if (mysqli_stmt_execute($stmt))
    {
        //$addressid = $mysqli->insert_id;
        // Redirect to login page
        //header("location: login.php");
        $arr = [];
        while (mysqli_stmt_fetch($stmt))
        {
            $arr[] = array(
                $title,
                $name,
                $education,
                $salaryrange,
                $jobtype,
                $experiencelevel,
                $states,
                $city
            );
        }
        //get results
        //print_r ($arr);

    }
    else
    {
        echo "Oops! Something went wrong. Please try again later.";
    }

    // Close statement
    mysqli_stmt_close($stmt);

}
?>


<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!-- Bootstrap CSS -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
      <style>
         body{ font: 14px sans-serif; }
         .wrapper{  width: 1000px;padding: 50px; margin: 0 auto;}
      </style>
      <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
   </head>
   <body>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
      <div class = "wrapper">
      <div class="container d-grid gap-2">
         <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
               <a class="navbar-brand" href="#">Lindeed</a>
               <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
               <span class="navbar-toggler-icon"></span>
               </button>
               <div class="collapse navbar-collapse" id="navbarSupportedContent">
                  <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                     <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Home</a>
                     </li>
                     <li class="nav-item dropdown <?php echo (!isset($_SESSION["employer"])) ? 'd-none' : ''; ?>">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Employer Tools
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                           <li><a class="dropdown-item" href="createJobPost.php">Create Jobpost</a></li>
                           <li><a class="dropdown-item" href="viewEmployerPosts.php">View Jobposts</a></li>
                        </ul>
                     </li>
                     <li class="nav-item dropdown <?php echo (!isset($_SESSION["employee"])) ? 'd-none' : ''; ?>">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Employee Tools
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                           <li><a class="dropdown-item" href="#">My Jobpost</a></li>
                           <li><a class="dropdown-item" href="#">My Applications</a></li>
                           <li><a class="dropdown-item" href="searchResults.php">Search Jobposts</a></li>
                        </ul>
                     </li>
                     <li class="nav-item">
                        <a class="nav-link" href="logout.php">Logout</a>
                     </li>
                  </ul>
               </div>
            </div>
         </nav>
         <br>
         <?php  foreach($arr as $key => $value)
            { ?>
         <div class="card mb-3">
            <div class="card-body">
               <div class="d-flex flex-column flex-lg-row">
                  <div class="row flex-fill">
                     <div class="col-sm-5">
                        <h4 class="h5"><?php echo $value[0]; ?></h4>
                        <h5 class="h6"><?php echo $value[1]; ?></h5>
                        <span class="badge bg-secondary"><?php echo $value[7].", ".$value[6]; ?></span> <span class="badge bg-success"><?php echo $value[3]; ?></span>
                     </div>
                     <div class="col-sm-4 py-4">
                        <span class="badge bg-secondary "><?php echo $value[2]; ?></span>
                        <span class="badge bg-secondary"><?php echo $value[4]; ?></span>
                        <span class="badge bg-secondary"><?php echo $value[5]; ?></span>
                     </div>
                     <div class="col-sm-3 text-lg-end">
                        <a href="#" class="btn btn-primary stretched-link">Apply</a>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <?php
            } ?>
         <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
               <li class = page-link><a href="?pageno=1">First</a></li>
               <li class="page-item <?php if($pageno <= 1){ echo 'disabled'; } ?>">
                  <a class = page-link href="<?php if($pageno <= 1){ echo '#'; } else { echo "?pageno=".($pageno - 1); } ?>">Prev</a>
               </li>
               <li class="page-item <?php if($pageno >= $total_pages){ echo 'disabled'; } ?>">
                  <a class = page-link href="page-link <?php if($pageno >= $total_pages){ echo '#'; } else { echo "?pageno=".($pageno + 1); } ?>">Next</a>
               </li>
               <li class = page-link><a href="?pageno=<?php echo $total_pages; ?>">Last</a></li>
            </ul>
         </nav>
      </div>
   </body>
</html>

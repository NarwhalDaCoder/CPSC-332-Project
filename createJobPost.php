<?php
// Initialize the session
session_start();

// Check if the user is logged in, if not then redirect him to login page
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true)
{
    header("location: login.php");
    exit;
}

if ($_SERVER["REQUEST_METHOD"] == "POST" && $_POST['randcheck'] == $_SESSION['rand'])
{
    require_once "config.php";
    $jobtitle = $jobdescription = $address = $city = $states = $zipcode = $qualifications = $responsibilities = $education = $jobtype = $experiencelevel = $salaryrange = $benefits = $contactdetails = $deadline = "";
    $jobtitle_err = $jobdescription_err = $address_err = $city_err = $states_err = $zipcode_err = $qualifications_err = $responsibilites_err = $education_err = $jobtype_err = $experiencelevel_err = $salaryrange_err = $contactdetails_err = $deadline_err = "";
    include 'validation/validateJobPost.php';
    if (empty($jobtitle_err) && empty($jobdescription_err) && empty($jobtitle_err) && empty($city_err) && empty($states_err) && empty($zipcode_err) && empty($qualifications_err) && empty($responsibilities_err) && empty($education_err) && empty($jobtype_err) && empty($experiencelevel_err) && empty($salaryrange_err) && empty($contactdetails_err) && empty($deadline_err))
    {
        include 'inserts/insertJobPost.php';
        echo "I did work";
    }
    else
    {
        echo "I didnt work";
    }
}

?>

<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="UTF-8">
      <title>Job Post Creation</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
      <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
      <!-- Latest compiled and minified CSS -->
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/css/bootstrap-select.min.css">
      <!-- Latest compiled and minified JavaScript -->
      <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/js/bootstrap-select.min.js"></script>
      <style>
         body{ font: 14px sans-serif; }
         .wrapper{ width: 1000px; padding: 50px; margin:0 auto;}
      </style>
      <link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
      <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
      <script>
         $( function() {
           $( "#datepicker" ).datepicker({minDate:0,dateFormat:'yy-mm-dd'});
         } );
      </script>
   </head>
   <body>
      <div class="wrapper">
         <div class="d-grid gap-4">
            <div class="p-2">
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
                           <li class="nav-item dropdown">
                              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                              Employer Tools
                              </a>
                              <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                 <li><a class="dropdown-item" href="CreateJobPost.php">Create Jobpost</a></li>
                                 <li><a class="dropdown-item" href="#">View Jobposts</a></li>
                              </ul>
                           </li>
                           <li class="nav-item dropdown">
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
            </div>
            <div class="p-2">
               <p>Please fill this form to create a Jobpost.</p>
               <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post" >
                  <?php
                     $rand = rand();
                     $_SESSION['rand'] = $rand;
                     ?>
                  <input type="hidden" value="<?php echo $rand; ?>" name="randcheck" />
                  <div class="d-grid gap-4">
                     <div class="row gx-5">
                        <div class="col-6">
                           <div class="d-grid gap-3">
                              <div class="form-group">
                                 <label for="jobtitle">Job Title</label>
                                 <input type="text" class="form-control" name= "jobtitle" id="jobtitle" placeholder="Enter a job title">
                              </div>
                              <div class="form-group">
                                 <label for="jobdescription">Job Descirption</label>
                                 <textarea class="form-control" name = "jobdescription" id="jobdescription" rows="3"></textarea>
                              </div>
                              <div class="row g-3">
                                 <div class="col-md-12">
                                    <label for="inputAddress" class="form-label">Address</label>
                                    <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
                                 </div>
                                 <div class="col-md-4">
                                    <label for="inputCity" class="form-label">City</label>
                                    <input type="text" class="form-control" id="inputCity">
                                 </div>
                                 <div class="col-md-5">
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
                                 <div class="col-md-3">
                                    <label for="inputZip" class="form-label">Zip</label>
                                    <input type="text" class="form-control" id="inputZip">
                                 </div>
                              </div>
                              <div class="form-group">
                                 <label for="qualifications">Qualifications</label>
                                 <textarea class="form-control" name ="qualifications" id="qualifications" rows="3"></textarea>
                              </div>
                              <div class="form-group">
                                 <label for="responsibilites">Responsibilites</label>
                                 <textarea class="form-control" name = "responsibilities" id="responsibilities" rows="3"></textarea>
                              </div>
                           </div>
                        </div>
                        <div class="col-6 d-grid gap-3">
                           <div class="form-group">
                              <label for="education">Education Level</label>
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
                           <div class="form-group">
                              <label for="jobtype">Job Type</label>
                              <select name="jobtype" class ="form-control">
                                 <option value="0">--- Choose a Jobtype ---</option>
                                 <option value="1">Full-Time</option>
                                 <option value="2">Part-Time</option>
                                 <option value="3">Contract</option>
                                 <option value="4">Temporary</option>
                                 <option value="5">Internship</option>
                              </select>
                              <span class="invalid-feedback"><?php echo $education_err; ?></span>
                           </div>
                           <div class="form-group">
                              <label for="experiencelevel">Experience Level</label>
                              <select name="experiencelevel" class ="form-control">
                                 <option value="0">--- Choose a Experience Level ---</option>
                                 <option value="1">Entry Level</option>
                                 <option value="2">Mid-Level</option>
                                 <option value="3">Senior Level</option>
                              </select>
                              <span class="invalid-feedback"><?php echo $education_err; ?></span>
                           </div>
                           <div class="form-group">
                              <label for="salaryrange">Salary Range</label>
                              <select name="salaryrange" class ="form-control">
                                 <option value="0">--- Choose a Salary Range ---</option>
                                 <option value="1">$35,000+</option>
                                 <option value="2">$40,000+</option>
                                 <option value="3">$50,000+</option>
                                 <option value="4">$70,000+</option>
                                 <option value="5">$100,000+</option>
                              </select>
                              <span class="invalid-feedback"><?php echo $education_err; ?></span>
                           </div>
                           <div class="form-group">
                              <label for="benefits">Select Benefits</label>
                              <select class="form-control selectpicker" name="benefits[]" multiple data-width="200px">
                                 <option value = "1">Health Insurance</option>
                                 <option value = "2">Vision Insurance</option>
                                 <option value = "3">Dental Insurance</option>
                                 <option value = "4">Life Insurance</option>
                                 <option value = "5">Pension</option>
                                 <option value = "6">401(k)</option>
                              </select>
                           </div>
                           <div class="form-group">
                              <label for="contactdetails">Contact Details</label>
                              <textarea class="form-control" name = "contactdetails" id="contactdetails" rows="3"></textarea>
                           </div>
                           <div class="form-group">
                              <label for="deadline">Date: </label>
                              <input type="text" name = "deadline" id="datepicker"/>
                           </div>
                        </div>
                     </div>
                     <div class="form-group">
                        <input type="submit" class="btn btn-primary" value="Submit">
                     </div>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </body>
</html>

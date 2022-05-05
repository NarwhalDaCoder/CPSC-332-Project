<?php
//validate jobtitle
if (empty(trim($_POST["jobtitle"])))
{
    $jobtitle_err = "Please enter a email.";
}
else{
  $jobtitle = trim($_POST["jobtitle"]);
}

//validate jobdescription
if (empty(trim($_POST["jobdescription"])))
{
    $jobdescription_err = "Please enter a email.";
}
else{
  $jobdescription = trim($_POST["jobdescription"]);
}

include 'validateAddress.php';
//validate qualifications
if (empty(trim($_POST["qualifications"])))
{
    $qualifications_err = "Please enter a email.";
}
else{
  $qualifications = trim($_POST["qualifications"]);
}
//validate contactdetails
if (empty(trim($_POST["contactdetails"])))
{
    $contactdetails_err = "Please enter contact details.";
}
else{
  $contactdetails = trim($_POST["contactdetails"]);
}
//validate responsibilites
if (empty(trim($_POST["responsibilities"])))
{
    $responsibilities_err = "Please enter a email.";
}
else{
  $responsibilities = trim($_POST["responsibilities"]);
}
//validate education
if (!isset($_POST['education']) || $_POST['education'] == '0')
{
  $education_err = "Please select a dropdown option";
}
else
{
  $education = trim($_POST["education"]);
}
//validate experiencelevel
if (!isset($_POST['experiencelevel']) || $_POST['experiencelevel'] == '0')
{
  $experiencelevel_err = "Please select a dropdown option";
}
else
{
  $experiencelevel = trim($_POST["experiencelevel"]);
}
//validate experiencelevel
if (!isset($_POST['jobtype']) || $_POST['jobtype'] == '0')
{
  $jobtype_err = "Please select a dropdown option";
}
else
{
  $jobtype = trim($_POST["jobtype"]);
}
//validate salaryrange
if (!isset($_POST['salaryrange']) || $_POST['salaryrange'] == '0')
{
  $salaryrange_err = "Please select a dropdown option";
}
else
{
  $salaryrange = trim($_POST["salaryrange"]);
}
//validate salaryrange
if (!isset($_POST['benefits']) || $_POST['benefits'] == '0')
{
  $benefits = "";
}
else
{
  $benefits = implode(',', $_POST['benefits']);
}
if (empty(trim($_POST["deadline"])))
{
    $deadline_err = "Please enter a date.";
}
else{
  $d = DateTime::createFromFormat('Y-m-d', trim($_POST["deadline"]));
  $dateValid = $d && $d->format('Y-m-d') == trim($_POST["deadline"]);
  if($dateValid){
    $today = new DateTime('NOW');
    $today = $today->format('Y-m-d');
    if($dateValid>=$today){
      $deadline = trim($_POST["deadline"]);
    }
    else{
      $deadline_err = "Please enter a valid date.";
    }
  }
  else{
    $deadline_err = "Please enter a valid date.";
  }

}
 ?>

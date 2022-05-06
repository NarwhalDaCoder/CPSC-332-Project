<?php
  $sql1 = "INSERT INTO JobPosts (Title, Description,Responsibilities,Qualifications,Deadline,ContactDetails,EducationID,JobTypeID,ExpReqID,SalaryID) VALUES (?,?,?,?,?,?,?,?,?,?)";
  $sql2 = "INSERT INTO EmployerPosts (JobPostID,EmployerID) VALUES (?,?)";
  //$sql3 = "INSERT INTO AddressToJobPost(JobPostID,AddressID) VALUES (?,?)";
  //$sql4 = "INSERT INTO JobBenefits(JobPostID,BenefitID) VALUES (?,?)";
  if($stmt = mysqli_prepare($mysqli, $sql1)){
      // Bind variables to the prepared statement as parameters
      mysqli_stmt_bind_param($stmt, "ssssssssss", $param_title,$param_description,$param_responsibilities,$param_qualifications,$param_deadline,$param_contactdetails,$param_educationid,$param_jobtypeid,$param_experienceid,$param_salaryid);

      $param_title = $jobtitle;
      $param_description=$jobdescription;
      $param_responsibilities=$responsibilities;
      $param_qualifications=$qualifications;
      $param_deadline=$deadline;
      $param_contactdetails=$contactdetails;
      $param_educationid=$education;
      $param_jobtypeid=$jobtype;
      $param_experienceid=$experiencelevel;
      $param_salaryid=$salaryrange;
      // Attempt to execute the prepared statement
      if(mysqli_stmt_execute($stmt)){
          $jobpostid = $mysqli->insert_id;
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
      mysqli_stmt_bind_param($stmt, "ss", $param_jobpostid,$param_employerid);
      $param_jobpostid=$jobpostid;
      $param_employerid = $_SESSION["id"];


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
  include 'inserts/insertAddress.php';
  $sql3 = "INSERT INTO AddressToJobPost(JobPostID,AddressID) VALUES (?,?)";
  $sql4 = "INSERT INTO JobBenefits(JobPostID,BenefitID) VALUES (?,?)";
  if($stmt = mysqli_prepare($mysqli, $sql3)){
      // Bind variables to the prepared statement as parameters
      mysqli_stmt_bind_param($stmt, "ss", $param_jobpostid,$param_addressid);
      $param_jobpostid=$jobpostid;
      $param_addressid = $addressid;


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
if(!empty($benefits)){
$pieces = explode(",", $benefits);
foreach($pieces as $char){
    // your code

  if($stmt = mysqli_prepare($mysqli, $sql4)){
      // Bind variables to the prepared statement as parameters
      mysqli_stmt_bind_param($stmt, "ss", $param_jobpostid,$param_benefitid);
      $param_jobpostid=$jobpostid;
      $param_benefitid = $char;


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
}
 ?>

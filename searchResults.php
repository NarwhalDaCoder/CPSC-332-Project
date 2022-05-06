<?php
session_start();
// Check if the user is logged in, if not then redirect him to login page
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
  header("location: login.php");
  exit;
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
         <br>
         <div class="card mb-3">
            <div class="card-body">
               <div class="d-flex flex-column flex-lg-row">
                  <div class="row flex-fill">
                     <div class="col-sm-5">
                        <h4 class="h5">Title</h4>
                        <h5 class="h6">Company</h5>
                        <span class="badge bg-secondary">City, State</span> <span class="badge bg-success">$xxxxx+</span>
                     </div>
                     <div class="col-sm-4 py-3">
                        <span class="badge bg-secondary">REACT</span>
                        <span class="badge bg-secondary">NODE</span>
                        <span class="badge bg-secondary">TYPESCRIPT</span>
                        <span class="badge bg-secondary">JUNIOR</span>
                     </div>
                     <div class="col-sm-3 text-lg-end">
                        <a href="#" class="btn btn-primary stretched-link">Apply</a>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
               <li class="page-item disabled">
                  <a class="page-link">Previous</a>
               </li>
               <li class="page-item"><a class="page-link" href="#">1</a></li>
               <li class="page-item"><a class="page-link" href="#">2</a></li>
               <li class="page-item"><a class="page-link" href="#">3</a></li>
               <li class="page-item">
                  <a class="page-link" href="#">Next</a>
               </li>
            </ul>
         </nav>
      </div>
   </body>
</html>

<?php
  //validate street address
  if (empty(trim($_POST["address"])))
  {
      $address_err = "Please enter a Street Address";
  }
  else
  {
      $address = trim($_POST["address"]);
  }
  //validate zip
  if (!preg_match("/^[0-9]{5}$/", trim($_POST["zipcode"])))
  {
      $zipcode_err = "Please enter a zipcode of 5 digits.";
  }
  else
  {
      $zipcode = trim($_POST["zipcode"]);
  }
  //validate City
  if (!preg_match("/^\p{L}+(?:([\ \-\']|(\.\ ))\p{L}+)*$/", trim($_POST["city"])))
  {
      $city_err = "Please enter a valid city name";
  }
  else
  {
      $city = trim($_POST["city"]);
  }
  //validate state
  if (!isset($_POST['states']) || $_POST['states'] == '0')
  {
    $states_err = "Please select a state";
  }
  else
  {
    $states = trim($_POST["states"]);
  }

 ?>

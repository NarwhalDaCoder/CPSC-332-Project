# CPSC-332-Project
This is the project repository for a guru/indeed style website, built with php.
This site was designed to run on an aphace web server, with a corresponding SQL database, 
to be hosted through the XAMPP application.

As of writing this readme, the only functionality that is working is the login features, as well as
job post searching and creating.

The unavalaible features are viewing the job post in a seperate page.

# Setting Up the Repository
This application was meant to be run through XAMPP, which can be found here https://www.apachefriends.org/download.html <br>
To run this software, place the contents of this repository at the install location of XAMPP atz "PATH_TO_XAMPP_/htdocs"

# Setting Up the Database
After XAmpp has started the Apache web server and mysql server, access the php admin panel through a browser at

IP_ADDRESS:PORT/phpmyadmin (i.e localhost:80/phpmyadmin )

Once the panel has been reached, click the import tab and upload the file myjob.sql, to add the tables necessary for the project to run

# Accessing the Webstie
After the SQL data has been uploaded, start a browser window at 

IP_ADDRESS:PORT/login.php (i.e localhost:80/login.php )

to reach the inital login page for the site. <br> All other pages can be accessed after registering an account with the site and logining in

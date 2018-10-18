# docker-UNIT3D

A dockerfile to get the <a href="https://github.com/HDInnovations/UNIT3D">UNIT3D Tracker</a> by <a href="https://github.com/HDInnovations">HDInnovations</a> up and running.

This is a work in progress(proof of concept) and does not work yet. Also do not use this in production! Contribute or fork if you want. 

Please open issues if you have any problems! Suggestions and recommendations are heavily welcome.

### Startup parameters needed for the container:

###### DB_HOST - The host of the database IP or Domain

###### DB_DATABASE - The name of the Unit3d database

###### DB_USERNAME - The username of the mysql user

###### DB_PASSWORD - The password of the user

###### APP_URL - The Url on which the Unit3d App will listen 

###### INITIALIZE - 0/1 if you want to create the database for Unit3d or not

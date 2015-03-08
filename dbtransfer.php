<?php
$servername = "localhost";
$username = "scia";
$password = "12345";
$dbname = "scia";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM site_data;
$result = $conn->query($sql);

$conn->close();


$servername2 = "thesciaproject.org";
$username2 = "scia";
$password2 = "12345";
$dbname2 = "scia";

// Create connection
$conn2 = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn2) {
    die("Connection failed: " . mysqli_connect_error());
}


if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        $sq2 = "INSERT INTO site_data (gps_location, time_taken, specimen_count)
                  VALUES ($row['gps_location'], $row['time_taken'], $row['specimen_count'])";

        if (mysqli_query($conn2, $sql)) {
            echo "New record created successfully";
        } else {
            echo "Error: " . $sql . "<br>" . mysqli_error($conn);
        }
    }
}
mysqli_close($conn2);



/ Create connection 1 again
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        $sql = "DELETE FROM site_data where index = ".$row['index'];
        $result = $conn->query($sql);

        if (mysqli_query($conn2, $sql)) {
            echo "New record created successfully";
        } else {
            echo "Error: " . $sql . "<br>" . mysqli_error($conn);
        }
    }
}

$conn->close();
?> 

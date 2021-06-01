<?php
$link = mysqli_connect("mysql743.umbler.com", "bage","Xnoc3301");
$database = mysqli_select_db($link, "dbage");

$user = $_GET['usuario'];
$password = $_GET['senha'];
$hwid = $_GET['hwid'];
$tables = "usuario";

$sql = "SELECT * FROM ". $tables ." WHERE usuario = '". mysqli_real_escape_string($link,$user) ."'" ;
$result = $link->query($sql);
if ($result->num_rows > 0) {
    // Outputting the rows
    while($row = $result->fetch_assoc())
    {
        
        $password = $row['senha'];
        $salt = $row['salt'];
        $plain_pass = $_GET['senha'];
        $stored_pass = md5(md5($salt).md5($plain_pass));
        
        function Redirect($url, $permanent = false)
        {
            if (headers_sent() === false)
            {
                header('Location: ' . $url, true, ($permanent === true) ? 301 : 302);
            }
        exit();
        }
        
        if($stored_pass != $row['senha'])
        {
            echo "p0<br>"; // Wrong pass, user exists
        }
        else
        {
            echo "p1<br>"; // Correct pass
        }
        
        echo "g" . $row['usergroup'] . "<br>";

        if (strlen($row['hwid']) > 1)
        {
            if ($hwid != $row['hwid'])
            {
                echo "h2"; // Wrong
            }
            else
            {
                echo "h1"; // Correct
            }
        }
        else
        {
            $sql = "UPDATE ". $tables ." SET hwid='$hwid' WHERE usuario='$user'";
            if(mysqli_query($link, $sql))
            {
                echo $row['hwid'];
                echo "h3"; // HWID Set
            }
            else
            {
                echo "h4"; // Else errors
            }
        }
    }
}  
?>

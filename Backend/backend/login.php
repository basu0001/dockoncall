<?php
$response = array();
include '/opt/lampp/htdocs/backend/db_connect.php';
include '/opt/lampp/htdocs/backend/functions.php';
 
//Get the input request parameters
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE); //convert JSON into array
 
//Check for Mandatory parameters
if(isset($input['email_id']) && isset($input['password'])){
	$emailId = $input['email_id'];
	$password = $input['password'];
	$query    = "SELECT first_name,password_hash ,salt FROM user_details WHERE email_id = ?";
 
	if($stmt = $con->prepare($query)){
		$stmt->bind_param("s",$emailId);
		$stmt->execute();
		$stmt->bind_result($firstName,$passwordHashDB,$salt);
		if($stmt->fetch()){
			//Validate the password
			if(password_verify(concatPasswordWithSalt($password,$salt),$passwordHashDB)){
				$response["status"] = 0;
				$response["message"] = "Login successful";
				$response["first_name"] = $firstName;
			}
			else{
				$response["status"] = 1;
				$response["message"] = "Invalid email id and password combination";
			}
		}
		else{
			$response["status"] = 1;
			$response["message"] = "Invalid email id and password combination";
		}
		
		$stmt->close();
	}
}
else{
	$response["status"] = 2;
	$response["message"] = "Missing mandatory parameters";
}
//Display the JSON response
echo json_encode($response);
?>

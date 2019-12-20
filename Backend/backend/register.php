<?php
$response = array();
include '/opt/lampp/htdocs/backend/db_connect.php';
include '/opt/lampp/htdocs/backend/functions.php';
 
//Get the input request parameters
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE); //convert JSON into array
 
//Check for Mandatory parameters
if(isset($input['UID']) && isset($input['first_name']) && isset($input['last_name']) && isset($input['email_id']) && isset($input['contact']) && isset($input['condition_acceptance']) && isset($input['blood_group']) && isset($input['Question_1']) && isset($input['Question_2']) && isset($input['Question_3']) && isset($input['Question_4']) && isset($input['user_status']) && isset($input['dob']) && isset($input['password']) && isset($input['gender'])){
	        
        $UID = $input['UID'];
        $first_name = $input['first_name'];
        $last_name = $input['last_name'];
        $email_id = $input['email_id'];
        $contact = $input['contact'];
        $condition_acceptance = $input['condition_acceptance'];
        $blood_group = $input['blood_group'];
        $Question_1 = $input['Question_1'];
        $Question_2 = $input['Question_2'];
        $Question_3 = $input['Question_3'];
        $Question_4 = $input['Question_4'];
        $user_status = $input['user_status'];
        $dob = $input['dob'];
        $password = $input['password'];
        $gender = $input['gender'];
        
	//Check if user already exist
	if(!userExists($email_id)){
 
		//Get a unique Salt
		$salt         = getSalt();
		
		//Generate a unique password Hash
		$passwordHash = password_hash(concatPasswordWithSalt($password,$salt),PASSWORD_DEFAULT);
		
		//Query to register new user
		$insertQuery  = "INSERT INTO user_details (UID, first_name, last_name, email_id, contact, condition_acceptance, blood_group, Question_1, Question_2, Question_3, Question_4, user_status, dob, password_hash, salt, gender) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	        if($stmt = $con->prepare($insertQuery)){
                $stmt->bind_param( "ssssisssssssssss",$UID,$first_name,$last_name,$email_id,$contact,$condition_acceptance,$blood_group,$Question_1,$Question_2,$Question_3,$Question_4,$user_status,$dob,$passwordHash,$salt,$gender);
               		$stmt->execute();
			$response["status"] = 0;
			$response["message"] = "User created";
			$stmt->close();
		}
            }
	else{
		$response["status"] = 1;
		$response["message"] = "User exists";
	}
}
else{
	$response["status"] = 2;
	$response["message"] = "Missing mandatory parameters";
}
echo json_encode($response);
?>
 

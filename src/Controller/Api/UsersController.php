<?php

namespace App\Controller\Api;



use App\Controller\AppController;

use Cake\Event\Event;
use Cake\Routing\Router;
use Cake\Auth\DefaultPasswordHasher;
use Cake\Core\Configure;
use Cake\Mailer\Email;

use Cake\Error\Debugger;
use Twilio\Rest\Client;
use Cake\ORM\TableRegistry;



 


/**

 * Users Controller

 *

 * @property \App\Model\Table\UsersTable $Users

 *

 * @method \App\Model\Entity\User[] paginate($object = null, array $settings = [])

 */

class UsersController extends AppController

{



	public function beforeFilter(Event $event) {

        parent::beforeFilter($event);
  

        $this->Auth->allow(['index','updatetoken','sendotp','updateprofile','allskills','verifyotp','resendotp','login',
                            'alluser','userdata','edit','changepassword','forgot','searchdata','pushnotification',
                            'reset','add','usersetting','pushsend','admindata']); 

        $this->authcontent();

    }



    /**

     * Index method

     *

     * @return \Cake\Http\Response|void

     */
    public function index(){

    	
            $baseurl = Router::url('/',true);

        $indexInfo['description'] = "Signup (post method)";

        $indexInfo['url'] = $baseurl. "api/users/add";

        $indexInfo['parameters'] = 'fname:kuldeep kumar phone:123456789  password:123456<br>';

        $indexarr[] = $indexInfo;    

        $indexInfo['description'] = "User login(post method)";

        $indexInfo['url'] = $baseurl. "api/users/login";

        $indexInfo['parameters'] = 'username:prateek@avainfotech.com password:123456,device_token:dfrgtrghryhtrytret454545fg<br>'; $indexarr[] = $indexInfo;


        $indexInfo['description'] = "User Data(post method)"; 

        $indexInfo['url'] = $baseurl. "api/users/userdata";

        $indexInfo['parameters'] = 'id:44 <br>'; 

        $indexarr[] = $indexInfo;


        $indexInfo['description'] = "Edit Profile(post method)"; 

        $indexInfo['url'] = $baseurl. "api/users/edit";

        $indexInfo['parameters'] = 'id:45 ,fname:Vandana11 lname:sdff,image:abc.png ,<br>'; 

        $indexarr[] = $indexInfo;


        $indexInfo['description'] = "Changepassword (post method)"; 

        $indexInfo['url'] = $baseurl. "api/users/changepassword"; 

        $indexInfo['parameters'] = 'id:45 ,oldpassword:123456 password:123 ,<br>'; 
        $indexarr[] = $indexInfo;

        $indexInfo['description'] = "Forgot Password (post method)"; 
        $indexInfo['url'] = $baseurl. "api/users/forgot"; 
        $indexInfo['parameters'] = 'email:prateek@avainfotech.com ,<br>'; 
        $indexarr[] = $indexInfo;

        $indexInfo['description'] = "Nearest Store By Location";
        $indexInfo['url'] = $baseurl. "api/giftcards/neareststorebylocation";
        $indexInfo['parameters'] = 'lat:30.723465 ,long: 76.808853 <br>';
        $indexarr[] = $indexInfo;  

        $this->set('baseurl', $baseurl);
        $this->set('indexarr', $indexarr); 

        $this->set('_serialize', ['user']);

    }




    public function sendotp($number)
    {
        $sid    = "AC6d382138e723fbc541f9873c89e13753";
        $token  = "62c768386e8ee1c0b8a04bd13134a596";
        $twilio = new Client($sid, $token);
        $randnum = rand(1000,9999);

        $message = $twilio->messages
                        ->create("+1".$number, // to
                                array("from" => "+17707669412", "body" => "your otp is ".$randnum )
                        );

        return $randnum;
        exit();
    }


    public function add()

    {  
        $response = array();

        $user = $this->Users->newEntity();
        if ($this->request->is('post')) {  

        if(empty($this->request->data['name'])){ 

            $response['status'] = false;
            $response['msg'] = "Name required"; 
        }elseif(empty($this->request->data['phone'])){ 

            $response['status'] = false;
            $response['msg'] = "Phone required"; 
        }
        
        else{    

        $user_check = $this->Users->find('all', ['conditions' => ['Users.phone' => $this->request->data['phone']]]);
        $user_check = $user_check->first();
        if (!empty($user_check)) {
            $response['status'] = false;
            $response['msg'] = "Phone number already exists. Please try with another Phone number.";
        }else{

            $post = $this->request->getData();   

            $post['status'] = '0';
            $post['role'] = 'user';  

            $otp=$this->sendotp($this->request->data['phone']);
            $post['tokenhash'] = $otp; 

            $user = $this->Users->patchEntity($user, $post);
            
            $new_user = $this->Users->save($user);  

            if ($new_user) {
                 $response['status'] = true;
                 $response['msg'] = " Registration done successfully.";
                 $response['data'] = $new_user;
               
             }else {

                $response['status'] = false;
                $response['msg'] = "The user could not be saved. Please, try again.";

            }

        }
      

      }

        }

       
        echo json_encode($response);
        exit;

    }


    public function resendotp()
    {
        if(empty($this->request->data['id'])){
			$response['msg']='user id required';
			$response['status']= false;

    	}else{
            $otp=$this->sendotp($this->request->data['phone']);
            $users = $this->Users->find('all', [
                'conditions' => ['Users.id' => $this->request->data['id']]
                ]);
            $users = $users->first();    
            if ($users) {
                $this->Users->updateAll(array('tokenhash' =>$otp), array('id' => $users['id']));
                $response['status'] = true;
                $response['msg'] = "Otp send Successfully.";
                $response['data'] = '';
               
             }else {
                $response['status'] = false;
                $response['msg'] = "Please, try again.";

            }
        }
            echo json_encode($response);
            exit;

    }



    public function verifyotp()
    { 

        if(empty($this->request->data['id'])){
			$response['msg']='user id required';
			$response['status']= false;

    	}else{
    		$users = $this->Users->find('all', [
			'conditions' => ['Users.id' => $this->request->data['id']]
			]);
            $users = $users->first();
			if($users['tokenhash'] ==  $this->request->data['otp']){
                $this->Users->updateAll(array('tokenhash' =>' ','status'=>1), array('id' => $users['id']));
			    $response['data']= $users;
			    $response['status']= true;
                $response['baseurl'] =  Router::url('/', true) . 'images/users/';
			}else{
			$response['msg']='Invalid otp';	
			$response['data']= '';
			$response['status']= false;	
			}
		
    	}
      echo json_encode($response);
      exit;
    }






    public function pushsend()

    { 
         $response = array(); 
         if ($this->request->is('post')) { 
          $user_id = $this->request->data['user_id']; 
          if(!empty($user_id)){
          $userdata = $this->Users->find('all',['contain'=>['Usertones'=>'Tones'],'conditions'=>['Users.id'=>$user_id]]);

          $userdata = $userdata->first();
         if($userdata){ 

         if($userdata['device_token']){  
          $sound = true ;
          $soundarray = [] ;
          if(!empty($userdata['usertones'])){

            foreach ($userdata['usertones'] as $key => $value) {
             $soundarray[] = $value['tone']['file'];
            }

          }  
          if(!empty($soundarray)){
            shuffle($soundarray);
            $sound = $soundarray[0];
          }else{
           $sound = true ; 
          }
       
         $send = $this->SendPushNotificationsAndroid($userdata['device_token'],'Test','This is test push notification.',$sound);

           if($send){
             $response['msg'] = "Successfully send notification."; 
             $response['status'] = true;
           }else{
             $response['msg'] = "something worng.";
             $response['status'] = false;
           } 

          }else{
            $response['msg'] = "Device token required.";
            $response['status'] = false;   
          } 

         }else{
             $response['msg'] = "Invalid user";
             $response['status'] = false; 
         }  

        }else{
             $response['msg'] = "User id required";
             $response['status'] = false; 
        } 
       }

         echo json_encode($response);
         exit;
    }



    public function login()

    {
         $response = array();
        
		if ($this->request->is('post')) {

            if (!filter_var($this->request->data['phone'], FILTER_VALIDATE_EMAIL) === false) {

                $use = $this->Users->find('all',['conditions'=>['Users.phone'=>$this->request->data['phone']]]);
            }else{
           
                $use = $this->Users->find('all',['conditions'=>['Users.phone'=>$this->request->data['phone']]]);  
            }
            $use = $use->first();
            if (empty($use)){
               $response['msg']='Invalid phone';
                 $response['status']= false;
                 
            }elseif (!(new DefaultPasswordHasher)->check($this->request->data['password'], $use['password'])) {
              $response['msg']='Wrong password';
              $response['status']=false;   
            }else{

                if ($use['status'] == 0) {   
                     $this->Auth->logout();
                     $response['msg']='You are not active Yet!';
                     $response['status']=false;    
                      
                 }else{

				$this->Auth->setUser($use); 
				if($this->Auth->user('role') == 'admin'){

					$this->logout();
					$response['msg']='You are admin';
					$response['status']=false;
				

				}else{	
					if(isset($this->request->data['device_token'])){   
					$this->Users->updateAll(['device_token' =>$this->request->data['device_token']],['id' =>$use['id']]); 
					}		

                     $usedata = $this->Users->find('all',['conditions'=>['Users.id'=>$use['id']]]);
                    $usedata = $usedata->first();
                  	$response['msg']='login successfully';
					$response['status']= true; 
                    $response['data']= $usedata;
                    $response['baseurl'] =  Router::url('/', true) . 'images/users/';
				}	


              }  

			}

        }
      echo json_encode($response);
      exit;
    }

    

    public function alluser()

    {	
        if(empty($this->request->data['latitude'])){
            $response['status'] = false;
            $response['msg'] = 'latitude id required!.';    
        }elseif(empty($this->request->data['longitude'])){
            $response['status'] = false;
            $response['msg'] = 'longitude id required!.';    
        }else{
            $user = TableRegistry::get('Users');
            $users = $user->find('all',['order' => ['Users.modified' => 'DESC']]);
            $data = $users->where(['Users.role' => 'user' ,'status' => 1])
             ->select([
                 'distances' => $users->func()->get_distance_in_miles_between_geo_locations([
                 $this->request->data['latitude'],
                 $this->request->data['longitude'],
                     'Users.latitude' => 'identifier',
                     'Users.longitude' => 'identifier'  
                 ])
             ])
             ->select($user)
             ->contain(['Userskills' => [
                'Categories']])->all(); 
            

			if($users){
            $response['data']= $data;
            $response['baseurl'] =  Router::url('/', true) . 'images/users/';
			$response['status']= true;

			}else{
			$response['msg']='No Professionals found.';	
			$response['data']= '';
			$response['status']= false;	
            }
        }
		
      echo json_encode($response);
      exit;

    }

     public function allskills()

    {   
            $this->loadModel('Categories');

            $skills = $this->Categories->find('all', [
            ['conditions'=>['Categories.status'=>1]]
            ])->all();

            // $users = $users->first();
            if($skills){
            $response['data']= $skills;
            $response['status']= true;

            }else{
            $response['msg']='No Skills found.'; 
            $response['data']= '';
            $response['status']= false; 
            }
        
        

      echo json_encode($response);
      exit;

    }
	

	public function userdata()

    {	
    	if(empty($this->request->data['id'])){


			$response['msg']='user id required';
			$response['status']= false;

    	}else{
    		$users = $this->Users->find('all', [
            'conditions' => ['Users.id' => $this->request->data['id']],
            'contain' => ['Userskills' => [
                'Categories'
            ]]
			]);

			$users = $users->first();
			if($users){
            $response['data']= $users;
            $response['baseurl'] =  Router::url('/', true) . 'images/users/';
			$response['status']= true;

			}else{
			$response['msg']='Invalid user id';	
			$response['data']= '';
			$response['status']= false;	
			}
		
    	}

      echo json_encode($response);
      exit;

    }


	public function logout() {

        if ($this->Auth->logout()) {

            return $this->redirect(['action' => 'login']);

        }

    }




    /**

     * Edit method

     *

     * @param string|null $id User id.

     * @return \Cake\Http\Response|null Redirects on successful edit, renders view otherwise.

     * @throws \Cake\Network\Exception\NotFoundException When record not found.

     */



    public function updatetoken()
    {
        $post=[];
        if ($this->request->is(['patch', 'post', 'put'])) {
            

            $post = $this->request->data; 

			if(empty($post['id'])){
				$response['status'] = false;
            	$response['msg'] = 'User id required.';
			}else{	

			$exit = $this->Users->find('all',['conditions'=>['Users.id'=>$post['id']]]);
			$exit = $exit->first();
			if ($exit) {			
    	
	        $user = $this->Users->get($post['id'], [

	            'contain' => []

            ]);
            $user = $this->Users->patchEntity($user, $post);
            $update = $this->Users->save($user);
            if ($update) {
                $response['status'] = true;
                $response['msg'] = 'User data has been updated.';
                $response['data'] = $update;

            }else{
                $response['status'] = false;
                $response['msg'] = 'The user could not be saved. Please, try again.';
                
            }
	        }else{
	        	$response['status'] = false;
            	$response['msg'] = 'Invalid user id.';
	        }
			}	
        }

        echo json_encode($post);
        exit;
    }

    public function edit()

    {
        $this->loadModel('Userskills'); 

        if ($this->request->is(['patch', 'post', 'put'])) {
            

            $post = $this->request->data; 
            $skill = explode(',', $this->request->data['skills']);
            
            //  print_r($this->request->data);
            // print_r($skill);
            //  exit();

			if(empty($post['id'])){
				$response['status'] = false;
            	$response['msg'] = 'User id required.';
			}else{	

			$exit = $this->Users->find('all',['conditions'=>['Users.id'=>$post['id']]]);
			$exit = $exit->first();
			if ($exit) {			
    	
	        $user = $this->Users->get($post['id'], [

	            'contain' => []

            ]);
            
            $this->Userskills->deleteAll(['user_id' => $this->request->data['id']]);
            $post1 = array();
            for ($i = 0; $i < count($skill); $i++) {
                $post1['cat_id'] = $skill[$i];
                $post1['user_id'] = $this->request->data['id'];
                $userskills = $this->Userskills->newEntity();
                $userSkills = $this->Userskills->patchEntity($userskills, $post1);
                $this->Userskills->save($userSkills);
            }     
            


             if($exit->image != $this->request->data['image']) {

             $uniquename = time().uniqid(rand()).'.png';
             $upload_path = WWW_ROOT . 'images/users/' . $uniquename;
          
             $userimage = base64_decode($post['image']);
             $success = file_put_contents($upload_path, $userimage);
             $post['image']= $uniquename;
             
             }

            $findbyemail = $this->Users->find('all',['conditions'=>['Users.phone'=>$post['phone']]]);
            $findbyemail = $findbyemail->first();
            if(empty($findbyemail)){

                  $user = $this->Users->patchEntity($user, $post);
                  $update = $this->Users->save($user);
                  if ($update) {
                        $response['status'] = true;
                        $response['msg'] = 'User data has been updated.';
                        $response['data'] = $update;

                    }else{
                        $response['status'] = false;
                        $response['msg'] = 'The user could not be saved. Please, try again.';
                       
                    }

            } else {

                if($post['id'] == $findbyemail['id']){
                    $user = $this->Users->patchEntity($user, $post);
                    $update = $this->Users->save($user);
                    if ($update) {
                        $response['status'] = true;
                        $response['msg'] = 'User data has been updated.';
                        $response['data'] = $update;

                    }else{
                        $response['status'] = false;
                        $response['msg'] = 'The user could not be saved. Please, try again.';
                       
                    }
                }else{
                    $response['status'] = false;
                    $response['msg'] = 'Phone already exist.';
                }
           
            }

	        }else{
	        	$response['status'] = false;
            	$response['msg'] = 'Invalid user id.';
	        }

           
			}	
        }

        echo json_encode($response);
        exit;
  

    }


    public function updateprofile()

    {
        
        if ($this->request->is(['patch', 'post', 'put'])) {
            
            $post = $this->request->data; 
			if(empty($post['id'])){
				$response['status'] = false;
            	$response['msg'] = 'User id required.';
			}else{	

			$exit = $this->Users->find('all',['conditions'=>['Users.id'=>$post['id']]]);
			$exit = $exit->first();
			if ($exit) {		
	        $user = $this->Users->get($post['id'], [
	            'contain' => []
            ]);

            if($user['city'] = '')
            {
                $post['city'] = 'undefined';
            }elseif ($user['city'] = 'undefined') {
                $post['city'] = '';
            }else{
                $post['city'] = 'undefined';
            }

            $to_time = strtotime(date("Y-m-d H:i:s"));
            $from_time = strtotime($user['modified']);
            $hours =  round(abs($to_time - $from_time) / 60);
             
                if($hours > 720){
                    $user = $this->Users->patchEntity($user, $post);
                    $update = $this->Users->save($user);
                    if ($update) {
                        $response['status'] = true;
                        $response['msg'] = 'User data has been updated.';
                        $response['data'] = $update;

                    }else{
                        $response['status'] = false;
                        $response['msg'] = 'The user could not be saved. Please, try again.';
                        
                    }
                }else{
                    $response['status'] = false;
                }
	        }else{
	        	$response['status'] = false;
            	$response['msg'] = 'Invalid user id.';
            }
        
            

           
			}	
        }
        echo json_encode($response);
        exit;
    }


    
     public function usersetting() { 

      $this->loadModel('Usersettings'); 
        if ($this->request->is('post')) { 

            if(empty($this->request->data['user_id'])){
                $response['status'] = false;
                $response['msg'] = 'User id required!.';    
            }else{

            $exist = $this->Usersettings->find('all',['conditions'=>['Usersettings.user_id'=>$this->request->data['user_id']]]);

             $exist = $exist->first();
            if($exist){

             foreach ($this->request->data['settingsdata'] as $key => $value) {

                 $this->Usersettings->updateAll(['value'=>"$value"],['key'=>$key,'user_id'=>$exist['user_id']]); 
   
                }

                $response['status'] = true;
                $response['msg'] = 'Settings updated!.';  

            }else{
                 
                 foreach ($this->request->data['settingsdata'] as $key => $value) {
                    $settings = $this->Usersettings->newEntity();
                    $post['key'] = $key;
                    $post['value'] = $value;
                    $post['user_id'] = $this->request->data['user_id'];   
                 $settings = $this->Usersettings->patchEntity($settings, $post);
                 $settingssave = $this->Usersettings->save($settings);
                 }

                $response['status'] = true;
                $response['msg'] = 'Settings save!.'; 

             }             

          

            }

        }

        echo json_encode($response);
        exit;
     }

	
 public function changepassword() {

        if ($this->request->is(['patch', 'post', 'put'])) {

        	$id = $this->request->data['id'];
			$exit = $this->Users->find('all',['conditions'=>['Users.id'=>$id]]);
			$exit = $exit->first();
			if ($exit) {	

	       		$user = $this->Users->get($exit['id'], [   
		            'contain' => []
		        ]);


            if ((new DefaultPasswordHasher)->check($this->request->data['oldpassword'], $user['password'])) {


                $user = $this->Users->patchEntity($user, $this->request->data);
                if ($this->Users->save($user)) {

                	$response['status'] = true;
            		$response['msg'] = 'Password Changed Successfully.';

                } else {

                	$response['status'] = false;
            		$response['msg'] = 'Invalid Password, Try again.';
                 
                }
            } else {


	            	$response['status'] = false;
	        		$response['msg'] = 'Old Password did not match.';
                
            }

	        }else{
	        	$response['status'] = false;
            	$response['msg'] = 'Invalid user id.';
	        }

		     
        }

        echo json_encode($response);
        exit;
    }



    public function forgot() {

        if ($this->request->is('post')) {

            $phone = $this->request->data['phone'];

            if(!empty($phone)){

            $user = $this->Users->find('all', ['conditions' => ['Users.phone' => $phone]]);
            $user = $user->first();
            if (empty($user)) {
            	$response['status'] = false;
            	$response['msg'] = 'Enter regsitered phone number to reset you password.';
            } else {

                if ($user->phone) {
                    $otp=$this->sendotp($this->request->data['phone']);
                    $this->Users->updateAll(array('tokenhash' => $otp), array('id' => $user->id));
	            	$response['status'] = true;
                    $response['msg'] = 'Otp send Successfully.';
                    $response['data'] = $user;
                     
                   
                } else {
                	$response['status'] = false;
	            	$response['msg'] = 'Phone number Is Invalid.';  
                   
                }
            }
           }else{

           			$response['status'] = false;
	            	$response['msg'] = 'Please enter your register Phone number.';  
           
           } 
        }

        echo json_encode($response);
        exit;
    }


    public function reset() {

        $phone = $this->request->data['phone'];
        $query = $this->Users->find('all', ['conditions' => ['Users.phone' => $phone]]);
        $data = $query->first();
        if ($data) {
            if ($this->request->is(['patch', 'post', 'put'])) {
                if ($this->request->data['password'] != $this->request->data['cpassword']) {
                    $response['status'] = false;
                    $response['msg'] = 'New password & confirm password does not match!.';
                    $response['data'] = ' ';
                }
                $this->request->data['tokenhash'] = md5(time() . rand(100000000, 999999999)); 
                $user = $this->Users->get($data->id, [
                    'contain' => []
                ]);
                $user = $this->Users->patchEntity($user, $this->request->getData());  

                if ($this->Users->save($user)) {
                    $response['status'] = true;
                    $response['msg'] = 'Your password has been changed.';
                } else {
                    $response['status'] = false;
                    $response['msg'] = 'Invalid Password, try again.';
                }
            }
        } 
        echo json_encode($response);
        exit;
    }
        

    public function searchdata()
    {
        
            $this->loadModel('Userskills'); 
            $this->loadModel('Categories'); 

            if ($this->request->is('post')) {

            $cat_id = explode(',', $this->request->data['skills']);
            $milles = $this->request->data['milles'];

            if(empty($this->request->data['latitude'])){
                $response['status'] = false;
                $response['msg'] = 'latitude id required!.';    
            }elseif(empty($this->request->data['longitude'])){
                $response['status'] = false;
                $response['msg'] = 'longitude id required!.';    
            }else{
               //$query = $this->Users->find('all');
               $user = TableRegistry::get('Users');
               $users = $user->find();
                $data = $users->where(['Users.role' => 'user'])
                ->select([
                    'distances' => $users->func()->get_distance_in_miles_between_geo_locations([
                    $this->request->data['latitude'],
                    $this->request->data['longitude'],
                        'Users.latitude' => 'identifier',
                        'Users.longitude' => 'identifier'  
                    ])
                ])
                ->select($user)
                ->having(['distances < ' => $milles])
                ->contain(['Userskills' => function ($q) use ($cat_id) {
                    return $q->where(['Userskills.cat_id IN' => $cat_id])
                    ->contain(['Categories']);
                }])->all(); 
                
                $response['data'] = $data;
                $response['status'] = true;
                $response['baseurl'] =  Router::url('/', true) . 'images/users/';
                $response['msg'] = 'user data';
            }
        }
       
            echo json_encode($response);
            exit;
    
    
    }


    public function pushnotification()
    { 
         $response = array(); 
         if ($this->request->is('post')) { 
          $user_id = $this->request->data['user_id']; 
          if(!empty($user_id)){
          $userdata = $this->Users->find('all',['contain'=>[],'conditions'=>['Users.id'=>$user_id]]);

          $userdata = $userdata->first();
         if($userdata){ 

         if($userdata['device_token']){  
            $status = '';

            if(($userdata['status'] == 1)){
                $status = 'Yours account has been activated';
            }else{
                $status = 'Yours profile has been deactivated.Please contact admin.';
            }  

            $send = $this->SendPushNotificationsAndroid($userdata['device_token'],'Test','This is test push notification.',$status);

           if($send){
             $response['msg'] = "Successfully send notification."; 
             $response['status'] = true;
           }else{
             $response['msg'] = "something worng.";
             $response['status'] = false;
           } 

          }else{
            $response['msg'] = "Device token required.";
            $response['status'] = false;   
          } 

         }else{
             $response['msg'] = "Invalid user";
             $response['status'] = false; 
         }  

        }else{
             $response['msg'] = "User id required";
             $response['status'] = false; 
        } 
       }

         echo json_encode($response);
         exit;
    }


    
    public function admindata()
    {   
            $this->loadModel('Settings');

            $setting = $this->Settings->find('all')->all();
            if($setting){
            $response['data']= $setting;
            $response['status']= true;

            }else{
            $response['msg']='No data found.'; 
            $response['data']= '';
            $response['status']= false; 
            }
      echo json_encode($response);
      exit;

    }


}

// public function searchdata()
//     {
        
//             $this->loadModel('Userskills'); 
//             $this->loadModel('Categories'); 

//             if ($this->request->is('post')) {

//             $cat_id = explode(',', $this->request->data['skills']);
//             $milles = $this->request->data['milles'];
            

//             if(empty($this->request->data['latitude'])){
//                 $response['status'] = false;
//                 $response['msg'] = 'latitude id required!.';    
//             }elseif(empty($this->request->data['longitude'])){
//                 $response['status'] = false;
//                 $response['msg'] = 'longitude id required!.';    
//             }else{
//                //$query = $this->Users->find('all');
//                $user = TableRegistry::get('Users');
//                $users = $user->find();
//                $distanceField = '(3959 * acos (cos ( radians(:latitude) )
//     * cos( radians( Users.latitude ) )
//     * cos( radians( Users.longitude )
//     - radians(:longitude) )
//     + sin ( radians(:latitude) )
//     * sin( radians( Users.latitude ) )))';
//                 $data = $users->where(['Users.role' => 'user'])
//                 ->select([
//                      'distances' => $distanceField
//                      ])
//                         ->having(['distances < ' => $milles])
//                         ->bind(':latitude', $this->request->data['latitude'], 'float')
//                         ->bind(':longitude', $this->request->data['longitude'], 'float')
//                         ->select($user)
//                         ->contain(['Userskills' => function ($q) use ($cat_id) {
//                         return $q->where(['Userskills.cat_id IN' => $cat_id])
//                         ->contain(['Categories']);
//                      }]);

//                 // ->select([
//                 //     'distance' => $users->func()->get_distance_in_miles_between_geo_locations([
//                 //     $this->request->data['latitude'],
//                 //     $this->request->data['longitude'],
//                 //         'Users.latitude' => 'identifier',
//                 //         'Users.longitude' => 'identifier'  
//                 //     ])
//                 // ])
//                 // ->select($user)
//                 // ->having(['distance < ' => $milles])
//                 // ->contain(['Userskills' => function ($q) use ($cat_id) {
//                 //     return $q->where(['Userskills.cat_id IN' => $cat_id])
//                 //     ->contain(['Categories']);
//                 // }]); 
//                 // print_r($data->toArray());
//                 // exit;
                
//                 $response['data'] = $data->toArray();
//                 $response['status'] = true;
//                 $response['baseurl'] =  Router::url('/', true) . 'images/users/';
//                 $response['msg'] = 'user data';
//             }
//         }
       
//             echo json_encode($response);
//             exit;
    
    
//     }
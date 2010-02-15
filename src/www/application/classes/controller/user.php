<?php defined('SYSPATH') or die('No direct script access.');

class Controller_User extends Controller_Template_Serverstats {
	
	protected $current_user;
	
	public function before()
    {
        parent::before();

        // Setup a user model
        $this->current_user = new Model_User;
       // var_dump()
    }
	

	public function action_index()
	{
		echo 'ha';
	}
	
	/**
	 * Register a user
	 * 
	 */
	public function action_register()
	{
		$this->template->content = View::factory('user/register')
			->bind('post', $post)
			->bind('errors', $errors);

		$post = Validate::factory($_POST)
			// Trim all fields
			->filter(TRUE, 'trim')
			// Rules for email address
			->rule('u_email', 'not_empty')
			->rule('u_email', 'email')
			->callback('u_email', array($this, 'do_unique_email'))
			// Rules for password
			->rule('u_password', 'not_empty')
			->rule('u_password', 'min_length', array('5'));

		if ($post->check())
		{
			// Register the user
			$this->current_user->u_email = $post['u_email'];
			$this->current_user->u_password = $this->current_user->hash($post['u_password']);
			$this->current_user->save();
			
			// Saved
			echo ' User saved (u_id = '.$this->current_user->u_id.')';
			
			// Redirect to the thanks page
			//$this->request->redirect(url::site($this->request->uri(array('action' => 'thanks'))));
		}
		else
		{
			$errors = $post->errors('forms/contact');
		}
	}
	
	/**
	 * Check to see if the email address is unique
	 * @param $array
	 * @param $field
	 * @param $errors
	 * @return unknown_type
	 */
	public function do_unique_email(Validate $array, $field)
	{
		if (isset($array['u_email']))
		{
			if ($this->current_user->email_exists($array['u_email']))
			{
				// Email is not unique, so they have already registered with that email
				$array->error($field, 'unique_email', array($array[$field]));
			}
		}
	}
} // End Controller_User
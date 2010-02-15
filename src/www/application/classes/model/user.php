<?php defined('SYSPATH') or die('No direct script access.');

class Model_User extends Model {
	
	public $u_id;
	public $u_email;
	public $u_password;
	public $u_type = 'normal';
	private $salt = 'klsjf*&%sdfsdf90890(*)(*0)(*)(*+ + + + +==mapghjwg2k49(JlLh4gGl3m35LlklKLKLk??$#$#$#$dfs sd sdfsd';
	
	
	public function email_exists($email)
	{
		return (bool) DB::select(array('COUNT("u_id")', 'u_count'))
						->from('Users')
						->where('u_email', '=', $email)
						->execute($this->_db)
						->get('u_count');
	}
	
	
	public function hash($str)
	{
		return sha1($str.$this->salt);
	}
	
	public function save()
	{
		try 
		{
			list($this->u_id) = DB::insert('Users', array('u_email','u_password','u_type'))
		          ->values(array($this->u_email,$this->u_password,$this->u_type))
		          ->execute();
		}
		catch ( Database_Exception $e )
		{
		      echo $e->getMessage();
		}
	}
}
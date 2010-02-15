<?php defined('SYSPATH') or die('No direct script access.');

abstract class Controller_Template_Serverstats extends Controller_Template {


	public function before()
	{
		parent::before();

		$this->template->title = '';
		$this->template->content = '';

	}

	public function after()
	{
		parent::after();
	}

} // End Controller_Template_Serverstats
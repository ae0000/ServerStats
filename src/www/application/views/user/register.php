<?php echo form::open(NULL) ?>

	<?php include Kohana::find_file('views', 'template/errors') ?>

	<dl>
		<dt><?php echo form::label('u_email', 'Email address (used to login)') ?></dt>
		<dd><?php echo form::input('u_email', $post['u_email']) ?></dd>

		<dt><?php echo form::label('u_password', 'Password') ?></dt>
		<dd><?php echo form::password('u_password', $post['u_password']) ?></dd>

		<dd class="submit"><?php echo form::button(NULL, 'Register', array('type' => 'submit')) ?></dd>
	</dl>

<?php echo form::close() ?>

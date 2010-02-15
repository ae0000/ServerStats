<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US">
  <head profile="http://gmpg.org/xfn/11">
      <title><?php echo $title ?></title>
      <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  </head>
  <body>
    <?php echo $content ?>
    <div id="kohana-profiler">
		<?php echo View::factory('profiler/stats') ?>
	</div>
  </body>
  </html>
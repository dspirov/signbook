#!/usr/bin/perl

use strict;
use warnings;
use utf8;

use Tk;
use MyDB::Main;
use Tk::Signbook;
use Config::IniFiles;


my $config;
die('Missing file default.ini') unless(-e 'default.ini');
# if present, signbook.ini overrides default.ini
if(-e 'signbook.ini')
{
	$config=Config::IniFiles->new('-file'=>'signbook.ini',
			'-import'=> Config::IniFiles->new('-file'=>'default.ini') );
}
else {
	$config=Config::IniFiles->new('-file'=>'default.ini');
}

my $schema=MyDB::Main->connect($config->val('Database','dbname'),
						$config->val('Database','username'),
						$config->val('Database','password'),
						{ 'mysql_enable_utf8'=>1 });


my $w=Tk::Signbook->new();
$w->configure('-title'=> 'Signbook');
$w->SetSchema($schema);

MainLoop();


use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'Module::Build' => '0.3601'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Parse Org documents',
  'dist_author' => [
    'Steven Haryanto <stevenharyanto@gmail.com>'
  ],
  'dist_name' => 'Org-Parser',
  'dist_version' => '0.10',
  'license' => 'perl',
  'module_name' => 'Org::Parser',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'DateTime' => '0',
    'DateTime::Event::Recurrence' => '0',
    'File::Slurp' => '0',
    'Log::Any' => '0',
    'Moo' => '0',
    'String::Escape' => '0',
    'Sub::Spec::CmdLine' => '0.26',
    'Test::More' => '0.96',
    'perl' => '5.010000'
  },
  'script_files' => [
    'bin/dump-org-structure',
    'bin/remind-due-todos'
  ]
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;

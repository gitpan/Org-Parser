
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601",
    "Test::Exception" => 0,
    "Test::More" => "0.96"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Parse Org documents",
  "dist_author" => [
    "Steven Haryanto <stevenharyanto\@gmail.com>"
  ],
  "dist_name" => "Org-Parser",
  "dist_version" => "0.34",
  "license" => "perl",
  "module_name" => "Org::Parser",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "DateTime" => 0,
    "DateTime::Event::Recurrence" => 0,
    "File::Slurp" => 0,
    "Log::Any" => 0,
    "Module::List" => 0,
    "Moo" => 0,
    "String::Escape" => 0,
    "experimental" => 0,
    "perl" => "5.010001"
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'Cobsy',
  VERSION_FROM => 'lib/Cobsy.pm',
  ABSTRACT => 'Component-object system providing loadable runtime packages',
  AUTHOR => 'Bremen Braun <konapun.zero@gmail.com>',
  LICENSE => 'MIT',
  META_MERGE => {
    resources => {
      license => 'http://opensource.org/licenses/MIT',
      repository => 'https://github.com/konapun/arkess.git'
    },
    no_index => {
      directory => ['t']
    }
  },
  PREREQ_PM => {
    # TODO
  }
);

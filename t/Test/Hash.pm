package Test::Hash;

use strict;

sub new {
  my $package = shift;
  my ($key, $val) = @_;

  return bless {
    key => $key,
    val => $val
  }, $package;
}

sub getKey {
  return shift->{key};
}

sub getValue {
  return shift->{val};
}

1;

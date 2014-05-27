package Test::Evented;

use strict;
use base qw(Cobsy::Component);

sub afterInstall {
  my ($self, $owner) = @_;

  # Need to make sure this doesn't alter the "base" object...
  $owner->methods->each(sub {
    my ($key, $val) = @_;

    $owner->methods->set($key, sub {
      print "BEFORE $key\n";
      return $val->call(@_);
      print "AFTER $key\n";
    })
  });
}

1;

package Test::Priority2;

use strict;
use base qw(Cobsy::Component);

sub setPriority {
  return 3;
}

sub exportMethods {
  return {
    'doThing' => sub {
      print "Doing the thing!\n";
    }
  };
}

1;

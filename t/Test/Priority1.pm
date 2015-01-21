package Test::Priority1;

use strict;
use base qw(Cobsy::Component);

sub setPriority {
  return 2;
}

sub exportMethods {
  return {
    'doThing' => sub {
      die "Not implemented here"
    }
  };
}

1;

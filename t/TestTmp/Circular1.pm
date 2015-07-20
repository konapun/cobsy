package TestTmp::Circular1;

use strict;
use base qw(Cobsy::Component);

sub requires {
  return [
    'TestTmp::Circular2'
  ]
}

1;

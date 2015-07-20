package TestTmp::Circular3;

use strict;
use base qw(Cobsy::Component);

sub requires {
  return [
    'TestTmp::Circular1'
  ]
}

1;

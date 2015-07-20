package TestTmp::Circular2;

use strict;
use base qw(Cobsy::Component);

sub requires {
  return [
    'TestTmp::Circular3'
  ]
}

1;

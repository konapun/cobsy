package TestTmp::Guy;

use strict;
use base qw(Cobsy::Component);

sub requires {
  return {
    'TestTmp::Named' => 'guy',
    'TestTmp::Aged'  => 100
  }
}

1;

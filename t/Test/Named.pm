package Test::Named;

use strict;
use base qw(Cobsy::Component);

sub exportAttributes {
  return {
    name => 'konapun'
  }
}

1;

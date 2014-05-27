package Test::Setter;

use strict;
use base qw(Cobsy::Component);

sub exportMethods {
  return {
    set => sub {
      my ($cob, $key, $val) = @_;

      $cob->attributes->set($key, $val);
    }
  }
}

1;

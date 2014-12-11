package Test::Again::SuperAwesomeComponent;

use strict;
use base qw(Cobsy::Component);

sub exportMethods {
  return {
    testAwesome => sub {
      print "Gnarladelic!\n";
    }
  }
}
1;

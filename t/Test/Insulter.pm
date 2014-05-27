package Test::Insulter;

use strict;
use base qw(Cobsy::Component);

sub exportMethods {
  return {
    insult => sub {
      print "I hurl insults in your general direcion!\n";
    }
  }
}

1;

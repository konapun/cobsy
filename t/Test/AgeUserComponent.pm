package Test::AgeUserComponent;

use strict;
use base qw(Cobsy::Component);

sub requires {
  return {
    'Test::AgeComponent' => 23
  };
}

sub exportMethods {
  return {
    sayAge => sub {
      my $cob = shift;

      print "I'm " . $cob->getAge() . " years old!\n";
    }
  };
}

1;

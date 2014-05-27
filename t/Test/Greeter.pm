package Test::Greeter;

use strict;
use base qw(Cobsy::Component);

sub requires {
  return [
    'Test::Getter',
    'Test::Named'
  ];
}

sub exportMethods {
  return {
    greet => sub {
      my $cob = shift;
      
      return "Hello, from " . $cob->get('name') . "!\n";
    }
  };
}

1;

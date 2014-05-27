package Test::Health;

use strict;
use base qw(Cobsy::Component);

sub initialize {
  print "INITIALIZING\n";
}

sub requires {
  return [
    'Test::Getter',
    'Test::Setter'
  ];
}

sub exportAttributes {
  return {
    hp => 100
  }
}

sub exportMethods {
  return {
    takeDamage => sub {
      my ($cob, $damage) = @_;
      $damage = 1 unless defined $damage;

      return $cob->set('hp', $cob->get('hp') - $damage);
    },
    getHealth => sub {
      return shift->get('hp');
    }
  }
}

1;

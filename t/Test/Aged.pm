package Test::Aged;

use strict;
use base qw(Cobsy::Component);

sub requires {
  return [
    'Test::Getter'
  ];
}

sub initialize {
  my ($self, $age) = @_;

  $age = 50 unless defined $age;
  $self->{age} = $age;
}

sub exportAttributes {
  my $self = shift;

  return {
    age => $self->{age}
  };
}

sub exportMethods {
  return {
    getAge => sub {
      my $cob = shift;

      return $cob->get('age');
    }
  };
}

1;

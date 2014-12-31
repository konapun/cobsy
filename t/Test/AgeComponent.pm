package Test::AgeComponent;

use strict;
use base qw(Cobsy::Component);

sub initialize {
  my ($self, $age) = @_;

  die "Must provide age!" unless defined $age;
  $self->{age} = $age;
}

sub exportMethods {
  my $self = shift;

  return {
    getAge => sub {
      return $self->{age};
    }
  };
}

1;

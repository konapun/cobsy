package TestTmp::Aged;

use strict;
use base qw(Cobsy::Component);

sub initialize {
  my ($self, $age) = @_;

  $age ||= '999';
  $self->{age} = $age;
}

sub exportAttributes {
  return {
    aged => 1
  }
}

sub exportMethods {
  my $self = shift;

  return {
    getAge => sub {
      return $self->{age};
    }
  }
}

1;

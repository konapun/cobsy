package TestTmp::Named;

use strict;
use base qw(Cobsy::Component);

sub initialize {
  my ($self, $name) = @_;

  $name ||= '(unknown)';
  $self->{name} = $name;
}

sub exportAttributes {
  return {
    named => 1
  }
}

sub exportMethods {
  my $self = shift;

  return {
    getName => sub {
      return $self->{name};
    }
  }
}

1;

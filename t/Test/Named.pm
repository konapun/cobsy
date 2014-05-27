package Test::Named;

use strict;
use base qw(Cobsy::Component);

sub initialize {
  my ($self, $name) = @_;

  $name = 'konapun' unless defined $name;
  $self->{name} = $name;
}

sub exportAttributes {
  my $self = shift;
  
  return {
    name => $self->{name}
  }
}

1;

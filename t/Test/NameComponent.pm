package Test::NameComponent;

use strict;
use base qw(Cobsy::Component);

sub initialize {
  my ($self, $name) = @_;

  $self->{name} = defined $name ? $name : 'shy guy';
}

sub exportMethods {
  my $self = shift;
  
  return  {
    getName => sub {
      return $self->{name}
    }
  };
}

1;

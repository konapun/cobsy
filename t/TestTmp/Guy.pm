package TestTmp::Guy;

use strict;
use base qw(Cobsy::Component);

sub requires {
  return {
    'TestTmp::Named' => 'guy',
    'TestTmp::Aged'  => 100
  }
}

sub iniitialize {
  my ($self, $name, $age) = @_;

  $self->setDefault('name', $name);
  $self->setDefault('age', $age);
}

1;

package Cobsy::Component;

use strict;

# Installs this component into a Cobsy::Object
sub install {
  my ($self, $cob) = @_;

  foreach my $require (@{$self->requires()}) {
    $require->new()->install($cob);
  }

  my $attributes = $self->exportAttributes();
  my $methods = $self->exportMethods();
  $attributes->each(sub {
    my ($key, $val) = @_;
    $cob->attributes->set($key, $val);
  });
  $methods->each(sub {
    my ($key, $val) = @_;
    $cob->methods->set($key, $val);
  })
}

sub initialize {}

sub requires {
  return [];
}

sub exportAttributes {
  return {};
}

sub exportMethods {
  return {};
}

1;

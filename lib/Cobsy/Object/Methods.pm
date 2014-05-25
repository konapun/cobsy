package Cobsy::Object::Methods;

use strict;
use Cobsy::Core::Method;
use base qw(Cobsy::Core::Hash);

sub new {
  my $package = shift;
  my $owner = shift;
  my $self = $package->SUPER::new(@_);

  $self->{owner} = $owner;
  return $self;
}

sub add {
  my ($self, $method) = @_;

  $self->SUPER::set($method->registersAs(), $method);
}

sub set {
  my ($self, $name, $sub) = @_;
  
  my $method = Cobsy::Core::Method->new($self->{owner}, $name, $sub);
  return $self->add($method);
}

sub clone {
  my $self = shift;

  my $clone = $self->SUPER::clone();
  $clone->{owner} = $self->{owner};
  return $clone;
}

1;

package Cobsy::Object;

use strict;

sub new {
  my $package = shift;

  return bless {
    attributes => Datastructure::Hash->new(),
    methods    => Datastructure::Hash->new()
  }, $package;
}

sub attributes {
  return shift->{attributes};
}

sub methods {
  return shift->{methods};
}

sub extend {
  my ($self, $components) = @_;

  my $clone = $self->clone();
  if (ref($components) eq 'HASH') {
    $clone = $self->_extendWithHash($clone, $components);
  }
  else {
    $clone = $self->_extendWithComponents($clone, $components);
  }

  return $clone;
}

sub _extendWithComponents {
  my ($self, $clone, $components) = @_;

  $components = [$components] unless ref($components) eq 'ARRAY';
  foreach my $component (@$components) {
    my $instance = $component->new();
    $component->install($clone);
  }
  return $clone;
}

sub _extendWithHash {
  my ($self, $clone, $hash) = @_;

  die "Extending via hash currently unsupported";
}

sub clone {
  my $self = shift;

  my $clone = __PACKAGE__->new();
  $clone->{attributes} = $self->{attributes}->clone();
  $clone->{methods} = $self->{methods}->clone();
  return $clone;
}

1;

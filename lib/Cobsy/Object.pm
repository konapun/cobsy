package Cobsy::Object;

use strict;
use Cobsy::Core::List;
use Cobsy::Core::Hash;

sub new {
  my $package = shift;

  return bless {
    attributes => Cobsy::Core::Hash->new(),
    methods    => Cobsy::Core::Hash->new()
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

sub AUTOLOAD {
  my $name = ($Cobsy::Object::AUTOLOAD =! /Cobsy::Object::(.*?)$/)[0];
  my ($self, @args) = @_;

  die "Lookup failed for method \"$name\": No component registered \"$name\"" unless $self->{methods}->has($name);
  return $self->{methods}->get($name)->call(@args);
}

sub DESTROY {} # keep AUTOLOAD from being called when this object is destroyed

1;

__END__

=head1 NAME
Cobsy::Object - An object which supports components

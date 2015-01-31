package Cobsy::Core::Loader;

use strict;

sub new {
  my $package = shift;

  return bless {}, $package;
}

sub load {
  my ($self, $clone, $components) = @_;

  if (!($components eq undef)) {
    if (ref($components) eq 'HASH') { # When components are initialized, they'll use arguments passed in via the hash
      $clone = $self->_loadComponentHash($clone, $components);
    }
    else { # Use default initialization
      $clone = $self->_loadComponentList($clone, $components);
    }
  }

  return $clone;
}

sub _loadComponentHash {
  my ($self, $clone, $hash) = @_;

  my @instantiatedComponents;
  Cobsy::Core::Hash->new($hash)->each(sub {
    my ($component, $args) = @_;

    eval "require $component";
    $args = [$args] unless ref($args) eq 'ARRAY'; # make sure args is an array
    my $instance = $component->new(@$args);
    push(@instantiatedComponents, $instance);
  });

  my @orderedComponents = sort { $a->setPriority() <=> $b->setPriority() } @instantiatedComponents;
  $_->install($clone) foreach @orderedComponents;
  return $clone;
}

sub _loadComponentList {
  my ($self, $clone, $components) = @_;

  my @instantiatedComponents;
  $components = [$components] unless ref($components) eq 'ARRAY';
  foreach my $component (@$components) {
    eval "require $component";

    my $instance = $component->new();
    push(@instantiatedComponents, $instance);
  }

  my @orderedComponents = sort { $a->setPriority() <=> $b->setPriority() } @instantiatedComponents;
  $_->install($clone) foreach @orderedComponents;
  return $clone;
}

1;

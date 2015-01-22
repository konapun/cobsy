package Cobsy::Object;

use strict;
use Carp;
use Cobsy::Core::Hash;
use Cobsy::Object::Methods;

sub new {
  my $package = shift;
  my $components = shift;

  my $self = bless {
    attributes => Cobsy::Core::Hash->new()
  }, $package;
  $self->{methods} = Cobsy::Object::Methods->new($self);

  $self = $self->extend($components) unless $components eq undef;
  return $self;
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
  if (!($components eq undef)) {
    if (ref($components) eq 'HASH') { # When components are initialized, they'll use arguments passed in via the hash
      $clone = $self->_extendWithComponentArguments($clone, $components);
    }
    else { # Use default initialization
      $clone = $self->_extendWithComponents($clone, $components);
    }
  }

  return $clone;
}

sub clone {
  my $self = shift;

  my $callerClass = ref $self;
  my $clone = __PACKAGE__->new();
  $clone->{attributes} = $self->{attributes}->clone(1);
  $clone->{methods} = $self->{methods}->clone($clone);
  return bless $clone, $callerClass; # Rebless into calling class in order to allow Object subclassing
}

sub AUTOLOAD {
  my $name = ($Cobsy::Object::AUTOLOAD =~ /[a-zA-Z]+::[a-zA-Z]+::(.*?)$/)[0];
  my ($self, @args) = @_;

  confess "Lookup failed for method \"$name\": No component registered \"$name\"" unless $self->{methods}->has($name);
  return $self->{methods}->get($name)->call(@args);
}

sub DESTROY {} # keep AUTOLOAD from being called when this object is destroyed

sub _extendWithComponents {
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

sub _extendWithComponentArguments {
  my ($self, $clone, $componentsHash) = @_;

  my @instantiatedComponents;
  Cobsy::Core::Hash->new($componentsHash)->each(sub {
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

# Allow exports via hash without having to create a component
sub _extendWithHash {
  my ($self, $clone, $hash) = @_;

  die "Extending via hash currently unsupported";
}

1;

__END__

=head1 NAME
Cobsy::Object - An object which supports components

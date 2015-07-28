package Cobsy::Object;

use strict;
use Carp;
use Cobsy::Core::Hash;
use Cobsy::Object::Methods;
use Cobsy::Core::Loader;

sub new {
  my $package = shift;
  my $components = shift;

  my $self = bless {
    components => {}, # each key is the component ref to prevent duplicates from being installed
    attributes => Cobsy::Core::Hash->new(),
    loader     => Cobsy::Core::Loader->new()
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

sub components {
  return keys %{$self->{components}};
}

sub installComponent {
  my ($self, $component) = @_;

  my $reqs = $component->requires();
  $self->{loader}->load($self, $reqs);
  $component->beforeInstall($self);

  my $attributes = Cobsy::Core::Hash->new($component->exportAttributes());
  my $methods = Cobsy::Core::Hash->new($component->exportMethods());
  $attributes->each(sub {
    my ($key, $val) = @_;
    $self->attributes->set($key, $val);
  });
  $methods->each(sub {
    my ($key, $val) = @_;
    $self->methods->set($key, $val);
  });

  $component->afterInstall($self);
  $self->{components}->{ref $component} = $component;
  return $self;
}

sub extend {
  my ($self, $components) = @_;

  my $clone = $self->clone();
  if (!($components eq undef)) {
    $self->{loader}->load($clone, $components);
  }

  return $clone;
}

sub clone {
  my $self = shift;

  my $callerClass = ref $self;
  my $clone = __PACKAGE__->new();
  my @orderedComponents = sort { $a->setPriority() <=> $b->setPriority() } values %{$self->{components}};
  foreach my $component (@orderedComponents) {
    my $cc = $component->clone();
    $clone->installComponent($cc);
  }

  return bless $clone, $callerClass; # Rebless into calling class in order to allow Object subclassing
}

sub AUTOLOAD {
  my $name = ($Cobsy::Object::AUTOLOAD =~ /[a-zA-Z]+::[a-zA-Z]+::(.*?)$/)[0];
  my ($self, @args) = @_;

  confess "Lookup failed for method \"$name\": No component registered \"$name\"" unless $self->{methods}->has($name);
  return $self->{methods}->get($name)->call(@args);
}

sub DESTROY {} # keep AUTOLOAD from being called when this object is destroyed

1;

__END__

=head1 NAME
Cobsy::Object - An object which supports components

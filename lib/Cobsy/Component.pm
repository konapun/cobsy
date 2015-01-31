package Cobsy::Component;

use strict;
use Cobsy::Core::Hash;
use Cobsy::Core::Loader;

sub new {
  my $package = shift;
  my @args = @_;

  my $self = bless {
    owner  => undef, # object this component installs into
    loader => Cobsy::Core::Loader->new()
  }, $package;

  $self->initialize(@args);
  return $self;
}

# Installs this component into a Cobsy::Object
sub install {
  my ($self, $cob) = @_;

  $self->{owner} = $cob;
  my $reqs = $self->requires();
  $self->{loader}->load($cob, $reqs);

  my $attributes = Cobsy::Core::Hash->new($self->exportAttributes());
  my $methods = Cobsy::Core::Hash->new($self->exportMethods());
  $attributes->each(sub {
    my ($key, $val) = @_;
    $cob->attributes->set($key, $val);
  });
  $methods->each(sub {
    my ($key, $val) = @_;
    $cob->methods->set($key, $val);
  });

  $self->afterInstall($self->{owner});
}

sub clone {
  my $self = shift;

  my $clone = __PACKAGE__->new();
  return $clone;
}

#          COMPONENTS CAN OVERRIDE METHODS BELOW THIS POINT          #

# Code to run once this component is created
sub initialize {}

# Code to run after this component is installed into the cob
sub afterInstall {
  my ($self, $cob) = @_;
}

# A list of components required by this component. Can also return a hash which
# initializes components with hash values
sub requires {
  return [];
}

# Priority in which this component should be loaded during a `require` or when
# loading into a cob. A higher number indicates a higher priority
sub setPriority {
  return 1; # lowest priority by default
}

# Attributes to be exported into the cob to be installed into
sub exportAttributes {
  return {};
}

# Methods to be exported into the cob to be installed into
sub exportMethods {
  return {};
}

1;

__END__

=head1 NAME

Cobsy::Component - A mixin system for Cobsy::Object

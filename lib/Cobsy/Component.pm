package Cobsy::Component;

use strict;
use Cobsy::Core::Hash;

sub new {
  my $package = shift;
  my @args = @_;

  my $self = bless {
    args => [@args]
  }, $package;

  $self->initialize(@args);
  return $self;
}

sub clone {
  my $self = shift;

  my $ref = ref $self;
  my $clone = $ref->new(@{$self->{args}});
  return $clone;
}

#          COMPONENTS CAN OVERRIDE METHODS BELOW THIS POINT          #

# Code to run once this component is created
sub initialize {}

# Code to run before this component is sintalled into the cob
sub beforeInstall {
  my ($self, $cob) = @_;
}

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

package Cobsy::Component;

use strict;
use Cobsy::Core::Hash;

sub new {
  my $package = shift;
  my @args = @_;

  my $self = bless {
    owner     => undef, # object this component installs into
  }, $package;

  $self->initialize(@args);
  return $self;
}

# Installs this component into a Cobsy::Object
sub install {
  my ($self, $cob) = @_;

  $self->{owner} = $cob;
  foreach my $require (@{$self->requires()}) {
    eval "require $require";

    $require->new()->install($cob);
  }

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
sub initialize {}

sub afterInstall {
  my ($self, $cob) = @_;
}

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

__END__

=head1 NAME

Cobsy::Component - A mixin system for Cobsy::Object

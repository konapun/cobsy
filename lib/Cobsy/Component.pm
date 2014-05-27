package Cobsy::Component;

use strict;
use Cobsy::Core::Hash;

sub new {
  my $self = bless {
    owner     => undef, # object this component installs into
    isEnabled => 1
  }, shift;

  $self->initialize();
  return $self;
}

sub isEnabled {
  return shift->{isEnabled};
}

sub disable {
  my $self = shift;

  return unless $self->isEnabled();
  my $owner = $self->{owner};
  if ($owner) {
    # TODO: Unregister attributes and methods from this
  }
  $self->{isEnabled} = 0;
}

sub enable {
  my $self = shift;

  return if $self->isEnabled();
  my $owner = $self->{owner};
  if ($owner) {
    # TODO: Re-register attributes
  }
  $self->{isEnabled} = 1;
}

sub toggle {
  my $self = shift;

  $self->isEnabled() ? $self->disable() : $self->enable();
}

# Installs this component into a Cobsy::Object
sub install {
  my ($self, $cob) = @_;

  $self->{owner} = $cob;
  foreach my $require (@{$self->requires()}) {
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

sub provides {
  my $self = shift;

  my $attrs = $self->exportAttributes();
  my $methods = $self->exportMethods();
  return $attrs->keys()->merge($methods->keys());
}

sub clone {
  my $self = shift;

  my $clone = __PACKAGE__->new();
  $clone->disable() unless $self->isEnabled();
  return $clone;
}

# Override this to set a specific registration name. Else, package will register
# as the package name, replacing camel case with hyphens
# (packageName -> package-name)
sub registersAs {
  my $self = shift;

  my $componentName = ($self =~ /.+::(.+)$/)[0];
  my $registrationName = lc $componentName; # TODO: replace camel-case with dash and return

  return $registrationName;
}

#          COMPONENTS CAN OVERRIDE METHODS BELOW THIS POINT          #
sub initialize {}

sub afterInstall {}

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

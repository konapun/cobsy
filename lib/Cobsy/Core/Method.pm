package Cobsy::Core::Method;

use strict;

sub new {
  my $package = shift;
  my ($caller, $name, $function) = @_;

  return bless {
    caller   => $caller,
    name     => $name,
    function => $function
  }, $package;
}

sub registersAs {
  return shift->{name};
}

sub call {
  my ($self, @args) = @_;

  my $caller = $self->{caller};
  return $self->{function}->($caller, @args);
}

1;

__END__

=head1 NAME

Cobsy::Core::Method

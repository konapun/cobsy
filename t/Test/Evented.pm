package Test::Evented;

use strict;
use base qw(Cobsy::Component);

sub afterInstall {
  my ($self, $owner) = @_;

  # Need to make sure this doesn't alter the "base" object...
  $owner->methods->each(sub {
    my ($key, $val) = @_;

    $owner->methods->set($key, sub {
      print "BEFORE $key\n";
      my $return = $val->call(@_);
      print "AFTER $key\n";
      return $return;
    });
  });
}

sub exportAttributes {
  return {
    events => {}
  };
}

sub exportMethods {
  my $self = shift;

  return {
    on => sub {
      my ($cob, $event, $callback) = @_;

      $self->{events}->{$event} = $callback;
    },
    trigger => sub {
      my ($cob, $event, @args) = @_;

      return $self->{events}->{$event}->(@args);
    }
  };
}

1;

package Test::Getter;

use strict;
use base qw(Cobsy::Component);

sub exportAttributes {
  return {
    name => 'konapun'
  }
}

sub exportMethods {
  return {
    get => sub {
      my ($obj, $key) = @_;

      die "Can't get attribute \"$key\": no such attribute" unless $obj->attributes->has($key);
      return $obj->attributes->get($key);
    }
  };
}

1;

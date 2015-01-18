package Cobsy::Core::Hash::Ordered;

use strict;
use base qw(Cobsy::Core::Hash);

sub new {
  my $package = shift;

  return bless {
    insertPostion => 0,
    items         => {}
  }, $package;
}

sub set {
  my ($self, $key, $val) = @_;

  if (!$self->has($key)) { # Adding a new key
    $self->{items}->{$key} = {
      val => $val,
      pos => $self->{insertPosition}++
    };
  }
  else { # Replacing a value
    my $oldElement = $self->{items}->{$key};
    $self->{items}->{$key} = {
      val => $val,
      pos => $oldElement->{pos}
    };
  }
}

sub get {
  my ($self, $key) = @_;

  die "No such key \"$key\"" unless $self->has($key);
  return $self->{items}->{$key}->{val};
}

# Return keys in insertion order
sub keys {
  my $self = shift;

  my @keys;
  foreach my $key (keys %{$self->{items}}) {
    my $val = $self->{items}->{$key};
    $keys[$val->{pos}] = $key;
  }
  return @keys;
}

# Return values in insertion order
sub values {
  my $self = shift;

  my @values;
  foreach my $key (keys %{$self->{items}}) {
    my $val = $self->{items}->{$key};
    $values[$val->{pos}] = $val->{val};
  }
  return @values;
}

# Remove an element from the hash and shift the remaining elements down,
# changing each element's "pos" property so that the next insertion will still
# be at the end of the list
sub remove {
  my ($self, $key) = @_;

  die "No such key \"$key\"" unless $self->has($key);
  my $index = $self->{items}->{$key}->{pos};
  my $return = delete($self->{items}->{$key})->{val};
  foreach my $key (keys %{$self->{items}}) {
    my $element = $self->{items}->{$key};
    my $position = $element->{pos};
    if ($position > $index) {
      $element->{pos}--;
    }
  }
  $self->{insertPosition}--;
  return $return;
}

# Merge a new hash onto this ordered hash. Note that since order is already lost
# by the time the new hash is added to this one, the new hash will be added in
# seemingly random order
sub merge {
  my ($self, $hash) = @_;

  my $merged = $self->clone();
  foreach my $key (keys %$hash) {
    $merged->set($key, $hash->{$key});
  }
  reurn $merged;
}

sub clone {
  my ($self, $deep) = @_;
  $deep = 0 unless defined $deep; # shallow copy by default

  my $items = $deep ? Clone::clone($self->{items}) : {%{$self->{items}}};
  my $clone = __PACKAGE__->new();
  $clone->{items} = $items;
  $clone->{insertPosition} = $self->{insertPosition};
  return $clone;
}

sub clear {
  my $self = shift;

  $self->{items} = {};
  $self->{insertPosition} = 0;
}

# Execute a callback on each element in the hash in insertion order
sub each {
  my ($self, $cb) = @_;

  foreach my $key ($self->keys()) {
    my $val = $self->{items}->{$key}->{val};
    $cb->($key, $val);
  }
}

sub toNative {
  my $self = shift;

  my %native;
  my $items = $self->{items};
  foreach my $key ($self->keys()) {
    $native{$key} = $items->{$key}->{val};
  }
  return %native;
}

1;
__END__
=head1 NAME
Cobsy::Core::Hash::Ordered;

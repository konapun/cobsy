package Cobsy::Core::List;

use strict;

sub new {
  my $package = shift;
  my $items = shift;

  my $length = 0; # keep track of length manually for O(1) instead of O(n) lookup
  $items = $items || [];
  $length = scalar(@$items);
  return bless {
    items  => $items,
    length => $length
  }, $package;
}

sub firstIndex {
  my ($self, $searchItem) = @_;

  my $index = 0;
  foreach my $item (@{$self->{items}}) {
    if ($searchItem eq $item) {
      return $index;
    }

    $index++;
  }
  return -1;
}

sub removeFirst {
  my ($self, $value) = @_;

  die "Unimplemented";
}

sub removeAtIndex {
  my ($self, $index) = @_;

  die "Index out of bounds" unless $index >= 0 && $index < $self->{length};
  die "Unimplemented";
}

sub at {
  my ($self, $index) = @_;

  die "Index out of range" if $index < 0 || $index > $self->length()-1;
  return $self->{items}->[$index];
}

sub length {
  return shift->{length};
}

sub contains {
  my ($self, $element) = @_;

  my %hash = map { $_ => 1 } @{$self->{items}};
  return exists($hash{$element});
}

sub push {
  my ($self, $element) = @_;

  push(@{$self->{items}}, $element);
  $self->{length}++;
  return $element;
}

sub merge {
  my ($self, $array) = @_;

  my $merged = $self->clone();
  $array->forEach(sub {
    $merged->push(shift);
  });

  return $merged;
}

sub pop {
  my $self = shift;

  my $element = pop @{$self->{items}};
  $self->{length}-- if defined $element;
  return $element;
}

sub shift {
  my $self = shift;

  my $element = shift @{$self->{items}};
  $self->{length}-- if defined $element;
  return $element;
}

sub unshift {
  my ($self, $item) = @_;

  unshift(@{$self->{items}}, $item);
  $self->{length}++;
}

sub forEach {
  my ($self, $cb) = @_;

  foreach my $item (@{$self->{items}}) {
    $cb->($item);
  }
}

sub filter {
  my ($self, $cb) = @_;

  my $filtered = __PACKAGE__->new();
  $self->forEach(sub {
    my $item = shift;
    $filtered->push($item) if ($cb->($item));
  });

  return $filtered;
}

sub clear {
  my $self = shift;

  $self->{items} = [];
  $self->{length} = 0;
}

sub clone {
  return __PACKAGE__->new(shift->{items});
}

sub toNative {
  return @{shift->{array}};
}

1;

__END__

=head1 NAME

Array -

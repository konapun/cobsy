package Cobsy::Core::Hash;

use strict;
use Clone;

sub new {
	my $package = shift;
	my $items = shift; # a hashref

	return bless {
		items => $items || {},
	}, $package;
}

sub has {
	my ($self, $key) = @_;

	return defined $self->{items}->{$key};
}

sub set {
	my ($self, $key, $value) = @_;

	$self->{items}->{$key} = $value;
}

sub get {
	my ($self, $key) = @_;

	die "No such key \"$key\"" unless $self->has($key);
	return $self->{items}->{$key};
}

sub keys {
	my $self = shift;

	return keys %{$self->{items}};
}

sub values {
	my $self = shift;

	return values %{$self->{items}};
}

sub remove {
	my ($self, $key) = @_;

	die "No such key \"$key\"" unless $self->has($key);
	return delete $self->{items}->{$key};
}

sub merge {
  my ($self, $hash) = @_;

  my $merged = $self->clone();
  $hash->each(sub {
    my ($key, $val) = @_;

    $merged->set($key, $val);
  });

  return $merged;
}

sub clone {
	my ($self, $deep) = @_;
	$deep = 0 unless defined $deep; # shallow copy by default

	my $items = $deep ? Clone::clone($self->{items}) : {%{$self->{items}}};
	return __PACKAGE__->new($items);
}

sub clear {
	shift->{items} = {};
}

sub each {
  my ($self, $cb) = @_;

  while (my ($key, $val) = each %{$self->{items}}) {
    $cb->($key, $val);
  }
}

sub toNative {
  return %{shift->{items}};
}

# Allow block setting
sub configure {
	my ($self, $hashref) = @_;

	while (my ($key, $val) = each(%$hashref)) {
		$self->set($key, $val);
	}
}

#sub sort(&@){
#	my $self = shift;
#	my $block = \&{shift @_};
#
#
#}

1;

__END__

#!/usr/bin/perl

use lib '../lib';
use Test::Hash;
use Cobsy::Core::Hash::Ordered;

my $orderedHash = Cobsy::Core::Hash::Ordered->new();
$orderedHash->set('one', 1);
$orderedHash->set('two', 2);
$orderedHash->set('three', 3);
$orderedHash->set('four', 4);
$orderedHash->set('five', 5);

print "$_\n" foreach $orderedHash->keys();
print "\n";
print "$_\n" foreach $orderedHash->values();
print "\n";
print "Value for 'one': " . $orderedHash->get('one') . "\n";

$orderedHash->remove('three');
$orderedHash->set('six', 6);
$orderedHash->set('one', '1!');
print "$_\n" foreach $orderedHash->keys();
print "\n";
print "$_\n" foreach $orderedHash->values();
print "\n";

$orderedHash->each(sub {
  my ($key, $val) = @_;

  print "($key, $val)\n";
});
print "\n";

my $clone = $orderedHash->clone(1);
$clone->set('one', 'destructive set one');
print "$_\n" foreach $clone->values();
print "\n";
print "$_\n" foreach $orderedHash->values();
print "\n";

my $sorted = $orderedHash->sort(sub { print "Got $a and $b\n" });

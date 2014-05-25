#!/usr/bin/perl

use strict;
use lib '../lib';

use Cobsy;
use Test::Getter;
use Test::Greeter;

my $object = Cobsy::Object->new();
my $getter = Test::Getter->new();

$getter->install($object);
print "Name: " . $object->get('name') . "\n";

my $object2 = $object->extend([
  'Test::Greeter'
]);
$object2->greet();

print "Done\n";

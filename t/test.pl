#!/usr/bin/perl

use strict;
use lib '../lib';

use Cobsy;
use Test::Insulter;
use Test::Getter;
use Test::Greeter;
use Test::Named;
use Test::Health;
use Test::Evented;

my $object = Cobsy::Object->new();
my $insulter = Test::Insulter->new();

$insulter->install($object);

$object->insult();

my $object2 = $object->extend([
  'Test::Greeter'
]);
$object2->greet();

my $object3 = $object2->extend([
  'Test::Health'
]);
$object3->takeDamage(20);
print "HP: " . $object3->getHealth() . "\n";
$object3->greet();

my $object4 = $object3->extend([
  'Test::Evented'
]);
$object4->greet();

print "Done\n";

#!/usr/bin/perl

use strict;
use lib '../lib';

use Cobsy;
use Test::Insulter;
use Test::Getter;
use Test::Greeter;
use Test::Named;

my $object = Cobsy::Object->new();
my $insulter = Test::Insulter->new();

$insulter->install($object);

$object->insult();

my $object2 = $object->extend([
  'Test::Greeter'
]);

#$object2->greet();

my $greeter = Test::Greeter->new();
$greeter->install($object2);
$object2->greet();

print "Done\n";

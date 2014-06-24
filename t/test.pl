#!/usr/bin/perl

use strict;
use lib '../lib';
use Cobsy;
use Test::Insulter;

my $obj = Cobsy::Object->new([
  'Test::Evented'
]);

$obj->on('test', sub {
  print "Got test!\n";
});
$obj->trigger('test');

my $object = Cobsy::Object->new();
my $insulter = Test::Insulter->new();

$insulter->install($object);

$object->insult();

my $object2 = $object->extend([
  'Test::Greeter'
]);

$object2->greet();
print "After greet\n";

my $object3 = $object2->extend([
  'Test::Health'
]);
print "Setting name to Badguy\n";
$object3->set('name', 'Badguy');

$object3->takeDamage(20);
print "HP: " . $object3->getHealth() . "\n";
print "Object3: ";
$object3->greet();
print "Object2: ";
$object2->greet();


my $object4 = $object3->extend({
  'Test::Named' => 'argument',
  'Test::Aged'  => [100]
});
$object4->greet();
print "Got age " . $object4->getAge() . "\n";

my $object5 = $object4->extend([
  'Test::Evented'
]);
$object5->greet();

print "Done\n";

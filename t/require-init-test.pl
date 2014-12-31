#!/usr/bin/perl

use strict;
use Test::AgeComponent;
use Test::AgeUserComponent;
use Cobsy;

my $object = Cobsy::Object->new({
  'Test::AgeUserComponent' => 16,
  'Test::NameComponent' => ['Edward']
});

$object->sayAge();
print $object->getName() . "\n";

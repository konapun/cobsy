#!/usr/bin/perl

use strict;
use lib '../lib';
use Cobsy;

# No initializers
my $obj = Cobsy::Object->new('TestTmp::Aged');
my $obj2 = $obj->extend('TestTmp::Named');
my $obj3 = $obj2->extend('TestTmp::Guy');

printBlock("Obj1", sub {
  print "Age: " . $obj->getAge() . "\n";
});
printBlock("Obj2", sub {
  print "Age: " . $obj2->getAge() . "\n";
  print "Name: " . $obj2->getName() . "\n";
});
printBlock("Obj3", sub {
  print "Age: " . $obj3->getAge() . "\n";
  print "Name: " . $obj3->getName() . "\n";
});

# With initializers
my $obj4 = Cobsy::Object->new({
  'TestTmp::Aged' => 120
});
my $obj5 = $obj4->extend({ # This should retain the age from above
  'TestTmp::Named' => 'Cobsy'
});
my $obj6 = $obj4->extend({
  'TestTmp::Guy'
});

printBlock("Obj4", sub {
  print "Age: " . $obj4->getAge() . "\n";
});
printBlock("Obj5", sub {
  print "Age: " . $obj5->getAge() . "\n";
  print "Name: " . $obj5->getName() . "\n";
});
printBlock("Obj6", sub {
  print "Age: " . $obj6->getAge() . "\n";
  print "Name: " . $obj6->getName() . "\n";
});

sub printBlock {
  my ($name, $sub) = @_;

  print $name . ":\n";
  print "-----------\n";
  $sub->();
  print "\n";
}

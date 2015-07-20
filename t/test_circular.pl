#!/usr/bin/perl

use strict;
use lib '../lib';
use Cobsy;

# No initializers
my $obj = Cobsy::Object->new('TestTmp::Circular1');
print "Passed\n";

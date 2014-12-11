#!/usr/bin/perl

use strict;
use lib '../lib';
use Cobsy;
use Test::Again::SuperAwesomeComponent;

my $component = Test::Again::SuperAwesomeComponent->new();
print "Component registers as " . $component->registersAs() . "\n";

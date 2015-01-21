#!/usr/bin/perl

use strict;
use lib '../';
use Cobsy;

my $test = Cobsy::Object->new({
  'Test::Priority1' => [],
  'Test::Priority2' => []
});

my $test2 = Cobsy::Object->new([
  'Test::Priority2', # even though this is listed first, it should load second because it has higher priority
  'Test::Priority1'
]);

$test->doThing();
$test2->doThing();

# http://www.slideshare.net/tudorconstantin/perl-behavior-driven-development slide 13
Given qw(an object being cloned), func($c) {
  use_ok($1);
  my $obj = Cobsy::Object->new($1);
  ok($obj, 'Object created');
  ok($c->stash('feature')->('obj'), 'Got our Cobsy::Object');
};

When qw(I call clone), func($c) {

}

package Cobsy::Component;

use strict;

sub registersAs {
  die "Component must choose a registration name";
}

1;

###########

my $obj = Cobsy::Object->new();
my $extended = $obj->extend(['Test::Component::Tester']);
my $extended2 = $extended->contract(['Test::Component::Tester']);

###########

package Cobsy::Object;

use strict;

sub new {
  my $package = shift;
  
  # ...
  return bless {
    methods    => {
      {
        method => undef,
        fromPackage => undef
      }
    },
    attributes => {}
  }, $package;
}

sub extend {
  
}

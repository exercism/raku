use v6;
use Test;
use lib './';

BEGIN {
    plan 7;

    my @files = <Example Robot>;
    my $file = @files.grep({ ( $_ ~ '.pm' ).IO.f })[0] 
        or exit flunk "neither " ~ ( @files.map({ $_ ~ '.pm' }).join( ' or ' ) ) ~ ' found';
    EVAL( 'use ' ~ $file );
    pass 'Load module';
}

ok Robot.can('name'), 'Robot class has name attribute';
ok Robot.can('reset_name'), 'Robot class has reset_name method';

my $robot = Robot.new;
my $name = $robot.name;

like $name, /^^<[A..Z]>**2 <[0..9]>**3$$/, 'Name should match schema';
is $name, $robot.name, 'Name should be persistent';
ok $robot.name ne Robot.new.name, 'Robots should have different names';

$robot.reset_name;

ok $robot.name ne $name, 'reset_name should change the robot name';

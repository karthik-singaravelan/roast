use v6;
use Test;
plan 53;

#L<S12/Built-in Enumerations/"Two built-in enumerations are">

# tests True and False are Bool's
isa-ok(Bool::True, Bool);
isa-ok(Bool::False, Bool);

# tests they keep their Bool'ness when stored
my $a = Bool::True;
isa-ok($a, Bool);

$a = Bool::False;
isa-ok($a, Bool);

# tests that Bool.Bool works
isa-ok (Bool::True).Bool, Bool, "Bool.Bool is a Bool";
isa-ok (Bool::False).Bool, Bool, "Bool.Bool is a Bool";
is (Bool::True).Bool, Bool::True, "Bool.Bool works for True";
is (Bool::False).Bool, Bool::False, "Bool.Bool works for False";

# tests that ?Bool works
isa-ok ?(Bool::True), Bool, "?Bool is a Bool";
isa-ok ?(Bool::False), Bool, "?Bool is a Bool";
is ?(Bool::True), Bool::True, "?Bool works for True";
is ?(Bool::False), Bool::False, "?Bool works for False";

# tests they work with && and ||
Bool::True  && pass('True works');
Bool::False || pass('False works');

# tests they work with !
!Bool::True  || pass('!True works');
!Bool::False && pass('!False works');

# tests True with ok()
ok(Bool::True, 'True works');

# tests False with ok() and !
ok(!Bool::False, 'False works');

# tests Bool stringification - interaction with ~
isa-ok(~Bool::True, Str);
isa-ok(~Bool::False, Str);
is(~Bool::True, 'True', 'Bool stringification (True)');
is(~Bool::False, 'False', 'Bool stringification (False)');
is Bool::True.Str, 'True', 'True.Str';
is Bool::False.Str, 'False', 'False.Str';
is Bool::True.gist, 'True', 'True.gist';
is Bool::False.gist, 'False', 'False.gist';
is Bool::True.perl, 'Bool::True', 'True.perl';
is Bool::False.perl, 'Bool::False', 'False.perl';

# numification - interaction with +
ok(+Bool::True ~~ Numeric);
ok(+Bool::False ~~ Numeric);
isa-ok(+Bool::True, Int, 'True numifies to an Int');
isa-ok(+Bool::False, Int, 'False numifies to an Int');

ok(Bool::True.Int == 1, 'True Intifies to 1');
ok(Bool::False.Int == 0, 'False Intifies to 0');

is(+Bool::True, '1', 'True numifies to 1');
is(+Bool::False, '0', 'False numifies to 0');

# Arithmetic operations
my $bool = Bool::False;
is(++$bool, Bool::True, 'Increment of Bool::False produces Bool::True');
is(++$bool, Bool::True, 'Increment of Bool::True still produces Bool::True');
is(--$bool, Bool::False, 'Decrement of Bool::True produces Bool::False');
is(--$bool, Bool::False, 'Decrement of Bool::False produces Bool::False');

# RT #65514
{
    ok (0 but Bool::True), 'Bool::True works with "but"';
    is (0 but Bool::True), 0, 'Bool::True works with "but"';
    ok !('RT65514' but Bool::False), 'Bool::False works with "but"';
    is ('RT65514' but Bool::False), 'RT65514', 'Bool::False works with "but"';
}

{
    is Bool::True.key, 'True', 'Bool::True.key works (is "True")';
    is Bool::False.key, 'False', 'Bool::False.key works (is "False")';
}

{
    my $x = Bool.pick;
    ok ($x === True || $x === False), 'Bool.pick return True or False';
    is Bool.pick(*).elems, 2, 'Bool.pick(*) returns two elems';;
    my @a = Bool.roll(30);
    ok @a.grep({$_}),  'Bool.roll(30) contains a True';
    ok @a.grep({!$_}), 'Bool.roll(30) contains a False';
    is Bool.roll(*).[^10].elems, 10, 'Bool.roll(*) contains at least 10 elems';

}

# RT #72580
{
    ok True ~~ Int, "True ~~ Int";
    ok Bool ~~ Int, "Bool ~~ Int";
}
# vim: ft=perl6

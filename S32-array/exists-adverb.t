use v6;

use Test;

plan 34;

# L<S02/Names and Variables/:exists>

#-------------------------------------------------------------------------------
# initialisations

my $default = Any;
my $dont    = False;
sub gen_array { (1..10).list }

#-------------------------------------------------------------------------------
# Array

#?pugs skip "no adverbials"
{
    my @a = gen_array;
    is @a.elems, 10, "basic sanity";

    #?niecza 4 skip "no adverbials"
    isa_ok @a[ 3]:exists, Bool, "Bool test for exists single element";
    isa_ok @a[10]:exists, Bool, "Bool test for non-exists single element";
    ok     @a[ 3]:exists,       "Test for exists single element";
    ok   !(@a[10]:exists),      "Test for non-exists single element";

    #?niecza 10 skip "no adverbials"
    ok !(@a[ 9]:!exists),       "Test non-exists with ! single elem 9";
    ok   @a[10]:!exists,        "Test non-exists with ! single elem 10";
    ok !(@a[ 9]:exists(0)),     "Test non-exists with (0) single elem 9";
    ok   @a[10]:exists(0),      "Test non-exists with (0) single elem 10";
    ok !(@a[ 9]:exists(False)), "Test non-exists with (False) single elem 9";
    ok   @a[10]:exists(False),  "Test non-exists with (False) single elem 10";
    ok !(@a[ 9]:exists($dont)), "Test non-exists with (\$dont) single elem 9";
    ok   @a[10]:exists($dont),  "Test non-exists with (\$dont) single elem 10";
    ok   @a[ 9]:exists(1),      "Test exists with (1) single elem 9";
    ok !(@a[10]:exists(1)),     "Test exists with (1) single elem 10";

    is_deeply @a[1,2, 4]:exists,   (True, True, True),   "Test exists TTT";
    is_deeply @a[1,2,10]:exists,   (True, True, False),  "Test exists TTF";
    is_deeply (@a[*]:exists).list, True xx 10,           "Test non-exists T*";
    #?niezca 3 todo "adverbial pairs only used as True"
    is_deeply @a[1,2, 4]:!exists,  (False,False,False),  "Test non-exists FFF";
    is_deeply @a[1,2,10]:!exists,  (False,False,True),   "Test non-exists FFT";
    is_deeply (@a[*]:!exists).list, False xx 10,         "Test non-exists F*";

    #?niezca 6 todo "no combined adverbial pairs"
    is_deeply @a[1,2, 4]:exists:kv,
      (1,True,2,True,4,True),                     "Test exists:kv TTT";
    is_deeply @a[1,2,10]:exists:kv,
      (1,True,2,True),                            "Test exists:kv TT.";
    is_deeply @a[1,2,10]:exists:!kv,
      (1,True,2,True,10,False),                   "Test exists:kv TTF";
    is_deeply @a[1,2, 4]:!exists:kv,
      (1,False,2,False,4,False),                  "Test exists:kv FFF";
    is_deeply @a[1,2,10]:!exists:kv,
      (1,False,2,False),                          "Test exists:kv FF.";
    is_deeply @a[1,2,10]:!exists:!kv,
      (1,False,2,False,10,True),                  "Test exists:kv FFT";

    #?niezca 6 todo "no combined adverbial pairs"
    is_deeply @a[1,2, 4]:exists:p,
      (1=>True,2=>True,4=>True),                    "Test exists:p TTT";
    is_deeply @a[1,2,10]:exists:p,
      (1=>True,2=>True),                            "Test exists:p TT.";
    is_deeply @a[1,2,10]:exists:!p,
      (1=>True,2=>True,10=>False),                  "Test exists:p TTF";
    is_deeply @a[1,2, 4]:!exists:p,
      (1=>False,2=>False,4=>False),                 "Test exists:p FFF";
    is_deeply @a[1,2,10]:!exists:p,
      (1=>False,2=>False),                          "Test exists:p FF.";
    is_deeply @a[1,2,10]:!exists:!p,
      (1=>False,2=>False,10=>True),                 "Test exists:p FFT";

    is @a.elems, 10, "should be untouched";
} #34

# vim: ft=perl6
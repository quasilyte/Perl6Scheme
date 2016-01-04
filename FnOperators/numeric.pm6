use v6;

unit module FnOperators::numeric;

#TODO: add type restrictions to signatures
sub num_eq($a, $b) is export { $a == $b }
sub num_neq($a, $b) is export { $a != $b }
sub num_gt($a, $b) is export { $a > $b }
sub num_gte($a, $b) is export { $a >= $b }
sub num_lt($a, $b) is export { $a < $b }
sub num_lte($a, $b) is export { $a <= $b }

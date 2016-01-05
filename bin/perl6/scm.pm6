use v6;

use Lisp::Scheme::Interpreter;
use Lisp::Scheme::Preprocessor;
use Lisp::Scheme::utils;

sub stringify_elt($elt) {
    given $elt.key {
	when 'sym' { "{$elt.value}" }
	when 'str' { "\"{$elt.value}\"" }
	when 'num' { "{$elt.value}" }
	when 'bool' { $elt.value ?? 'true' !! 'false' }
	when 'list' { '(' ~ stringify_list($elt) ~ ')' }
    }
}

sub stringify_list($list) {
    do for $list.value -> $elt {
	stringify_elt($elt);
    }.join(' ')
}

sub pprint(@exprs) {
    say @exprs.map({
        stringify_elt($_)
    }).join("\n");
}

sub MAIN(Str $script_path, Int :$phase = 3) {
    my $input = slurp $script_path;
    
    given $phase {
	# Grammar parse phase
	when 0 { parse_scheme($input) }
	# Lexical analysis phase
	when 1 { say tokenize_scheme($input) }
	# Preprocessing
	when 2 { pprint(Lisp::Scheme::Preprocessor.new.run(tokenize_scheme($input))) }
	# Interpretation
	when 3 { Lisp::Scheme::Interpreter.new.run(slurp $script_path) }
	default { say "unknown phase given ($phase)" }
    }
    
}

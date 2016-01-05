use v6;

use Lisp::Scheme::Grammar;
use Lisp::Scheme::Tokenizer;
use Lisp::Scheme::Interpreter;

sub MAIN(Str $script_path, Int :$phase = 2) {
    my $input = slurp $script_path;
    
    given $phase {
	# Grammar parse phase
	when 0 { say Lisp::Scheme::Grammar.parse($input) }
	# Lexical analysis phase
	when 1 {
	    say Lisp::Scheme::Grammar.parse(
		$input,
		:actions(Lisp::Scheme::Tokenizer.new)
	    ).made;
	}
	# Interpretation
	when 2 { Lisp::Scheme::Interpreter.new.run(slurp $script_path) }
	default { say "unknown phase given ($phase)" }
    }
    
}

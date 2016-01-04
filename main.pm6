use v6;

unit module Lisp::Core;

use Lisp::Scheme::Interpreter;

sub repl {
    say "[SCHEME REPL]";
    say "   enter `:q` to exit REPL (or press ctrl+c)";

    my $interpreter = Lisp::Scheme::Interpreter.new;

    loop {
	my $input = prompt('>> ');
	last if $input eq ':q';
	say $interpreter.eval($input);
    }
}

repl;

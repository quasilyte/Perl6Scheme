use v6;

use Lisp::Scheme::Interpreter;

sub MAIN(Str $script_path) {
    Lisp::Scheme::Interpreter.new.run(slurp $script_path);
}

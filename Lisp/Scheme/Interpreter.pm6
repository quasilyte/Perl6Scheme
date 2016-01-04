use v6;

unit class Lisp::Scheme::Interpreter;

use Lisp::Core::Grammar;
use Lisp::Core::Tokenizer;
use Lisp::Scheme::Environment;
use Lisp::Scheme::Closure;
use FnOperators::numeric;

sub apply_op(@args, &op) {
    my $subject = eval_node(@args[0]);
    for @args[1..*] -> $arg {
	return True if &op(eval_node($arg), $subject);
    }
    False
}

# There is no any mistakes, gt & lt are shuffled on purpose (see apply_op)
sub op_eq(@args) { !apply_op(@args, &num_neq) }
sub op_gt(@args) { apply_op(@args, &num_lt) }
sub op_gte(@args) { apply_op(@args, &num_lte) }
sub op_lt(@args) { apply_op(@args, &num_gt) }
sub op_lte(@args) { apply_op(@args, &num_gte) }

my $env = Lisp::Scheme::Environment.new;

sub find(@elts, &predicate) {
    for @elts -> $elt {
	if &predicate($elt) { return True }
    }
    False
}

sub proc_and(@args) {
    find(@args, { !eval_node($_) }) ?? False !! True
}

sub proc_or(@args) {
    find(@args, { ?eval_node($_) }) ?? True !! False
}

sub proc_if(@args) {
    return eval_node(@args[?eval_node(@args[0]) ?? 1 !! 2]);
}

sub op_add(@operands) { [+] @operands.map(&eval_node) }
sub op_sub(@operands) { [-] @operands.map(&eval_node) }
sub op_mul(@operands) { [*] @operands.map(&eval_node) }
sub op_div(@operands) { [/] @operands.map(&eval_node) }

my %builtins = Map.new(
    # Conditionals
    'and', &proc_and,
    'or', &proc_or,
    'if', &proc_if,
    # Special forms
    'quote', -> @quoted_body {
	die 'cant quote yet';
    },
    'define', -> @args {
	$env.put((@args[0].value => eval_node(@args[1])));
    },
    'lambda', -> @args {
	Lisp::Scheme::Closure.new(
	    exprs => @args[1..*],
	    params => @args[0].value.map(*.value)
	)
    },
    'apply', -> @args {
	eval_fncall(@args[0].value, @args[1].value[1..*])
    },
    'set!', -> @args {
	$env.set(@args[0].value, eval_node(@args[1]));
    },
    # List operations
    'list', -> @elts { @elts.map(&eval_node) },
    'car', -> @list { eval_node(@list[0]).first },
    'cdr', -> @list { eval_node(@list[0])[1..*] },
    'cons', -> @pair { (eval_node(@pair[0]) => eval_node(@pair[1])) },
    # Predefined procedures
    'display', -> @args {
	say eval_node(@args[0]);
    },
    # Numerical operations
    '+', &op_add,
    '-', &op_sub,
    '*', &op_mul,
    '/', &op_div,
    # Numerical comparisons
    '=', &op_eq,
    '>', &op_gt,
    '>=', &op_gte,
    '<', &op_lt, # < This line brokes syntax highlighting..
    '<=', &op_lte
);

sub tokenize(Str $input) {
    Lisp::Core::Grammar.parse(
	$input,
    	:actions(Lisp::Core::Tokenizer.new())
    ).made
}

method run(Str $program) {
    for tokenize($program) -> $node {
	eval_node($node);
    }
}

method eval(Str $program) {
    eval_node(tokenize($program)[0])
}

#TODO: implement TCO
sub apply_proc($closure, @params) {
    $env.push_frame($closure.params, @params.map(&eval_node));
    my $result;
    
    for $closure.exprs -> $expr {
	$result = eval_node($expr);
    }
    
    $env.pop_frame;
    $result
}

sub eval_node(Pair $node) {
    given $node.key {
	when 'list' {
	    return eval_list($node.value);
	}
	when 'sym' {
	    return $env.get($node.value);
	}
	when 'num' | 'str' | 'bool' {
	    return $node.value;
	}
	default {
	    say "unknown type: {$node.key}";
	}
    }
}

sub eval_fncall($name, @args) {
    my $builtin_proc = %builtins{$name};

    if $builtin_proc {
	return $builtin_proc(@args);
    } else {
	return apply_proc($env.get($name), (@args));
    }
}

sub eval_list(Seq $elts) {
    if 'list' eq $elts[0].key {
	return apply_proc(eval_node($elts[0]), ($elts[1..*]));
    }

    eval_fncall($elts[0].value, $elts[1..*])
}

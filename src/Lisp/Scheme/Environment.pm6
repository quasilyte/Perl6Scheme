use v6;

unit class Lisp::Scheme::Environment;

has %!pockets = {};
has Array @!frames = [];

method frame {
    return-rw @!frames[@!frames.elems - 1]
}

method dump {
    say "  -- {@!frames.elems} frames, {%!pockets.elems} bindings --";
    say @!frames.elems ?? "frame: {@!frames}" !! 'frame: global';
    say %!pockets;
}

method push_frame(@keys, @vals) {
    # Create and deploy a new frame
    @!frames.push([]);
    
    # Fill new frame with given bindings
    for @keys.kv -> $n, $key {
	self.put(($key => @vals[$n]));
    }
}

method pop_frame {
    # Cleanup: remove all variables bound by dropped frame
    for @!frames.pop.values -> $key {
	%!pockets{$key}.pop();
    }
}

method get(Str $key) {
    return %!pockets{$key}[*-1];
}

method put(Pair $node) {
    if @!frames.elems {
	self.frame.push($node.key);
    }
    
    my $pocket := %!pockets{$node.key};
    
    if $pocket {
	$pocket.push($node.value);
    } else {
	$pocket = [$node.value];
    }

    return $pocket;
}

method set(Str $key, $value) { 
    %!pockets{$key}[*-1] = $value;
}

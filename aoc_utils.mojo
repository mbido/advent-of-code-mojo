from time import perf_counter_ns, perf_counter

fn char_code(char: String) -> Codepoint:
    # Give the Codepoint of a single char String.
    iterator = char.codepoints()
    return iterator.__next__()

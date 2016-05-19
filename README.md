# Test2::Plugin::SubOnly [![Build Status](https://secure.travis-ci.org/plicease/Test2-Plugin-SubOnly.png)](http://travis-ci.org/plicease/Test2-Plugin-SubOnly)

Skip all but select subtests

# SYNOPSIS

    # test only the second and third subtest
    % perl -MTest2::Plugin::SubOnly=2 t/foo.t

# DESCRIPTION

This plugin skips all but specific subtests in a test.
This is helpful if you have a long running test file
where all the subtests are independent, and you are
working on a specific subtest.

This probably violates the spirit, or the rule of the
[Test2::API](https://metacpan.org/pod/Test2::API).  As such it may not work with all tools,
and it may break when changes happen in the [Test2](https://metacpan.org/pod/Test2)
internals.

# SEE ALSO

- [Test2](https://metacpan.org/pod/Test2)
- [Test2::API](https://metacpan.org/pod/Test2::API)
- [Test2::Tools::Subtest](https://metacpan.org/pod/Test2::Tools::Subtest)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
